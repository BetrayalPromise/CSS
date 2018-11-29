//
//  Example0ViewController.m
//  CSS
//
//  Created by LiChunYang on 31/7/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "ViewLayoutExample1Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>

@interface ViewLayoutExample1Controller ()

@end

@implementation ViewLayoutExample1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"安全区处理";
    UIEdgeInsets edge = controllerSafeInset(SafeAreaScopeNavigationBar, nil);

    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.paddingTop = YGPointValue(edge.top);
        layout.paddingLeft = YGPointValue(edge.left);
        layout.paddingBottom = YGPointValue(edge.bottom);
        layout.paddingRight = YGPointValue(edge.right);
    }];

    UIView * contentView = [[[UIView alloc] initWithFrame:CGRectZero] attachTo:self.view];
    contentView.backgroundColor = [UIColor redColor];
    [contentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1.0;
        layout.flexDirection = YGFlexDirectionRow;
        layout.flexWrap = YGWrapWrap;
        layout.justifyContent = YGJustifyFlexStart;
        layout.alignItems = YGAlignFlexStart;
        layout.alignContent = YGAlignFlexStart;
    }];
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

@end
