//
//  UIView+CoverScope.m
//  Position
//
//  Created by 李阳 on 17/3/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "UIView+CoverScope.h"

@implementation UIView (CoverScope)

@end

extern BOOL styleX(void) {
    CGFloat width = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width);
    CGFloat height = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height);
    if ((width == 375 && height == 812) || (width == 414 && height == 896)) {
        return YES;
    }
    return NO;
}

extern UIEdgeInsets windowSafeAreaInset(void) {
    if (@available(iOS 11.0, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

extern UIEdgeInsets controllerSafeInset(SafeAreaScope scopes, ...) {
    NSUInteger value = 0;
    if (scopes) {
        value += scopes;
        va_list args;
        SafeAreaScope arg;
        va_start(args, scopes);
        while ((arg = va_arg(args, SafeAreaScope))) {
            value += arg;
        }
        va_end(args);
    }
    UIEdgeInsets edge = windowSafeAreaInset();
    if (value == 0) {
        return edge;
    } else if (value == 1) {
        return UIEdgeInsetsMake(edge.top + 44, edge.left, edge.bottom, edge.right);
    } else if (value == 2) {
        return UIEdgeInsetsMake(edge.top, edge.left, edge.bottom + 49, edge.right);
    } else if (value == 3) {
        return UIEdgeInsetsMake(edge.top + 44, edge.left, edge.bottom + 49, edge.right);
    } else {
        assert(false);
        return UIEdgeInsetsZero;
    }
}

