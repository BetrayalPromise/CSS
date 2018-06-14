//
//  FlexGrowViewController.m
//  CSS
//
//  Created by LiChunYang on 14/6/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "FlexGrowViewController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface FlexGrowViewController ()

@end

@implementation FlexGrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
    }];
    
    UILabel * v0 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.text = @"ABafad aCDE";
    }] attachTo:self.view];
    [v0 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.marginTop = YGPointValue(100);
        layout.flexGrow = 4;
        layout.height = YGPointValue(50);
    }];
    
    
    UILabel * v1 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.text = @"ABE";
    }] attachTo:self.view];
    [v1 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.marginTop = YGPointValue(100);
        layout.flexGrow = 1;
        layout.height = YGPointValue(50);
    }];
    
    UILabel * v2 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.text = @"ABCDE";
    }] attachTo:self.view];
    [v2 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.marginTop = YGPointValue(100);
        layout.flexGrow = 1;
        layout.height = YGPointValue(50);
    }];
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
