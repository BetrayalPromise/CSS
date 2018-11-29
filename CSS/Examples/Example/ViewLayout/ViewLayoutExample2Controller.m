//
//  UIImageViewController.m
//  
//
//  Created by LiChunYang on 15/8/2018.
//

#import "ViewLayoutExample2Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface ViewLayoutExample2Controller ()

@end

@implementation ViewLayoutExample2Controller

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
        if (YES) {
            UIView * v = [[[[UIView alloc] initWithFrame:CGRectZero] objectThen:^(UILabel *_Nonnull source) {
                source.backgroundColor = UIColor.randomColor;
            }] attachTo:userContentView];
            [v configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
                layout.isEnabled = YES;
                layout.flexGrow = 1.0;
                layout.padding = YGPointValue(5);
            }];
            
            UILabel * nameLabel = [[[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(UILabel * _Nonnull source) {
                source.text = @"我叫什么名字呢我叫什么名字呢我叫什么名字呢我叫什么名字呢我叫什么名字呢";
                source.numberOfLines = 0;
                source.backgroundColor = UIColor.randomColor;
            }] attachTo:v];
            [nameLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
                layout.isEnabled = YES;
                layout.maxWidth = YGPointValue([UIScreen mainScreen].bounds.size.width - 130);
            }];
            
            UILabel * sexLabel = [[[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(UILabel * _Nonnull source) {
                source.text = @"我是男还是女呢我是男还是女呢我是男还是女呢我是男还是女呢";
                source.numberOfLines = 0;
                source.backgroundColor = UIColor.randomColor;
            }] attachTo:v];
            [sexLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
                layout.isEnabled = YES;
                layout.maxWidth = nameLabel.yoga.maxWidth;
            }];
            UILabel * locationLabel = [[[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(UILabel * _Nonnull source) {
                source.text = @"我住在什么犄角旮旯里呢我住在什么犄角旮旯里呢";
                source.numberOfLines = 0;
                source.backgroundColor = UIColor.randomColor;
            }] attachTo:v];
            [locationLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
                layout.isEnabled = YES;
                layout.maxWidth = nameLabel.yoga.maxWidth;
            }];
        }
    }
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

@end
