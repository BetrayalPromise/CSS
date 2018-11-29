//
//  Example4Controller.m
//  CSS
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "ViewLayoutExample4Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface ViewLayoutExample4Controller ()

@end

@implementation ViewLayoutExample4Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"居中";
    UIEdgeInsets edge = controllerSafeInset(SafeAreaScopeNavigationBar, nil);
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.paddingTop = YGPointValue(edge.top);
        layout.paddingLeft = YGPointValue(edge.left);
        layout.paddingBottom = YGPointValue(edge.bottom);
        layout.paddingRight = YGPointValue(edge.right);
        layout.justifyContent = YGJustifyCenter;
        layout.alignItems = YGAlignCenter;
        if (arc4random() % 2 == 0) {
            layout.flexDirection = YGFlexDirectionRow;
        } else {
            layout.flexDirection = YGFlexDirectionColumn;
        }
    }];
    
    for (NSUInteger i = 0; i < 20; i ++) {
        UIView * centerView = [[[[UIView alloc] initWithFrame:CGRectZero] objectThen:^(UIView *  _Nonnull source) {
            source.backgroundColor = [UIColor randomColor];
        }] attachTo:self.view];
        [centerView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = YGPointValue(20);
            layout.height = YGPointValue(20);
        }];
    }
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

@end
