//
//  Example3ViewController.m
//  CSS
//
//  Created by mac on 2018/11/26.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "Example3Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface Example3Controller ()

@end

@implementation Example3Controller


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
    
    UIView * contentView = [[[[UIView alloc] initWithFrame:CGRectZero] objectThen:^(UIView * _Nonnull source) {
        source.backgroundColor = [UIColor greenColor];
    }] attachTo:self.view];
    [contentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
        layout.flexWrap = YGWrapWrap;
        layout.padding = YGPointValue(5);
        layout.alignContent = YGAlignSpaceBetween;
    }];
    
    if (YES) {
        UIView * userContentView = [[[[UIView alloc] initWithFrame:CGRectZero] objectThen:^(UIView * _Nonnull source) {
            source.backgroundColor = [UIColor yellowColor];
        }] attachTo:self.view];
        [userContentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.flexDirection = YGFlexDirectionRow;
            layout.flexWrap = YGWrapWrap;
            layout.padding = YGPointValue(5);
        }];
        
        UIImageView * headImageView = [[[[UIImageView alloc] initWithFrame:(CGRectZero)] objectThen:^(UIImageView * _Nonnull source) {
            source.backgroundColor = UIColor.redColor;
        }] attachTo:userContentView];
        [headImageView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = YGPointValue(100);
            layout.height = YGPointValue(100);
        }];
        
        for (NSInteger i = 0; i < 10; i ++) {
            UILabel * nameLabel = [[[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(UILabel * _Nonnull source) {
                source.text = @"名字";
                source.backgroundColor = UIColor.blueColor;
            }] attachTo:userContentView];
            [nameLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
                layout.isEnabled = YES;
            }];
        }
    }

    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}


@end
