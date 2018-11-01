//
//  JSONLog.m
//  GCDExtension
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018 mac. All rights reserved.
//

#ifdef DEBUG

#import "JSONLog.h"
#import <objc/runtime.h>

static inline void swizzleSelector(Class class, SEL originalSelector, SEL targetSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, targetSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, targetSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static inline void emptyMethod(id self, SEL _cmd) {
    
}

@implementation NSObject (JSONLog)

- (NSString *)convertToJsonString {
    if (![NSJSONSerialization isValidJSONObject:self])  return nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted  error:&error];
    if (error || !jsonData)
        return nil;
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end

@implementation NSDictionary (JSONLog)

- (NSString *)json_descriptionWithLocale:(id)locale {
    NSString *result = [self convertToJsonString];
    if (!result)
        return [self json_descriptionWithLocale:locale];
    return result;
}

- (NSString *)json_descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSString *result = [self convertToJsonString];
    if (!result)
        return [self json_descriptionWithLocale:locale indent:level];
    return result;
}

- (NSString *)jsonlog_debugDescription{
    NSString *result = [self convertToJsonString];
    if (!result)
        return [self jsonlog_debugDescription];
    return result;
}

+ (void)load {
    [self onceExecute];
}

+ (void)onceExecute {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    Class class = [self class];
    swizzleSelector(class, @selector(descriptionWithLocale:), @selector(json_descriptionWithLocale:));
    swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(json_descriptionWithLocale:indent:));
    swizzleSelector(class, @selector(debugDescription), @selector(jsonlog_debugDescription));
    
    Method source = class_getClassMethod(self, _cmd);
    method_setImplementation(source, (IMP)emptyMethod);
    dispatch_semaphore_signal(semaphore);
}

@end

@implementation NSArray (JSONLog)

- (NSString *)json_descriptionWithLocale:(id)locale {
    NSString *result = [self convertToJsonString];
    if (!result)
        return [self json_descriptionWithLocale:locale];
    return result;
}

- (NSString *)json_descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSString *result = [self convertToJsonString];
    if (!result)
        return [self json_descriptionWithLocale:locale indent:level];
    return result;
}

- (NSString *)jsonlog_debugDescription {
    NSString *result = [self convertToJsonString];
    if (!result)
        return [self jsonlog_debugDescription];
    return result;
}

+ (void)load {
    [self onceExecute];
}

+ (void)onceExecute {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    Class class = [self class];
    swizzleSelector(class, @selector(descriptionWithLocale:), @selector(json_descriptionWithLocale:));
    swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(json_descriptionWithLocale:indent:));
    swizzleSelector(class, @selector(debugDescription), @selector(jsonlog_debugDescription));
    
    Method source = class_getClassMethod(self, _cmd);
    method_setImplementation(source, (IMP)emptyMethod);
    dispatch_semaphore_signal(semaphore);
}

@end



#endif
