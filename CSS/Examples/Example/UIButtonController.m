//
//  UIButtonController.m
//  CSS
//
//  Created by LiChunYang on 15/8/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "UIButtonController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>

@interface UIButtonController ()

@end

@implementation UIButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.alignItems = YGAlignCenter;
        layout.justifyContent = YGJustifyCenter;
    }];

    UIButton * button0 = [UIButton structureView];
    [button0 setTitle:@"ABC" forState:(UIControlStateNormal)];
    button0.backgroundColor = [UIColor redColor];
    [self.view addSubview:button0];
    [button0 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexWrap = YGWrapWrap;
    }];

    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
