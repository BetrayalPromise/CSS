//
//  JustifyContentViewController.m
//  CSS
//
//  Created by LiChunYang on 14/6/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "JustifyContentViewController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface JustifyContentViewController ()

@property (nonatomic, assign) NSUInteger type;

@end

@implementation JustifyContentViewController

+ (instancetype)buildWithType:(NSUInteger)type {
    JustifyContentViewController * controller = [[self alloc] init];
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
            layout.justifyContent = YGJustifyFlexStart;
        } else if (weakSelf.type == 1) {
            layout.justifyContent = YGJustifyFlexEnd;
        } else if (weakSelf.type == 2) {
            layout.justifyContent = YGJustifyCenter;
        } else if (weakSelf.type == 3) {
            layout.justifyContent = YGJustifySpaceBetween;
        } else if (weakSelf.type == 4) {
            layout.justifyContent = YGJustifySpaceAround;
        } else if (weakSelf.type == 5) {
            layout.justifyContent = YGJustifySpaceEvenly;
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
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
