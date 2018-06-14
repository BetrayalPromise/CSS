//
//  FlexWrapViewController.m
//  CSS
//
//  Created by LiChunYang on 14/6/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "FlexWrapViewController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface FlexWrapViewController ()

@property (nonatomic, assign) NSUInteger type;

@end

@implementation FlexWrapViewController

+ (instancetype)buildWithType:(NSUInteger)type {
    FlexWrapViewController * controller = [[self alloc] init];
    controller.type = type;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        if (weakSelf.type == 0) {
            layout.flexWrap = YGWrapNoWrap;
        } else if (weakSelf.type == 1) {
            layout.flexWrap = YGWrapWrap;
        } else if (weakSelf.type == 2) {
            layout.flexWrap = YGWrapWrapReverse;
        }
    }];
    
    UIView * v0 = [[[UIView new] objectThen:^(UIView *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    }] attachTo:self.view];
    [v0 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(80);
        layout.height = YGPointValue(80);
    }];
    
    
    UIView * v1 = [[[UIView new] objectThen:^(UIView *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    }] attachTo:self.view];
    [v1 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(80);
        layout.height = YGPointValue(80);
    }];
    
    
    UIView * v2 = [[[UIView new] objectThen:^(UIView *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    }] attachTo:self.view];
    [v2 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(80);
        layout.height = YGPointValue(80);
    }];
    
    
    UIView * v3 = [[[UIView new] objectThen:^(UIView *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    }] attachTo:self.view];
    [v3 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(80);
        layout.height = YGPointValue(80);
    }];
    
    
    UIView * v4 = [[[UIView new] objectThen:^(UIView *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    }] attachTo:self.view];
    [v4 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(80);
        layout.height = YGPointValue(80);
    }];
    
    UIView * v5 = [[[UIView new] objectThen:^(UIView *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    }] attachTo:self.view];
    [v5 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(80);
        layout.height = YGPointValue(80);
    }];
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
