//
//  UILabel+EffectSize.m
//  CSS
//
//  Created by mac on 2018/11/29.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "UILabel+EffectSize.h"
#import <objc/runtime.h>

@implementation UILabel (EffectSize)

- (void)lineSpace:(CGFloat)lineSpace {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
}

- (void)wordSpace:(CGFloat)wordSpace {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
}

- (void)lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
}

- (void)setTextChanged:(void (^)(BOOL))textChanged {
    objc_setAssociatedObject(self, @selector(textChanged), textChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(BOOL))textChanged {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAttributeTextChanged:(void (^)(BOOL))attributeTextChanged {
    objc_setAssociatedObject(self, @selector(attributeTextChanged), attributeTextChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(BOOL))attributeTextChanged {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)startMonitorText {
    object_setClass(self, [EffectSizeLabel class]);
}

@end


@implementation EffectSizeLabel

- (void)setText:(NSString *)text {
    NSString * oldString = self.text;
    [super setText:text];
    if ([oldString isEqualToString:text]) {
        !self.textChanged ?: self.textChanged(NO);
    } else {
        !self.textChanged ?: self.textChanged(YES);
    }
}

/// 富文本变动的标准不能完全统一 暂时定为文字
- (void)setAttributedText:(NSAttributedString *)attributedText {
    NSString * oldString = self.attributedText.string;
    [super setAttributedText:attributedText];
    if ([oldString isEqualToString:attributedText.string]) {
        !self.textChanged ?: self.textChanged(NO);
    } else {
        !self.textChanged ?: self.textChanged(YES);
    }
}

- (instancetype)init {
    assert(false);
    return [super init];
}
- (instancetype)initWithFrame:(CGRect)frame {
    assert(false);
    return [super initWithFrame:frame];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    assert(false);
    return [super initWithCoder:aDecoder];
}

@end
