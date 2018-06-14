//
//  UIView+FunctionExtension.h
//  PersistentStorageUsage
//
//  Created by 李阳 on 3/5/2016.
//  Copyright © 2016 TuoErJia. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma - mark
#pragma - mark WidgetPosition
@interface UIView (WidgetPosition)
/// 设置起点
@property (nonatomic, assign) CGPoint widgetBegin;

/// 设置中心点
@property (nonatomic, assign) CGPoint widgetMiddle;

/// 设置终点
@property (nonatomic, assign) CGPoint widgetEnd;

/// 设置控件大小
@property (nonatomic, assign) CGSize widgetSize;
/// 设置x起点坐标
@property (nonatomic, assign) CGFloat widgetBeginX;
/// 设置控件中心x坐标
@property (nonatomic, assign) CGFloat widgetMiddleX;
/// 设置x终点坐标
@property (nonatomic, assign) CGFloat widgetEndX;

/// 设置y起点坐标
@property (nonatomic, assign) CGFloat widgetBeginY;
/// 设置控件中心y坐标
@property (nonatomic, assign) CGFloat widgetMiddleY;
/// 设置y终点坐标
@property (nonatomic, assign) CGFloat widgetEndY;

/// 设置控件宽度
@property (nonatomic, assign) CGFloat widgetWidth;
/// 设置控件高度
@property (nonatomic, assign) CGFloat widgetHeight;

@end


@interface UIScrollView (WidgetPosition)

@property (nonatomic, assign) CGFloat widgetContentOffsetX;
@property (nonatomic, assign) CGFloat widgetContentOffsetY;

@property (nonatomic, assign) CGFloat widgetContentSizeWidth;
@property (nonatomic, assign) CGFloat widgetContentSizeHeight;

@property (nonatomic, assign) CGFloat widgetContentInsetTop;
@property (nonatomic, assign) CGFloat widgetContentInsetLeft;
@property (nonatomic, assign) CGFloat widgetContentInsetBottom;
@property (nonatomic, assign) CGFloat widgetContentInsetRight;

@end
