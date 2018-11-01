//
//  UITableViewHeaderFooterView+IndexPath.m
//  Demo
//
//  Created by LiChunYang on 4/9/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "UITableViewHeaderFooterView+IndexPath.h"
#import <objc/runtime.h>
#import <RSSwizzle/RSSwizzle.h>

__weak static UITableView * __attachTableView;

@implementation UITableViewHeaderFooterView (IndexPath)

+ (void)load {
    [self safeOnceExecute];
}

+ (void)safeOnceExecute {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    SEL selector = NSSelectorFromString(@"dealloc");
    [RSSwizzle swizzleInstanceMethod:selector inClass:[self class] newImpFactory:^id(RSSwizzleInfo *swizzleInfo) {
        return ^(__unsafe_unretained id self) {
            void (*OriginalIMP)(__unsafe_unretained id, SEL);
            OriginalIMP = (__typeof(OriginalIMP))[swizzleInfo getOriginalImplementation];
            objc_setAssociatedObject(self, @selector(section), nil, OBJC_ASSOCIATION_ASSIGN);
            OriginalIMP(self, selector);
        };
    } mode:(RSSwizzleModeAlways) key:NULL];
    method_setImplementation(class_getClassMethod(self, _cmd), (IMP)emptyMethod);
    dispatch_semaphore_signal(semaphore);
}

static inline void emptyMethod(id self, SEL selector) {
    
}

- (void)setSection:(NSInteger)section {
    objc_setAssociatedObject(self, @selector(section), @(section), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)section {
    return objc_getAssociatedObject(self, _cmd) != nil ? [objc_getAssociatedObject(self, _cmd) integerValue] : -1;
}

+ (void)setAttachTableView:(UITableView *)attachTableView {
    __attachTableView = attachTableView;
}

+ (UITableView *)attachTableView {
    return __attachTableView;
}

- (UITableView *)attachTableView {
    return __attachTableView;
}

@end
