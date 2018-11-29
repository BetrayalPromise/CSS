//
//  UIButtonController.m
//  CSS
//
//  Created by LiChunYang on 15/8/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "ViewLayoutExample0Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>

@interface ViewLayoutExample0Controller ()

@end

@implementation ViewLayoutExample0Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;

    self.title = @"标签的抗拉抗压属性处理";
    UIEdgeInsets edge = controllerSafeInset(SafeAreaScopeNavigationBar, nil);

    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.paddingTop = YGPointValue(edge.top);
        layout.paddingLeft = YGPointValue(edge.left);
        layout.paddingBottom = YGPointValue(edge.bottom);
        layout.paddingRight = YGPointValue(edge.right);
    }];

    UIView * contenterView = [[UIView alloc] initWithFrame:CGRectZero];
    contenterView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:contenterView];
    [contenterView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
//        layout.flexWrap = YGWrapWrap;
        layout.alignContent = YGAlignSpaceBetween;
        layout.justifyContent = YGJustifySpaceBetween;
    }];

    UILabel * a = [[UILabel alloc] initWithFrame:CGRectZero];
    a.text = @"10JQ10JQKA10JQKA10JQKA10JQKAKA";
    a.numberOfLines = 0;
    a.backgroundColor = UIColor.orangeColor;
    [contenterView addSubview:a];
    [a configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGValueAuto;
        layout.height = YGValueAuto;
        layout.alignSelf = YGAlignFlexStart;
        layout.flexShrink = 1.0;
    }];

    UILabel * b = [[UILabel alloc] initWithFrame:CGRectZero];
    b.lineBreakMode = NSLineBreakByTruncatingTail;
    b.backgroundColor = UIColor.redColor;
    b.text = @"1dfadfadfdfadfadfadfadfad1dfadfadfdfadfadfadfadfadfdfJQKAfdfJQKA";
    [contenterView addSubview:b];
    [b configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.maxWidth = YGPercentValue(90);
        layout.height = YGPointValue(a.yoga.intrinsicSize.height);
    }];
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

@end
