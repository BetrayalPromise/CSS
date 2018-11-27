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

@property (nonatomic, strong) UILabel * textLabel;

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

    UILabel * textLabel = [[[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(UILabel *_Nonnull source) {
        source.backgroundColor = UIColor.randomColor;
        source.numberOfLines = 0;
    }] attachTo:contentView];
    _textLabel = textLabel;
    textLabel.text = [[self textForShow] substringFromIndex:arc4random() % ([self textForShow].length - 1)];
    [textLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = contentView.yoga.width;
        layout.maxWidth = YGPointValue([UIScreen mainScreen].bounds.size.width);
    }];
    [self.view.yoga applyLayoutPreservingOrigin:YES];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    button.center = self.view.center;
    [button addTarget:self action:@selector(handleButtonEvent:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (NSString *)textForShow {
    return @"的饭卡的飞机啊；放假看jo9得jo9见啊烤看jo9得见豆腐jo9看得见几啊看得jo9见风看jo9得见景3i-83u549-138看得见409看得见2n29320斤看法是的；开机哦怕 阿的江否34092394kajflakjfkjeeklq;rj看得见qe;kjr;lke看得见nfq看看得见得见k看得见eaj看得见rklqwejr-98看得见ujaodf看得见jowiufj看得见ipodfjasdfjo94ru看得见0c";
}

- (void)handleButtonEvent:(UIButton *)button {
    _textLabel.text = [[self textForShow] substringFromIndex:arc4random() % ([self textForShow].length - 1)];
    [_textLabel.yoga markDirty];
    [_textLabel.yoga applyLayoutPreservingOrigin:YES dimensionFlexibility:(YGDimensionFlexibilityFlexibleWidth)];
}

@end
