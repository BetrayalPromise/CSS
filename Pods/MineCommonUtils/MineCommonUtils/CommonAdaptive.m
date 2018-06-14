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

@implementation CommonAdaptive

- (instancetype)init {
    self = [super init];
    if (self) {
        _designTemplate = DesignTemplateInch47;
    }
    return self;
}

+ (instancetype _Nonnull)sharedInstance {
    static dispatch_once_t onceToken;
    static CommonAdaptive *instance = nil;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[[self class] alloc] init];
        }
    });
    return instance;
}

+ (CGFloat)widgetCustomAdaptive:(void (^_Nonnull)(DeviceSize *_Nonnull size))closure {
    CGSize size = [self deviceSize];
    DeviceSize *deviceSize = [DeviceSize new];
    closure(deviceSize);
    NSAssert(deviceSize.inch35 != -MAXFLOAT, @"size 35 must be set");
    NSAssert(deviceSize.inch40 != -MAXFLOAT, @"size 40 must be set");
    NSAssert(deviceSize.inch47 != -MAXFLOAT, @"size 47 must be set");
    NSAssert(deviceSize.inch55 != -MAXFLOAT, @"size 55 must be set");
    NSAssert(deviceSize.inch58 != -MAXFLOAT, @"size 58 must be set");
    if (size.width == 320 && size.height == 480) {
        return deviceSize.inch35;
    } else if (size.width == 320 && size.height == 568) {
        return deviceSize.inch40;
    } else if (size.width == 375 && size.height == 667) {
        return deviceSize.inch47;
    } else if (size.width == 414 && size.height == 736) {
        return deviceSize.inch55;
    } else if (size.width == 375 && size.height == 812) {
        return deviceSize.inch58;
    }
    NSAssert(NO, @"not support iPhone size");
    return 0;
}

+ (CGSize)deviceSize {
    CGFloat currentWidth = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width);
    CGFloat currentHight = ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height / [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height);
    return CGSizeMake(currentWidth, currentHight);
}

+ (CGFloat)widgetFontAdaptive:(AdaptiveFont)type designSize:(CGFloat)designSize {
    CGSize deviceSize = [self deviceSize];
    CommonAdaptive *adaptive = [CommonAdaptive sharedInstance];
    if (type == AdaptiveFontSelfAdaption) {
        if (adaptive.designTemplate == DesignTemplateInch35 || adaptive.designTemplate == DesignTemplateInch40) {
            if ((deviceSize.width == 320 && deviceSize.height == 480) || (deviceSize.width == 320 && deviceSize.height == 568)) {
                return designSize;
            } else if ((deviceSize.width == 375 && deviceSize.height == 667) || (deviceSize.width == 375 && deviceSize.height == 812)) {
                return designSize + 2.5;
            } else if (deviceSize.width == 414 && deviceSize.height == 736) {
                return designSize + 5;
            }
            NSAssert(NO, @"not support iPhone size");
            return 0.0;
        } else if (adaptive.designTemplate == DesignTemplateInch47 || adaptive.designTemplate == DesignTemplateInch58) {
            if ((deviceSize.width == 320 && deviceSize.height == 480) || (deviceSize.width == 320 && deviceSize.height == 568)) {
                return designSize - 2.5;
            } else if ((deviceSize.width == 375 && deviceSize.height == 667) || (deviceSize.width == 375 && deviceSize.height == 812)) {
                return designSize;
            } else if (deviceSize.width == 414 && deviceSize.height == 736) {
                return designSize + 2.5;
            }
            NSAssert(NO, @"not support iPhone size");
            return 0.0;
        } else if (adaptive.designTemplate == DesignTemplateInch55) {
            if ((deviceSize.width == 320 && deviceSize.height == 480) || (deviceSize.width == 320 && deviceSize.height == 568)) {
                return designSize - 5;
            } else if ((deviceSize.width == 375 && deviceSize.height == 667) || (deviceSize.width == 375 && deviceSize.height == 812)) {
                return designSize - 2.5;
            } else if (deviceSize.width == 414 && deviceSize.height == 736) {
                return designSize;
            }
            NSAssert(NO, @"not support iPhone size");
            return 0.0;
        }
        NSAssert(NO, @"not support iPhone design size");
        return 0.0;
    } else if (type == AdaptiveFontFixation) {
        return designSize;
    } else if (type == AdaptiveFontCommon) {
        if (adaptive.designTemplate == DesignTemplateInch35 || adaptive.designTemplate == DesignTemplateInch40 || adaptive.designTemplate == DesignTemplateInch47) {
            if ((deviceSize.width == 320 && deviceSize.height == 480) || (deviceSize.width == 320 && deviceSize.height == 568) || (deviceSize.width == 375 && deviceSize.height == 667) || (deviceSize.width == 375 && deviceSize.height == 812)) {
                return designSize;
            } else if (deviceSize.width == 414 && deviceSize.height == 736) {
                return designSize * 1.5;
            }
            NSAssert(NO, @"not support iPhone size");
            return 0.0;
        } else if (adaptive.designTemplate == DesignTemplateInch58) {
            if ((deviceSize.width == 320 && deviceSize.height == 480) || (deviceSize.width == 320 && deviceSize.height == 568) || (deviceSize.width == 375 && deviceSize.height == 667) || (deviceSize.width == 375 && deviceSize.height == 812)) {
                return designSize / 1.5;
            } else if (deviceSize.width == 414 && deviceSize.height == 736) {
                return designSize;
            }
            NSAssert(NO, @"not support iPhone size");
            return 0.0;
        }
        NSAssert(NO, @"not support iPhone size");
        return 0.0;
    }
    NSAssert(NO, @"not support iPhone design size");
    return 0.0;
}

