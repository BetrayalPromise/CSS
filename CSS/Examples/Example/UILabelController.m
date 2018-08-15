//
//  Example0ViewController.m
//  CSS
//
//  Created by LiChunYang on 31/7/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "UILabelController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>

@interface UILabelController ()

@end

@implementation UILabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.justifyContent = YGJustifyCenter;
        layout.flexWrap = YGWrapWrap;
//        layout.padding = YGPointValue(60);
        layout.alignItems = YGAlignCenter;
    }];
    
    UILabel * label = [UILabel structureView];
    [self.view addSubview:label];
    label.backgroundColor = [UIColor redColor];
    label.text = @"ADFAFdfafdadfafdafadfadfafafafadfafadfafdaAD";
    label.numberOfLines = 0;
    [label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.marginLeft = YGPointValue(50);
    }];
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
