//
//  CommonAdaptive.h
//  BestLayout
//
//  Created by 李阳 on 23/1/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
@class DeviceSize;

typedef NS_ENUM(NSUInteger, DesignTemplate) { DesignTemplateInch35 = 0, DesignTemplateInch40 = 1, DesignTemplateInch47 = 2, DesignTemplateInch55 = 3, DesignTemplateInch58 = 4 };

typedef NS_ENUM(NSUInteger, AdaptiveFont) {
    ///  自适应调整 字体依次增加2.5
    AdaptiveFontSelfAdaption,
    ///  固定
    AdaptiveFontFixation,
    ///  常规
    AdaptiveFontCommon,
};

typedef NS_ENUM(NSUInteger, AdaptiveRefer) {
    ///  固定
    AdaptiveReferFixation,
    /// 按X轴
    AdaptiveReferRatioX,
    /// 按Y轴
    AdaptiveReferRatioY,
};

@interface CommonAdaptive : NSObject

@property (nonatomic, assign) DesignTemplate designTemplate;

+ (instancetype _Nonnull)sharedInstance;
+ (CGFloat)widgetCustomAdaptive:(void (^_Nonnull)(DeviceSize *_Nonnull size))closure;

+ (CGFloat)widgetFontAdaptive:(AdaptiveFont)type designSize:(CGFloat)designSize;
/*
    参照X轴或者Y轴的标准
 */
+ (CGSize)widge2DimensionAdaptive:(AdaptiveRefer)type designSize:(CGSize)designSize multiply:(CGFloat)multiply minitrim:(CGFloat)minitrim;
+ (CGSize)widge2DimensionAdaptive:(AdaptiveRefer)type designSize:(CGSize)designSize multiply:(CGFloat)multiply;
+ (CGSize)widge2DimensionAdaptive:(AdaptiveRefer)type designSize:(CGSize)designSize minitrim:(CGFloat)minitrim;
+ (CGSize)widge2DimensionAdaptive:(AdaptiveRefer)type designSize:(CGSize)designSize;

+ (CGFloat)widget1DimensionAdaptive:(AdaptiveRefer)type designMeasure:(CGFloat)designMeasure multiply:(CGFloat)multiply minitrim:(CGFloat)minitrim;
+ (CGFloat)widget1DimensionAdaptive:(AdaptiveRefer)type designMeasure:(CGFloat)designMeasure multiply:(CGFloat)multiply;
+ (CGFloat)widget1DimensionAdaptive:(AdaptiveRefer)type designMeasure:(CGFloat)designMeasure minitrim:(CGFloat)minitrim;
+ (CGFloat)widget1DimensionAdaptive:(AdaptiveRefer)type designMeasure:(CGFloat)designMeasure;

@end


@interface DeviceSize : NSObject

/// 3gs 4 4s
@property (nonatomic, assign) CGFloat inch35;
/// 5 5c 5s se
@property (nonatomic, assign) CGFloat inch40;
/// 6 6s 7 7s 8
@property (nonatomic, assign) CGFloat inch47;
/// 6ps 6sps 7ps 7sps 8ps
@property (nonatomic, assign) CGFloat inch55;
/// x
@property (nonatomic, assign) CGFloat inch58;

@end
