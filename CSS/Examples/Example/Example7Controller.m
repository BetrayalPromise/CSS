//
//  Example7Controller.m
//  CSS
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "Example7Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface Example7Controller ()

@end

@implementation Example7Controller

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
        layout.justifyContent = YGJustifyCenter;
        layout.alignItems = YGAlignCenter;
    }];
    
    
    UILabel * l = [[UILabel alloc] initWithFrame:CGRectZero];
    l.text = @"dfafafadfad";
    l.textAlignment = NSTextAlignmentCenter;
    l.backgroundColor = [UIColor redColor];
    [self.view addSubview:l];
    
    [l configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.borderWidth = 10;
    }];
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}
@end
