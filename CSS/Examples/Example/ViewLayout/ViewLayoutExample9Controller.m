//
//  ViewLayoutExample9Controller.m
//  CSS
//
//  Created by mac on 2018/11/29.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "ViewLayoutExample9Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface ViewLayoutExample9Controller ()

@property (nonatomic, weak) UIView * b;

@end

@implementation ViewLayoutExample9Controller

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
        layout.justifyContent = YGJustifyCenter;
    }];
    
    NSInteger index = arc4random() % 5;
    
    for (NSInteger i = 0; i < 5; i ++) {

        UIView * v = [[[UIView alloc] initWithFrame:CGRectZero] objectThen:^(__kindof UIView * _Nonnull source) {
            source.backgroundColor = [UIColor randomColor];
            if (i == index) {
                self->_b = source;
            }
        } attachTo:self.view];
        
        [v configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = YGPointValue(100);
            layout.height = YGPointValue(100);
        }];
    }
    
    UIButton * button = [[[UIButton alloc] initWithFrame:CGRectZero] objectThen:^(__kindof UIButton * _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    } attachTo:self.view];
    [button addTarget:self action:@selector(handleEvent:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view.yoga applyLayoutPreservingOrigin:YES];
    button.frame = CGRectMake(200, 100, 100, 100);
}

- (void)handleEvent:(UIButton *)button {
    if (self.b) {
        if (self.b.yoga.display == YGDisplayNone) {
            self.b.yoga.display = YGDisplayFlex;
        } else {
            self.b.yoga.display = YGDisplayNone;
        }
    }
    [self.view.yoga applyLayoutPreservingOrigin:YES];
    button.frame = CGRectMake(200, 100, 100, 100);
}

@end
