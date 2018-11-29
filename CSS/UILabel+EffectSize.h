//
//  UILabel+EffectSize.h
//  CSS
//
//  Created by mac on 2018/11/29.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (EffectSize)

/// 改变行间距
- (void)lineSpace:(CGFloat)lineSpace;
/// 改变字间距
- (void)wordSpace:(CGFloat)wordSpace;
/// 改变行字间距
- (void)lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace;

/// 监听文字变动 富文本与普通文本一样监听文字变动
- (void)startMonitorText;
/// 文字变动回调
@property (nonatomic, copy) void (^ textChanged)(BOOL isTextChanged);
@property (nonatomic, copy) void (^ attributeTextChanged)(BOOL isTextChanged);

@end

__attribute__((objc_subclassing_restricted))
@interface EffectSizeLabel : UILabel

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