+ (CGSize)widge2DimensionAdaptive:(AdaptiveRefer)type designSize:(CGSize)designSize multiply:(CGFloat)multiply minitrim:(CGFloat)minitrim {
    CGSize deviceSize = [self deviceSize];
    CGSize templateSize = [self designTemplateSize];
    NSAssert([self isSupportDeviceSize] != NO, @"unsupport iPhone device size");
    if (type == AdaptiveReferFixation) {
        return designSize;
    } else if (type == AdaptiveReferRatioX) {
        CGFloat w = (designSize.width * deviceSize.width / (1.0 * templateSize.width)) * multiply + minitrim;
        CGFloat h = (designSize.height * deviceSize.width / (1.0 * templateSize.width)) * multiply + minitrim;
        return CGSizeMake(w, h);
    } else if (type == AdaptiveReferRatioY) {
        CGFloat w = (designSize.width * deviceSize.height / (1.0 * templateSize.height)) * multiply + minitrim;
        CGFloat h = (designSize.height * deviceSize.height / (1.0 * templateSize.height)) * multiply + minitrim;
        return CGSizeMake(w, h);
    } else {
        NSAssert(NO, @"not support image adaptive type");
        return CGSizeZero;
    }
}

+ (CGSize)widge2DimensionAdaptive:(AdaptiveRefer)type designSize:(CGSize)designSize multiply:(CGFloat)multiply {
    return [self widge2DimensionAdaptive:type designSize:designSize multiply:multiply minitrim:0.0];
}

+ (CGSize)widge2DimensionAdaptive:(AdaptiveRefer)type designSize:(CGSize)designSize minitrim:(CGFloat)minitrim {
    return [self widge2DimensionAdaptive:type designSize:designSize multiply:1.0 minitrim:minitrim];
}

+ (CGSize)widge2DimensionAdaptive:(AdaptiveRefer)type designSize:(CGSize)designSize {
    return [self widge2DimensionAdaptive:type designSize:designSize multiply:1.0 minitrim:0.0];
}

