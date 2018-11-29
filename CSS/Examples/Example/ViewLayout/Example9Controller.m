//
//  Example9Controller.m
//  CSS
//
//  Created by mac on 2018/11/28.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "Example9Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface Example9Controller ()

@property (nonatomic, strong) UILabel * textLabel;

@end

@implementation Example9Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIEdgeInsets edge = controllerSafeInset(SafeAreaScopeNavigationBar, nil);
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.paddingTop = YGPointValue(edge.top);
        layout.paddingLeft = YGPointValue(edge.left);
        layout.paddingBottom = YGPointValue(edge.bottom);
        layout.paddingRight = YGPointValue(edge.right);
        layout.flexDirection = YGFlexDirectionColumn;
    }];
    
    UIView * contentView = [[[UIView alloc] initWithFrame:CGRectZero] objectThen:^(UIView * _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    } attachTo:self.view];
    [contentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
    }];
   
    UIImageView * headerImageView = [[[UIImageView alloc] initWithFrame:CGRectZero] objectThen:^(__kindof UIImageView * _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    } attachTo:contentView];
    [headerImageView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(100);
        layout.height = YGPointValue(100);
    }];
    
    UIView * textContext = [[[UIView alloc] initWithFrame:CGRectZero] objectThen:^(__kindof UIView * _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    } attachTo:contentView];
    [textContext configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1.0;
        layout.flexWrap = YGWrapWrap;
        layout.flexShrink = 1.0;
    }];
    
    UILabel * textLabel = [[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(__kindof UILabel * _Nonnull source) {
        self.textLabel = source;
        self.textLabel.text = [[self showText] substringToIndex:arc4random() % ([self showText].length - 1)];
        source.font = [UIFont systemFontOfSize:30];
        source.numberOfLines = 0;
        source.backgroundColor = [UIColor randomColor];
    } attachTo:textContext];
    [textLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.alignSelf = YGAlignFlexStart;
    }];
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
    
    
    UIButton * button = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)] objectThen:^(__kindof UIButton * _Nonnull source) {
        source.backgroundColor = [UIColor redColor];
    } attachTo:self.view];
    [button addTarget:self action:@selector(handleButtonEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    button.center = self.view.center;
}

- (void)handleButtonEvent:(UIButton *)button {
    [self.textLabel.yoga markDirty];
    self.textLabel.text = [[self showText] substringToIndex:arc4random() % ([self showText].length - 1)];
    [self.view.yoga applyLayoutPreservingOrigin:YES];
    
    button.widgetSize = CGSizeMake(100, 50);
    button.widgetMiddle = self.view.center;
}

- (NSString *)showText {
    return @"这是一个很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的文字";
}

@end
