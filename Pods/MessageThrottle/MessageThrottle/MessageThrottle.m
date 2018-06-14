//
//  MessageThrottle.m
//  MessageThrottle
//
//  Created by 杨萧玉 on 2017/11/04.
//  Copyright © 2017年 杨萧玉. All rights reserved.
//

#import "MessageThrottle.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <pthread.h>

#if !__has_feature(objc_arc)
#error
#endif

static inline BOOL mt_object_isClass(id _Nullable obj) {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0 || __TV_OS_VERSION_MIN_REQUIRED >= __TVOS_9_0 || __WATCH_OS_VERSION_MIN_REQUIRED >= __WATCHOS_2_0 || __MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_10
    return object_isClass(obj);
#else
    if (!obj)
        return NO;
    return obj == [obj class];
#endif
}

Class mt_metaClass(Class cls) {
    if (class_isMetaClass(cls)) {
        return cls;
    }
    return object_getClass(cls);
}

enum {
    BLOCK_HAS_COPY_DISPOSE = (1 << 25),
    BLOCK_HAS_CTOR = (1 << 26), // helpers have C++ code
    BLOCK_IS_GLOBAL = (1 << 28),
    BLOCK_HAS_STRET = (1 << 29), // IFF BLOCK_HAS_SIGNATURE
    BLOCK_HAS_SIGNATURE = (1 << 30),
};

struct _MTBlockDescriptor {
    unsigned long reserved;
    unsigned long size;
    void *rest[1];
};

struct _MTBlock {
    void *isa;
    int flags;
    int reserved;
    void *invoke;
    struct _MTBlockDescriptor *descriptor;
};

static const char *mt_blockMethodSignature(id blockObj) {
    struct _MTBlock *block = (__bridge void *) blockObj;
    struct _MTBlockDescriptor *descriptor = block->descriptor;

    assert(block->flags & BLOCK_HAS_SIGNATURE);

    int index = 0;
    if (block->flags & BLOCK_HAS_COPY_DISPOSE)
        index += 2;

    return descriptor->rest[index];
}

@interface MTDealloc : NSObject

@property (nonatomic) MTRule *rule;
@property (nonatomic) Class cls;
@property (nonatomic) pthread_mutex_t invokeLock;

@end

@implementation MTDealloc

- (void)dealloc {
    SEL selector = NSSelectorFromString(@"discardRule:whenTargetDealloc:");
    ((void (*)(id, SEL, MTRule *, MTDealloc *)) [MTEngine.defaultEngine methodForSelector:selector])(MTEngine.defaultEngine, selector, self.rule, self);
}

@end

@interface MTRule ()

@property (nonatomic) NSTimeInterval lastTimeRequest;
@property (nonatomic) NSInvocation *lastInvocation;

@end

@implementation MTRule

- (instancetype)initWithTarget:(id)target selector:(SEL)selector durationThreshold:(NSTimeInterval)durationThreshold {
    self = [super init];
    if (self) {
        _target = target;
        _selector = selector;
        _durationThreshold = durationThreshold;
        _mode = MTPerformModeDebounce;
        _lastTimeRequest = 0;
        _messageQueue = dispatch_get_main_queue();
    }
    return self;
}

- (BOOL)apply {
    return [MTEngine.defaultEngine applyRule:self];
}

- (BOOL)discard {
    return [MTEngine.defaultEngine discardRule:self];
}

- (MTDealloc *)mt_deallocObject {
    MTDealloc *mtDealloc = objc_getAssociatedObject(self.target, self.selector);
    return mtDealloc;
}

@end

@interface MTEngine ()

@property (nonatomic) NSMapTable<id, NSMutableSet<NSString *> *> *targetSELs;
@property (nonatomic) NSMapTable *aliasSelectorCache;

- (void)discardRule:(MTRule *)rule whenTargetDealloc:(MTDealloc *)mtDealloc;

@end

@implementation MTEngine

static pthread_mutex_t mutex;
static pthread_mutex_t alias_selector_mutex;

