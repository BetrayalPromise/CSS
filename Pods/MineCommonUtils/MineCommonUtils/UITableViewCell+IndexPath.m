//
//  UITableViewCell+IndexPath.m
//  Demo
//
//  Created by LiChunYang on 4/9/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "UITableViewCell+IndexPath.h"
#import <objc/runtime.h>
#import <RSSwizzle/RSSwizzle.h>

__weak static UITableView * __attachTableView;

@implementation UITableViewCell (IndexPath)

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
            objc_setAssociatedObject(self, @selector(indexPath), nil, OBJC_ASSOCIATION_ASSIGN);
            OriginalIMP(self, selector);
        };
    } mode:(RSSwizzleModeAlways) key:NULL];
    method_setImplementation(class_getClassMethod(self, _cmd), (IMP)emptyMethod);
    dispatch_semaphore_signal(semaphore);
}

static inline void emptyMethod(id self, SEL selector) {
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, @selector(indexPath), indexPath, OBJC_ASSOCIATION_ASSIGN);
}

- (NSIndexPath *)indexPath {
    return objc_getAssociatedObject(self, _cmd);
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
