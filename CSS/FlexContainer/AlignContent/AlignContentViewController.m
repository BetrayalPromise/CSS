//
//  AlignContentViewController.m
//  CSS
//
//  Created by LiChunYang on 14/6/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "AlignContentViewController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface AlignContentViewController ()

@property (nonatomic, assign) NSUInteger type;

@end

@implementation AlignContentViewController

+ (instancetype)buildWithType:(NSUInteger)type {
    AlignContentViewController * controller = [[self alloc] init];
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
//        layout.flexWrap = YGWrapWrap;
        if (weakSelf.type == 0) {
            layout.alignItems = YGAlignAuto;
        } else if (weakSelf.type == 1) {
            layout.alignItems = YGAlignFlexStart;
        } else if (weakSelf.type == 2) {
            layout.alignItems = YGAlignCenter;
        } else if (weakSelf.type == 3) {
            layout.alignItems = YGAlignFlexEnd;
        } else if (weakSelf.type == 4) {
            layout.alignItems = YGAlignStretch;
        } else if (weakSelf.type == 5) {
            layout.alignItems = YGAlignBaseline;
        } else if (weakSelf.type == 6) {
            layout.alignItems = YGAlignSpaceBetween;
        } else if (weakSelf.type == 7) {
            layout.alignItems = YGAlignSpaceAround;
        }
    }];
    
    UILabel * v0 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.text = @"ABafad aCDE";
    }] attachTo:self.view];
    [v0 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 0;
    }];
    
    
    UILabel * v1 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.text = @"ABE";
    }] attachTo:self.view];
    [v1 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 0;
    }];
    
    
    UILabel * v2 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.text = @"ABCDE";
    }] attachTo:self.view];
    [v2 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 0;
    }];
    
    UILabel * v3 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.text = @"ABCDE";
    }] attachTo:self.view];
    [v3 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 0;
    }];
    
    UILabel * v4 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.text = @"ABCDE";
    }] attachTo:self.view];
    [v4 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 0;
    }];
    
    UILabel * v5 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.text = @"ABCDE";
    }] attachTo:self.view];
    [v5 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 0;
    }];
    
//    UILabel * v6 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
//        source.backgroundColor = [UIColor randomColor];
//        source.text = @"ABCDE";
//    }] attachTo:self.view];
//    [v6 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
//        layout.isEnabled = YES;
//        layout.flexGrow = 0;
//    }];
//
//    UILabel * v7 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
//        source.backgroundColor = [UIColor randomColor];
//        source.text = @"ABCDE";
//    }] attachTo:self.view];
//    [v7 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
//        layout.isEnabled = YES;
//        layout.flexGrow = 0;
//    }];
//
//    UILabel * v8 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
//        source.backgroundColor = [UIColor randomColor];
//        source.text = @"ABCDE";
//    }] attachTo:self.view];
//    [v8 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
//        layout.isEnabled = YES;
//        layout.flexGrow = 0;
//    }];
//
//    UILabel * v9 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
//        source.backgroundColor = [UIColor randomColor];
//        source.text = @"ABCDE";
//    }] attachTo:self.view];
//    [v9 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
//        layout.isEnabled = YES;
//        layout.flexGrow = 0;
//    }];
//
//    UILabel * v10 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
//        source.backgroundColor = [UIColor randomColor];
//        source.text = @"ABCDE";
//    }] attachTo:self.view];
//    [v10 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
//        layout.isEnabled = YES;
//        layout.flexGrow = 0;
//    }];
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