+ (instancetype)defaultEngine {
    static dispatch_once_t onceToken;
    static MTEngine *instance;
    dispatch_once(&onceToken, ^{ instance = [MTEngine new]; });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _targetSELs = [NSMapTable weakToStrongObjectsMapTable];
        _aliasSelectorCache = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsOpaqueMemory | NSMapTableObjectPointerPersonality valueOptions:NSPointerFunctionsOpaqueMemory | NSMapTableObjectPointerPersonality];
        pthread_mutex_init(&mutex, NULL);
        pthread_mutex_init(&alias_selector_mutex, NULL);
    }
    return self;
}

- (NSArray<MTRule *> *)allRules {
    pthread_mutex_lock(&mutex);
    NSMutableArray *rules = [NSMutableArray array];
    for (id target in [[self.targetSELs keyEnumerator] allObjects]) {
        NSMutableSet *selectors = [self.targetSELs objectForKey:target];
        for (NSString *selectorName in selectors) {
            MTDealloc *mtDealloc = objc_getAssociatedObject(target, NSSelectorFromString(selectorName));
            [rules addObject:mtDealloc.rule];
        }
    }
    pthread_mutex_unlock(&mutex);
    return [rules copy];
}


/**
 添加 target-selector 记录

 @param selector 方法名
 @param target 对象，类，元类
 */
- (void)addSelector:(SEL)selector onTarget:(id)target {
    if (!target) {
        return;
    }
    NSMutableSet *selectors = [self.targetSELs objectForKey:target];
    if (!selectors) {
        selectors = [NSMutableSet set];
    }
    [selectors addObject:NSStringFromSelector(selector)];
    [self.targetSELs setObject:selectors forKey:target];
}

/**
 移除 target-selector 记录

 @param selector 方法名
 @param target 对象，类，元类
 */
- (void)removeSelector:(SEL)selector onTarget:(id)target {
    if (!target) {
        return;
    }
    NSMutableSet *selectors = [self.targetSELs objectForKey:target];
    if (!selectors) {
        selectors = [NSMutableSet set];
    }
    [selectors removeObject:NSStringFromSelector(selector)];
    [self.targetSELs setObject:selectors forKey:target];
}

/**
 是否存在 target-selector 记录

 @param selector 方法名
 @param target 对象，类，元类
 @return 是否存在记录
 */
- (BOOL)containsSelector:(SEL)selector onTarget:(id)target {
    return [[self.targetSELs objectForKey:target] containsObject:NSStringFromSelector(selector)];
}

/**
 是否存在 target-selector 记录，未指定具体 target，但 target 的类型为 cls 即可

 @param selector 方法名
 @param cls 类
 @return 是否存在记录
 */
