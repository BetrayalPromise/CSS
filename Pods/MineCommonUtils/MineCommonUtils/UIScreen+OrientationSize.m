//
//  UIScreen+FunctionExtension.m
//  Custom
//
//  Created by 李阳 on 6/7/2016.
//  Copyright © 2016 TuoErJia. All rights reserved.
//

#import "UIScreen+OrientationSize.h"

#pragma mark - OrientationSize
@implementation UIScreen (OrientationSize)

+ (CGSize)currentAbsoluteSize {
    CGFloat currentWidth = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width);

    CGFloat currentHight = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height);
    return CGSizeMake(currentWidth, currentHight);
}

+ (CGSize)currentRelativeSize {
    return [UIScreen mainScreen].bounds.size;
}

@end