+ (NSArray<NSValue *> *)iPhonesDeviceSize {
    return @[ @(CGSizeMake(320, 480)), @(CGSizeMake(320, 568)), @(CGSizeMake(375, 667)), @(CGSizeMake(414, 736)), @(CGSizeMake(375, 812)) ];
}

+ (CGFloat)widget1DimensionAdaptive:(AdaptiveRefer)type designMeasure:(CGFloat)designMeasure multiply:(CGFloat)multiply minitrim:(CGFloat)minitrim {
    CGSize deviceSize = [self deviceSize];
    CGSize templateSize = [self designTemplateSize];
    NSAssert([self isSupportDeviceSize] != NO, @"unsupport iPhone device size");
    if (type == AdaptiveReferFixation) {
        return designMeasure * multiply + minitrim;
    } else if (type == AdaptiveReferRatioX) {
        return (designMeasure * deviceSize.width / templateSize.width) * multiply + minitrim;
    } else if (type == AdaptiveReferRatioY) {
        return (designMeasure * deviceSize.height / templateSize.height) * multiply + minitrim;
    } else {
        NSAssert(NO, @"not support image adaptive type");
        return 0.0;
    }
}

+ (CGFloat)widget1DimensionAdaptive:(AdaptiveRefer)type designMeasure:(CGFloat)designMeasure multiply:(CGFloat)multiply {
    return [self widget1DimensionAdaptive:type designMeasure:designMeasure multiply:multiply minitrim:0.0];
}

+ (CGFloat)widget1DimensionAdaptive:(AdaptiveRefer)type designMeasure:(CGFloat)designMeasure minitrim:(CGFloat)minitrim {
    return [self widget1DimensionAdaptive:type designMeasure:designMeasure multiply:1.0 minitrim:minitrim];
}

+ (CGFloat)widget1DimensionAdaptive:(AdaptiveRefer)type designMeasure:(CGFloat)designMeasure {
    return [self widget1DimensionAdaptive:type designMeasure:designMeasure multiply:1.0 minitrim:0.0];
}

/// 设计模版尺寸
+ (CGSize)designTemplateSize {
    CommonAdaptive *adaptive = [CommonAdaptive sharedInstance];
    CGSize templateSize = CGSizeZero;
    if (adaptive.designTemplate == DesignTemplateInch35) {
        templateSize = CGSizeMake(320.0, 480.0);
    } else if (adaptive.designTemplate == DesignTemplateInch40) {
        templateSize = CGSizeMake(320.0, 568.0);
    } else if (adaptive.designTemplate == DesignTemplateInch47) {
        templateSize = CGSizeMake(375.0, 667.0);
    } else if (adaptive.designTemplate == DesignTemplateInch55) {
        templateSize = CGSizeMake(414.0, 736.0);
    } else if (adaptive.designTemplate == DesignTemplateInch58) {
        templateSize = CGSizeMake(375.0, 812.0);
    } else {
        templateSize = CGSizeZero;
    }
    if (templateSize.width == 0 && templateSize.height == 0) {
        NSAssert(NO, @"not support design size");
    }
    return templateSize;
}

/// 是否为iPhone设备尺寸
+ (BOOL)isSupportDeviceSize {
    CGSize templateSize = [self designTemplateSize];
    BOOL isContain = NO;
    for (NSValue *value in [self iPhonesDeviceSize]) {
        if ([value isEqualToValue:@(templateSize)]) {
            isContain = YES;
            break;
        }
        isContain = NO;
        continue;
    }
    return isContain;
}

@end


@implementation DeviceSize

- (instancetype)init {
    self = [super init];
    if (self) {
        _inch35 = -MAXFLOAT;
        _inch40 = -MAXFLOAT;
        _inch47 = -MAXFLOAT;
        _inch55 = -MAXFLOAT;
        _inch58 = -MAXFLOAT;
    }
    return self;
}

@end