- (BOOL)containsSelector:(SEL)selector onTargetsOfClass:(Class)cls {
    for (id target in [[self.targetSELs keyEnumerator] allObjects]) {
        if (!mt_object_isClass(target) && [target isMemberOfClass:cls] && [[self.targetSELs objectForKey:target] containsObject:NSStringFromSelector(selector)]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)applyRule:(MTRule *)rule {
    pthread_mutex_lock(&mutex);
    __block BOOL shouldApply = YES;
    if (mt_checkRuleValid(rule)) {
        for (id target in [[self.targetSELs keyEnumerator] allObjects]) {
            NSMutableSet *selectors = [self.targetSELs objectForKey:target];
            for (NSString *selectorName in selectors) {
                if (sel_isEqual(rule.selector, NSSelectorFromString(selectorName)) && mt_object_isClass(rule.target) && mt_object_isClass(target)) {
                    Class clsA = rule.target;
                    Class clsB = target;
                    shouldApply = !([clsA isSubclassOfClass:clsB] || [clsB isSubclassOfClass:clsA]) && shouldApply;
                    NSCAssert(shouldApply, @"Error: %@ already apply rule in %@. A message can only have one rule per class hierarchy.", selectorName, NSStringFromClass(clsB));
                }
            }
        }
        if (shouldApply) {
            [self addSelector:rule.selector onTarget:rule.target];
            mt_overrideMethod(rule.target, rule.selector);
            mt_configureTargetDealloc(rule);
        }
    } else {
        shouldApply = NO;
    }
    pthread_mutex_unlock(&mutex);
    return shouldApply;
}

- (BOOL)discardRule:(MTRule *)rule {
    pthread_mutex_lock(&mutex);
    BOOL shouldDiscard = NO;
    if (mt_checkRuleValid(rule)) {
        [self removeSelector:rule.selector onTarget:rule.target];
        shouldDiscard = mt_recoverMethod(rule.target, rule.selector);
    }
    pthread_mutex_unlock(&mutex);
    return shouldDiscard;
}

- (void)discardRule:(MTRule *)rule whenTargetDealloc:(MTDealloc *)mtDealloc {
    if (mt_object_isClass(rule.target)) {
        return;
    }
    pthread_mutex_lock(&mutex);
    if (![self containsSelector:rule.selector onTarget:mtDealloc.cls] && ![self containsSelector:rule.selector onTargetsOfClass:mtDealloc.cls]) {
        mt_revertHook(mtDealloc.cls, rule.selector);
    }
    pthread_mutex_unlock(&mutex);
}

#pragma mark - Private Helper

static BOOL mt_checkRuleValid(MTRule *rule) {
    if (rule.target && rule.selector && rule.durationThreshold > 0) {
        NSString *selectorName = NSStringFromSelector(rule.selector);
        if ([selectorName isEqualToString:@"forwardInvocation:"]) {
            return NO;
        }
        Class cls = mt_classOfTarget(rule.target);
        NSString *className = NSStringFromClass(cls);
        if ([className isEqualToString:@"MTRule"] || [className isEqualToString:@"MTEngine"]) {
            return NO;
        }
        return YES;
    }
    return NO;
}

static SEL mt_aliasForSelector(SEL selector) {
    pthread_mutex_lock(&alias_selector_mutex);
    SEL aliasSelector = (__bridge void *) [MTEngine.defaultEngine.aliasSelectorCache objectForKey:(__bridge id)(void *) selector];
    if (!aliasSelector) {
        NSString *selectorName = NSStringFromSelector(selector);
        aliasSelector = NSSelectorFromString([NSString stringWithFormat:@"__mt_%@", selectorName]);
        [MTEngine.defaultEngine.aliasSelectorCache setObject:(__bridge id)(void *) aliasSelector forKey:(__bridge id)(void *) selector];
    }
    pthread_mutex_unlock(&alias_selector_mutex);
    return aliasSelector;
}

static BOOL mt_invokeFilterBlock(MTRule *rule, NSInvocation *originalInvocation) {
    if (!rule.alwaysInvokeBlock || ![rule.alwaysInvokeBlock isKindOfClass:NSClassFromString(@"NSBlock")]) {
        return NO;
    }
    NSMethodSignature *filterBlockSignature = [NSMethodSignature signatureWithObjCTypes:mt_blockMethodSignature(rule.alwaysInvokeBlock)];
    NSInvocation *blockInvocation = [NSInvocation invocationWithMethodSignature:filterBlockSignature];
    NSUInteger numberOfArguments = filterBlockSignature.numberOfArguments;

    if (numberOfArguments > originalInvocation.methodSignature.numberOfArguments) {
        NSLog(@"Block has too many arguments. Not calling %@", rule);
        return NO;
    }

    if (numberOfArguments > 1) {
        [blockInvocation setArgument:&rule atIndex:1];
    }

    void *argBuf = NULL;
    for (NSUInteger idx = 2; idx < numberOfArguments; idx++) {
        const char *type = [originalInvocation.methodSignature getArgumentTypeAtIndex:idx];
        NSUInteger argSize;
        NSGetSizeAndAlignment(type, &argSize, NULL);

        if (!(argBuf = reallocf(argBuf, argSize))) {
            NSLog(@"Failed to allocate memory for block invocation.");
            return NO;
        }

        [originalInvocation getArgument:argBuf atIndex:idx];
        [blockInvocation setArgument:argBuf atIndex:idx];
    }

    [blockInvocation invokeWithTarget:rule.alwaysInvokeBlock];
    BOOL returnedValue = NO;
    [blockInvocation getReturnValue:&returnedValue];

    if (argBuf != NULL) {
        free(argBuf);
    }
    return returnedValue;
}

/**
 处理执行 NSInvocation

 @param invocation NSInvocation 对象
 @param fixedSelector 修正后的 SEL
 */
static void mt_handleInvocation(NSInvocation *invocation, SEL fixedSelector) {
    MTDealloc *mtDealloc = objc_getAssociatedObject(invocation.target, invocation.selector);
    MTRule *rule = mtDealloc.rule;
    if (!rule) {
        MTDealloc *mtDealloc = objc_getAssociatedObject(object_getClass(invocation.target), invocation.selector);
        rule = mtDealloc.rule;
    }

    if (rule.durationThreshold <= 0 || mt_invokeFilterBlock(rule, invocation)) {
        invocation.selector = fixedSelector;
        [invocation invoke];
        return;
    }

    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    switch (rule.mode) {
        case MTPerformModeFirstly:
            if (now - rule.lastTimeRequest > rule.durationThreshold) {
                rule.lastTimeRequest = now;
                invocation.selector = fixedSelector;
                [invocation invoke];
                rule.lastInvocation = nil;
            }
            break;
        case MTPerformModeLast:
            invocation.selector = fixedSelector;
            rule.lastInvocation = invocation;
            [rule.lastInvocation retainArguments];
            if (now - rule.lastTimeRequest > rule.durationThreshold) {
                rule.lastTimeRequest = now;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(rule.durationThreshold * NSEC_PER_SEC)), rule.messageQueue, ^{
                    [rule.lastInvocation invoke];
                    rule.lastInvocation = nil;
                });
            }
            break;
        case MTPerformModeDebounce:
            invocation.selector = fixedSelector;
            rule.lastInvocation = invocation;
            [rule.lastInvocation retainArguments];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(rule.durationThreshold * NSEC_PER_SEC)), rule.messageQueue, ^{
                if (rule.lastInvocation == invocation) {
                    [rule.lastInvocation invoke];
                    rule.lastInvocation = nil;
                }
            });
            break;
    }
}

