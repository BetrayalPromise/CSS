//
//  CommonAdaptive.h
//  BestLayout
//
//  Created by 李阳 on 23/1/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

/// 设计模版类型
typedef NS_ENUM(NSUInteger, Design) {
    Design_320 = 1,
    Design_375 = 2,
    Design_414 = 3,
};

typedef struct LogicSize {
    CGFloat size_320;
    CGFloat size_375;
    CGFloat size_414;
} LogicSize;

/// 缺省是按照iPhone X标准处理
extern void setTemplate(Design dsign);

/**
 只针对iPhone适配 iPad不处理 讲模式同尺寸的s值设置为1.0

 @param design 设计尺寸
 @param closure 构建
 @return 适配尺寸
 */
extern CGFloat widgetAdaptive(CGFloat design, void(^closure)(LogicSize * s));
