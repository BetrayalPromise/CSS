//
//  UIViewController+SafeAreaView.m
//  Demo
//
//  Created by LiChunYang on 6/9/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "UIViewController+SafeAreaView.h"
#import <objc/runtime.h>

@implementation UIViewController (SafeAreaView)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method origMethod = class_getInstanceMethod([self class], @selector(loadView));
//        SEL origsel = @selector(loadView);
//        Method swizMethod = class_getInstanceMethod([self class], @selector(exchange_loadView));
//        SEL swizsel = @selector(exchange_loadView);
//        BOOL addMehtod = class_addMethod([self class], origsel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
//        if (addMehtod) {
//            class_replaceMethod([self class], swizsel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
//        } else {
//            method_exchangeImplementations(origMethod, swizMethod);
//        }
//    });
//}
//
//- (void)exchange_loadView {
//    [self exchange_loadView];
//    [self safeAreaView];
//}

- (void)setSafeAreaView:(UIView *)safeAreaView {
    objc_setAssociatedObject(self, @selector(safeAreaView), safeAreaView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)safeAreaView {
    UIView * v = objc_getAssociatedObject(self, _cmd);
    if (v) {
        return v;
    } else {
        UIView * v = [UIView new];
        [self.view addSubview:v];
        [self setSafeAreaView:v];
        v.translatesAutoresizingMaskIntoConstraints = NO;
        if (@available(iOS 11.0, *)) {
            [NSLayoutConstraint constraintWithItem:v attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self.view.safeAreaLayoutGuide attribute:(NSLayoutAttributeTop) multiplier:1.0 constant:0.0].active = YES;
            [NSLayoutConstraint constraintWithItem:v attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self.view.safeAreaLayoutGuide attribute:(NSLayoutAttributeLeft) multiplier:1.0 constant:0.0].active = YES;
            [NSLayoutConstraint constraintWithItem:v attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self.view.safeAreaLayoutGuide attribute:(NSLayoutAttributeBottom) multiplier:1.0 constant:0.0].active = YES;
            [NSLayoutConstraint constraintWithItem:v attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self.view.safeAreaLayoutGuide attribute:(NSLayoutAttributeRight) multiplier:1.0 constant:0.0].active = YES;
        } else {
            [NSLayoutConstraint constraintWithItem:v attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self.topLayoutGuide attribute:(NSLayoutAttributeBottom) multiplier:1.0 constant:0.0].active = YES;
            [NSLayoutConstraint constraintWithItem:v attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeLeft) multiplier:1.0 constant:0.0].active = YES;
            [NSLayoutConstraint constraintWithItem:v attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self.bottomLayoutGuide attribute:(NSLayoutAttributeTop) multiplier:1.0 constant:0.0].active = YES;
            [NSLayoutConstraint constraintWithItem:v attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeRight) multiplier:1.0 constant:0.0].active = YES;
        }
        return v;
    }
}

@end
