//
//  UIImageViewController.m
//  
//
//  Created by LiChunYang on 15/8/2018.
//

#import "Example2Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIView+SafeArea.h"

@interface Example2Controller ()

@end

@implementation Example2Controller

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
    }];

    UIView * contentView = [[[[UIView alloc] initWithFrame:CGRectZero] objectThen:^(UIView * _Nonnull source) {
        source.backgroundColor = [UIColor blueColor];
    }] attachTo:self.view];
    [contentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1.0;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.justifyContent = YGJustifyFlexStart;
        layout.padding = YGPointValue(10);
    }];

    if (YES) {
        UIView * userContentView = [[[[UIView alloc] initWithFrame:CGRectZero] objectThen:^(UIView * _Nonnull source) {
            source.backgroundColor = [UIColor yellowColor];
        }] attachTo:contentView];
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

        UILabel * nameLabel = [[[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(UILabel * _Nonnull source) {
            source.text = @"名字";
            source.backgroundColor = UIColor.blueColor;
        }] attachTo:userContentView];
        [nameLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.alignSelf = YGAlignFlexStart;
        }];
    }

    if (YES) {
        UIView * userContentView = [[[[UIView alloc] initWithFrame:CGRectZero] objectThen:^(UIView * _Nonnull source) {
            source.backgroundColor = [UIColor yellowColor];
        }] attachTo:contentView];
        [userContentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.maxWidth = YGPercentValue(50);
        }];

        UIView * v = [[[UIView structureView] objectThen:^(UIView * _Nonnull source) {
            source.backgroundColor = UIColor.greenColor;
        }] attachTo:userContentView];
        [v configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = YGPointValue(100);
            layout.height = YGPointValue(100);
        }];
    }

    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

@end
