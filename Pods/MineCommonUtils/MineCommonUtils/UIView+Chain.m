//
//  UIView+Chain.m
//  WaveView
//
//  Created by 李阳 on 8/7/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "UIView+Chain.h"
#import <objc/runtime.h>
#import <RSSwizzle/RSSwizzle.h>

@implementation UIView (Chain)

+ (void)load {
    [self safeOnceExecture];
}

+ (void)safeOnceExecture {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    Class class = self;
    Method originMethod = class_getInstanceMethod(class, @selector(hitTest:withEvent:));
    Method targetMethod = class_getInstanceMethod(class, @selector(exchange_hitTest:withEvent:));
    if (!originMethod || !targetMethod) {
        NSLog(@"交换失败");
        return;
    }
    BOOL didAddMethod = class_addMethod(class,@selector(hitTest:withEvent:), method_getImplementation(targetMethod), method_getTypeEncoding(targetMethod));
    if (didAddMethod) {
        class_replaceMethod(class,@selector(exchange_hitTest:withEvent:), method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, targetMethod);
    }

    method_setImplementation(class_getClassMethod(self, _cmd), (IMP)emptyMethod);
    dispatch_semaphore_signal(semaphore);
}

static inline void emptyMethod(id self, SEL selector) {
    
}

- (UIView *)exchange_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView * view = [self exchange_hitTest:point withEvent:event];
    if (view) {
        return view;
    } else {
        for (UIView * v in self.subviews) {
            if (v.ableRespose) {
                if (CGRectContainsPoint(v.frame, point)) {
                    return v;
                }
            }
        }
        return nil;
    }
}

- (void)setAbleRespose:(BOOL)ableRespose {
    objc_setAssociatedObject(self, @selector(ableRespose), @(ableRespose), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ableRespose {
    return objc_getAssociatedObject(self, _cmd) != nil ? [objc_getAssociatedObject(self, _cmd) boolValue] : NO;
}

@end
