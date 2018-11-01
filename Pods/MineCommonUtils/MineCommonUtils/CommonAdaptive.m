//
//  CommonAdaptive.m
//  BestLayout
//
//  Created by 李阳 on 23/1/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "CommonAdaptive.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIScreen.h>

static CGSize deviceSize(void);

static Design standard_design_template = Design_375;

extern void setTemplate(Design dsign) {
    standard_design_template = dsign;
}

static CGSize deviceSize() {
    CGFloat currentWidth = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width);
    CGFloat currentHight = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height);
    return CGSizeMake(currentWidth, currentHight);
}

extern CGFloat widgetAdaptive(CGFloat design, void(^closure)(LogicSize * s)) {
    LogicSize * ls = (LogicSize *)malloc(sizeof(LogicSize));
    ls->size_320 = ls->size_375 = ls->size_414 = 0;
    closure(ls);
    if (ls->size_320 == 0 || ls->size_375 == 0 || ls->size_414 == 0) {
        assert(false);
    }
    CGSize size = deviceSize();
    if (standard_design_template == Design_320) {
        if (size.width == 320) {
            return design * 1.0 * ls->size_320 / 320;
        } else if (size.width == 375) {
            return design * 1.0 * ls->size_375 / 320;
        } else if (size.width == 414) {
            return design * 1.0 * ls->size_414 / 320;
        } else if (size.width == 768 || size.width == 834 || size.width == 1024) {
            return design;
        } else {
            assert(false);
            return 0.0;
        }
    } else if (standard_design_template == Design_375) {
        if (size.width == 320) {
            return design * 1.0 * ls->size_320 / 375;
        } else if (size.width == 375) {
            return design * 1.0 * ls->size_375 / 375;
        } else if (size.width == 414) {
            return design * 1.0 * ls->size_414 / 375;
        } else if (size.width == 768 || size.width == 834 || size.width == 1024) {
            return design;
        } else {
            assert(false);
            return 0.0;
        }
    } else if (standard_design_template == Design_414) {
        if (size.width == 320) {
            return design * 1.0 * ls->size_320 / 414;
        } else if (size.width == 375) {
            return design * 1.0 * ls->size_375 / 414;
        } else if (size.width == 414) {
            return design * 1.0 * ls->size_414 / 414;
        } else if (size.width == 768 || size.width == 834 || size.width == 1024) {
            return design;
        } else {
            assert(false);
            return 0.0;
        }
    } else {
        assert(false);
        return 0.0;
    }
}
