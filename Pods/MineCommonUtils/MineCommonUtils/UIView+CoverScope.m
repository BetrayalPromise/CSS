//
//  UIView+CoverScope.m
//  Position
//
//  Created by 李阳 on 17/3/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "UIView+CoverScope.h"

@implementation UIView (CoverScope)

- (CGRect)scopeRect:(Scope)scope {
    if ([[self nextResponder] isKindOfClass:[UIViewController class]]) {
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;

        CGRect screenRect = [UIScreen mainScreen].bounds;
        CGRect statusBarRect = [UIApplication sharedApplication].statusBarFrame;
        CGRect navigationBarRect = ((UIViewController *) [self nextResponder]).navigationController.navigationBar.frame;
        CGRect tabBarRect = ((UIViewController *) [self nextResponder]).tabBarController.tabBar.frame;

        CGFloat currentWidth = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width);
        CGFloat currentHight = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height);

        BOOL isHeteromorphic = NO;
        if (currentWidth == 375 && currentHight == 812) {
            isHeteromorphic = YES;
        } else {
            isHeteromorphic = NO;
        }

        if (UIDeviceOrientationIsPortrait(orientation)) {
            if (scope == ScopeTop) {
                return CGRectMake(0, 0, screenRect.size.width, statusBarRect.size.height + navigationBarRect.size.height);
            } else if (scope == ScopeLeft) {
                return CGRectMake(0, statusBarRect.size.height + navigationBarRect.size.height, 0, screenRect.size.height - (statusBarRect.size.height + navigationBarRect.size.height + tabBarRect.size.height));
            } else if (scope == ScopeBottom) {
                return tabBarRect;
            } else if (scope == ScopeRight) {
                return CGRectMake(screenRect.size.width, statusBarRect.size.height + navigationBarRect.size.height, 0, screenRect.size.height - (statusBarRect.size.height + navigationBarRect.size.height + tabBarRect.size.height));
            } else if (scope == ScopeContent) {
                return CGRectMake(0, statusBarRect.size.height + navigationBarRect.size.height, screenRect.size.width, screenRect.size.height - (statusBarRect.size.height + navigationBarRect.size.height + tabBarRect.size.height));
            } else {
                return CGRectZero;
            }
        } else if (UIDeviceOrientationIsLandscape(orientation)) {
            if (scope == ScopeTop) {
                return CGRectMake(0, 0, screenRect.size.width, statusBarRect.size.height + navigationBarRect.size.height);
            } else if (scope == ScopeLeft) {
                if (isHeteromorphic) {
                    return CGRectMake(0, statusBarRect.size.height + navigationBarRect.size.height, 44, screenRect.size.height - (statusBarRect.size.height + navigationBarRect.size.height + tabBarRect.size.height));
                } else {
                    return CGRectMake(0, statusBarRect.size.height + navigationBarRect.size.height, 0, screenRect.size.height - (statusBarRect.size.height + navigationBarRect.size.height + tabBarRect.size.height));
                }
            } else if (scope == ScopeBottom) {
                return tabBarRect;
            } else if (scope == ScopeRight) {
                if (isHeteromorphic) {
                    return CGRectMake(screenRect.size.width - 44, statusBarRect.size.height + navigationBarRect.size.height, 44, screenRect.size.height - (statusBarRect.size.height + navigationBarRect.size.height + tabBarRect.size.height));
                } else {
                    return CGRectMake(screenRect.size.width, statusBarRect.size.height + navigationBarRect.size.height, 0, screenRect.size.height - (statusBarRect.size.height + navigationBarRect.size.height + tabBarRect.size.height));
                }
            } else if (scope == ScopeContent) {
                if (isHeteromorphic) {
                    return CGRectMake(44, statusBarRect.size.height + navigationBarRect.size.height, screenRect.size.width - 88, screenRect.size.height - (statusBarRect.size.height + navigationBarRect.size.height + tabBarRect.size.height));
                } else {
                    return CGRectMake(0, statusBarRect.size.height + navigationBarRect.size.height, screenRect.size.width, screenRect.size.height - (statusBarRect.size.height + navigationBarRect.size.height + tabBarRect.size.height));
                }
            } else {
                return CGRectZero;
            }
        } else {
            return CGRectZero;
        }
    }
    return CGRectZero;
}

@end