static void mt_forwardInvocation(__unsafe_unretained id assignSlf, SEL selector, NSInvocation *invocation) {
    SEL originalSelector = invocation.selector;
    SEL fixedOriginalSelector = mt_aliasForSelector(originalSelector);
    if (![assignSlf respondsToSelector:fixedOriginalSelector]) {
        mt_executeOrigForwardInvocation(assignSlf, selector, invocation);
        return;
    }
    MTDealloc *mtDealloc = objc_getAssociatedObject(invocation.target, selector);
    pthread_mutex_t mutex = mtDealloc.invokeLock;
    pthread_mutex_lock(&mutex);
    mt_handleInvocation(invocation, fixedOriginalSelector);
    pthread_mutex_unlock(&mutex);
}

static NSString *const MTForwardInvocationSelectorName = @"__mt_forwardInvocation:";

static Class mt_classOfTarget(id target) {
    Class cls;
    if (mt_object_isClass(target)) {
        cls = target;
    } else {
        cls = object_getClass(target);
    }
    return cls;
}

static void mt_overrideMethod(id target, SEL selector) {
    Class cls = mt_classOfTarget(target);

    Method originMethod = class_getInstanceMethod(cls, selector);
    if (!originMethod) {
        NSCAssert(NO, @"unrecognized selector -%@ for class %@", NSStringFromSelector(selector), NSStringFromClass(cls));
        return;
    }
    const char *originType = (char *) method_getTypeEncoding(originMethod);

    IMP originalImp = class_respondsToSelector(cls, selector) ? class_getMethodImplementation(cls, selector) : NULL;

    IMP msgForwardIMP = _objc_msgForward;
#if !defined(__arm64__)
    if (originType[0] == _C_STRUCT_B) {
        // In some cases that returns struct, we should use the '_stret' API:
        // http://sealiesoftware.com/blog/archive/2008/10/30/objc_explain_objc_msgSend_stret.html
        // As an ugly internal runtime implementation detail in the 32bit runtime, we need to determine of the method we hook returns a struct or anything larger than id.
        // https://developer.apple.com/library/mac/documentation/DeveloperTools/Conceptual/LowLevelABI/000-Introduction/introduction.html
        // https://github.com/ReactiveCocoa/ReactiveCocoa/issues/783
        // http://infocenter.arm.com/help/topic/com.arm.doc.ihi0042e/IHI0042E_aapcs.pdf (Section 5.4)
        // NSMethodSignature knows the detail but has no API to return, we can only get the info from debugDescription.
        NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:originType];
        if ([methodSignature.debugDescription rangeOfString:@"is special struct return? YES"].location != NSNotFound) {
            msgForwardIMP = (IMP) _objc_msgForward_stret;
        }
    }
