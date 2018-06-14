//
//  UIView+FunctionExtension.m
//  PersistentStorageUsage
//
//  Created by 李阳 on 3/5/2016.
//  Copyright © 2016 TuoErJia. All rights reserved.
//

#import "UIView+WidgetPosition.h"

#pragma - mark
#pragma - mark WidgetPosition
@implementation UIView (WidgetPosition)

- (CGPoint)widgetBegin {
    return self.frame.origin;
}

- (void)setWidgetBegin:(CGPoint)widgetBegin {
    CGRect newFrame = self.frame;
    newFrame.origin = widgetBegin;
    self.frame = newFrame;
}

- (CGSize)widgetSize {
    return self.frame.size;
}

- (void)setWidgetSize:(CGSize)widgetSize {
    CGRect newFrame = self.frame;
    newFrame.size = widgetSize;
    self.frame = newFrame;
}

- (CGFloat)widgetHeight {
    return self.frame.size.height;
}

- (void)setWidgetHeight:(CGFloat)widgetHeight {
    CGRect newFrame = self.frame;
    newFrame.size.height = widgetHeight;
    self.frame = newFrame;
}

- (CGFloat)widgetWidth {
    return self.frame.size.width;
}

- (void)setWidgetWidth:(CGFloat)widgetWidth {
    CGRect newFrame = self.frame;
    newFrame.size.width = widgetWidth;
    self.frame = newFrame;
}


- (CGFloat)widgetBeginX {
    return self.frame.origin.x;
}
- (void)setWidgetBeginX:(CGFloat)widgetBeginX {
    CGRect newFrame = self.frame;
    newFrame.origin.x = widgetBeginX;
    self.frame = newFrame;
}

- (CGFloat)widgetMiddleX {
    return self.widgetBeginX + self.widgetWidth / 2;
}

- (void)setWidgetMiddleX:(CGFloat)widgetMiddleX {
    CGRect newFrame = self.frame;
    newFrame.origin.x += widgetMiddleX - (self.frame.origin.x + self.frame.size.width / 2);
    self.frame = newFrame;
}

- (void)setWidgetEndX:(CGFloat)widgetEndX {
    CGRect newFrame = self.frame;
    newFrame.origin.x += widgetEndX - self.frame.origin.x - self.frame.size.width;
    self.frame = newFrame;
}

- (CGFloat)widgetEndX {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)widgetBeginY {
    return self.frame.origin.y;
}

- (void)setWidgetBeginY:(CGFloat)widgetBeginY {
    CGRect newFrame = self.frame;
    newFrame.origin.y = widgetBeginY;
    self.frame = newFrame;
}

- (CGFloat)widgetMiddleY {
    return self.frame.origin.y + self.frame.size.height / 2;
}

- (void)setWidgetMiddleY:(CGFloat)widgetMiddleY {
    CGRect newFrame = self.frame;
    newFrame.origin.y += widgetMiddleY - (self.frame.origin.y + self.frame.size.height / 2);
    self.frame = newFrame;
}

- (CGFloat)widgetEndY {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setWidgetEndY:(CGFloat)widgetEndY {
    CGRect newFrame = self.frame;
    newFrame.origin.y += widgetEndY - self.frame.origin.y - self.frame.size.height;
    self.frame = newFrame;
}

- (CGPoint)widgetMiddle {
    return CGPointMake(self.widgetMiddleX, self.widgetMiddleY);
}

- (void)setWidgetMiddle:(CGPoint)widgetMiddle {
    CGRect newFrame = self.frame;
    newFrame.origin.x += widgetMiddle.x - (self.frame.origin.x + self.frame.size.width / 2);
    newFrame.origin.y += widgetMiddle.y - (self.frame.origin.y + self.frame.size.height / 2);
    self.frame = newFrame;
}

- (void)setWidgetEnd:(CGPoint)widgetEnd {
    CGRect newFrame = self.frame;
    newFrame.origin.x += widgetEnd.x - (self.frame.origin.x + self.frame.size.width);
    newFrame.origin.y += widgetEnd.y - (self.frame.origin.x + self.frame.size.height);
    self.frame = newFrame;
}

- (CGPoint)widgetEnd {
    return CGPointMake(self.widgetEndX, self.widgetEndY);
}

@end

@implementation UIScrollView (WidgetPosition)

- (CGFloat)widgetContentOffsetX {
    return self.contentOffset.x;
}

- (void)setWidgetContentOffsetX:(CGFloat)widgetContentOffsetX {
    self.contentOffset = CGPointMake(widgetContentOffsetX, self.contentOffset.y);
}

- (CGFloat)widgetContentOffsetY {
    return self.contentOffset.y;
}

- (void)setWidgetContentOffsetY:(CGFloat)widgetContentOffsetY {
    self.contentOffset = CGPointMake(self.contentOffset.x, widgetContentOffsetY);
}

- (CGFloat)widgetContentSizeWidth {
    return self.contentSize.width;
}

- (void)setWidgetContentSizeWidth:(CGFloat)widgetContentSizeWidth {
    self.contentSize = CGSizeMake(widgetContentSizeWidth, self.contentSize.height);
}

- (CGFloat)widgetContentSizeHeight {
    return self.contentSize.height;
}

- (void)setWidgetContentSizeHeight:(CGFloat)widgetContentSizeHeight {
    self.contentSize = CGSizeMake(self.contentSize.width, widgetContentSizeHeight);
}

- (CGFloat)widgetContentInsetTop {
    return self.contentInset.top;
}

- (void)setWidgetContentInsetTop:(CGFloat)widgetContentInsetTop {
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.top = widgetContentInsetTop;
    self.contentInset = newContentInset;
}

- (CGFloat)widgetContentInsetLeft {
    return self.contentInset.left;
}

- (void)setWidgetContentInsetLeft:(CGFloat)widgetContentInsetLeft {
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.left = widgetContentInsetLeft;
    self.contentInset = newContentInset;
}

- (CGFloat)widgetContentInsetBottom {
    return self.contentInset.bottom;
}

- (void)setWidgetContentInsetBottom:(CGFloat)widgetContentInsetBottom {
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.bottom = widgetContentInsetBottom;
    self.contentInset = newContentInset;
}

- (CGFloat)widgetContentInsetRight {
    return self.contentInset.right;
}

- (void)setWidgetContentInsetRight:(CGFloat)widgetContentInsetRight {
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.right = widgetContentInsetRight;
    self.contentInset = newContentInset;
}

@end
