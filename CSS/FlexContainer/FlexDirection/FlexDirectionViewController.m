//
//  FlexDirectionViewController.m
//  CSS
//
//  Created by LiChunYang on 14/6/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "FlexDirectionViewController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface FlexDirectionViewController ()

@property (nonatomic, assign) NSUInteger type;

@end

@implementation FlexDirectionViewController

+ (instancetype)buildWithType:(NSUInteger)type {
    FlexDirectionViewController * controller = [[self alloc] init];
    controller.type = type;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    /// 默认是 行排列
    
    __weak typeof(self) weakSelf = self;
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        if (weakSelf.type == 0) {
            layout.flexWrap = YGWrapNoWrap;
        } else if (weakSelf.type == 1) {
            layout.flexWrap = YGWrapWrap;
        } else if (weakSelf.type == 2) {
            layout.flexWrap = YGWrapWrapReverse;
        }
    }];
    UIView * v0 = [UIView new];
    v0.backgroundColor = [UIColor randomColor];
    [self.view addSubview:v0];
    [v0 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(50);
        layout.height = YGPointValue(50);
    }];
    
    UIView * v1 = [UIView new];
    v1.backgroundColor = [UIColor randomColor];
    [self.view addSubview:v1];
    [v1 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(50);
        layout.height = YGPointValue(50);
    }];
    
    UIView * v2 = [UIView new];
    v2.backgroundColor = [UIColor randomColor];
    [self.view addSubview:v2];
    [v2 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(50);
        layout.height = YGPointValue(50);
    }];
    
    UIView * v3 = [UIView new];
    v3.backgroundColor = [UIColor randomColor];
    [self.view addSubview:v3];
    [v3 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(50);
        layout.height = YGPointValue(50);
    }];
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