#endif

    if (originalImp == msgForwardIMP) {
        return;
    }

    if (class_getMethodImplementation(cls, @selector(forwardInvocation:)) != (IMP) mt_forwardInvocation) {
        IMP originalForwardImp = class_replaceMethod(cls, @selector(forwardInvocation:), (IMP) mt_forwardInvocation, "v@:@");
        if (originalForwardImp) {
            class_addMethod(cls, NSSelectorFromString(MTForwardInvocationSelectorName), originalForwardImp, "v@:@");
        }
    }

    if (class_respondsToSelector(cls, selector)) {
        SEL fixedOriginalSelector = mt_aliasForSelector(selector);
        if (!class_respondsToSelector(cls, fixedOriginalSelector)) {
            class_addMethod(cls, fixedOriginalSelector, originalImp, originType);
        }
    }

    // Replace the original selector at last, preventing threading issus when
    // the selector get called during the execution of `overrideMethod`
    class_replaceMethod(cls, selector, msgForwardIMP, originType);
}

static void mt_revertHook(Class cls, SEL selector) {
    if (class_getMethodImplementation(cls, @selector(forwardInvocation:)) == (IMP) mt_forwardInvocation) {
        IMP originalForwardImp = class_getMethodImplementation(cls, NSSelectorFromString(MTForwardInvocationSelectorName));
        if (originalForwardImp) {
            class_replaceMethod(cls, @selector(forwardInvocation:), originalForwardImp, "v@:@");
        }
    } else {
        return;
    }

    Method originMethod = class_getInstanceMethod(cls, selector);
    if (!originMethod) {
        NSCAssert(NO, @"unrecognized selector -%@ for class %@", NSStringFromSelector(selector), NSStringFromClass(cls));
        return;
    }
    const char *originType = (char *) method_getTypeEncoding(originMethod);

    SEL fixedOriginalSelector = mt_aliasForSelector(selector);
    if (class_respondsToSelector(cls, fixedOriginalSelector)) {
        IMP originalImp = class_getMethodImplementation(cls, fixedOriginalSelector);
        class_replaceMethod(cls, selector, originalImp, originType);
    }
}

static BOOL mt_recoverMethod(id target, SEL selector) {
    Class cls;
    if (mt_object_isClass(target)) {
        cls = target;
        if ([MTEngine.defaultEngine containsSelector:selector onTargetsOfClass:cls]) {
            return NO;
        }
    } else {
        cls = object_getClass(target);
        if ([MTEngine.defaultEngine containsSelector:selector onTarget:cls] || [MTEngine.defaultEngine containsSelector:selector onTargetsOfClass:cls]) {
            return NO;
        }
    }
    mt_revertHook(cls, selector);
    return YES;
}

static void mt_executeOrigForwardInvocation(id slf, SEL selector, NSInvocation *invocation) {
    SEL origForwardSelector = NSSelectorFromString(MTForwardInvocationSelectorName);

    if ([slf respondsToSelector:origForwardSelector]) {
        NSMethodSignature *methodSignature = [slf methodSignatureForSelector:origForwardSelector];
        if (!methodSignature) {
            NSCAssert(NO, @"unrecognized selector -%@ for instance %@", NSStringFromSelector(origForwardSelector), slf);
            return;
        }
        NSInvocation *forwardInv = [NSInvocation invocationWithMethodSignature:methodSignature];
        [forwardInv setTarget:slf];
        [forwardInv setSelector:origForwardSelector];
        [forwardInv setArgument:&invocation atIndex:2];
        [forwardInv invoke];
    } else {
        Class superCls = [[slf class] superclass];
        Method superForwardMethod = class_getInstanceMethod(superCls, @selector(forwardInvocation:));
        void (*superForwardIMP)(id, SEL, NSInvocation *);
        superForwardIMP = (void (*)(id, SEL, NSInvocation *)) method_getImplementation(superForwardMethod);
        superForwardIMP(slf, @selector(forwardInvocation:), invocation);
    }
}

static void mt_configureTargetDealloc(MTRule *rule) {
    Class cls = object_getClass(rule.target);
    MTDealloc *mtDealloc = [rule mt_deallocObject];
    if (!mtDealloc) {
        mtDealloc = [MTDealloc new];
        mtDealloc.rule = rule;
        mtDealloc.cls = cls;
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        pthread_mutex_t mutex = mtDealloc.invokeLock;
        pthread_mutex_init(&mutex, &attr);
        objc_setAssociatedObject(rule.target, rule.selector, mtDealloc, OBJC_ASSOCIATION_RETAIN);
    }
}

@end

@implementation NSObject (MessageThrottle)

- (NSArray<MTRule *> *)mt_allRules {
    NSMutableArray<MTRule *> *result = [NSMutableArray array];
    for (MTRule *rule in MTEngine.defaultEngine.allRules) {
        if (rule.target == self || object_getClass(self) == rule.target) {
            [result addObject:rule];
        }
    }
    return [result copy];
}

- (nullable MTRule *)mt_limitSelector:(SEL)selector oncePerDuration:(NSTimeInterval)durationThreshold {
    return [self mt_limitSelector:selector oncePerDuration:durationThreshold usingMode:MTPerformModeDebounce];
}

- (nullable MTRule *)mt_limitSelector:(SEL)selector oncePerDuration:(NSTimeInterval)durationThreshold usingMode:(MTPerformMode)mode {
    return [self mt_limitSelector:selector oncePerDuration:durationThreshold usingMode:mode onMessageQueue:dispatch_get_main_queue()];
}

- (nullable MTRule *)mt_limitSelector:(SEL)selector oncePerDuration:(NSTimeInterval)durationThreshold usingMode:(MTPerformMode)mode onMessageQueue:(dispatch_queue_t)messageQueue {
    return [self mt_limitSelector:selector oncePerDuration:durationThreshold usingMode:mode onMessageQueue:messageQueue alwaysInvokeBlock:nil];
}

- (nullable MTRule *)mt_limitSelector:(SEL)selector oncePerDuration:(NSTimeInterval)durationThreshold usingMode:(MTPerformMode)mode onMessageQueue:(dispatch_queue_t)messageQueue alwaysInvokeBlock:(id)alwaysInvokeBlock {
    MTDealloc *mtDealloc = objc_getAssociatedObject(self, selector);
    MTRule *rule = mtDealloc.rule;
    if (!rule) {
        rule = [[MTRule alloc] initWithTarget:self selector:selector durationThreshold:durationThreshold];
    }
    rule.durationThreshold = durationThreshold;
    rule.mode = mode;
    rule.messageQueue = messageQueue;
    rule.alwaysInvokeBlock = alwaysInvokeBlock;
    return [rule apply] ? rule : nil;
}

@end
