//
//  Example8Controller.m
//  CSS
//
//  Created by 李阳 on 27/11/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "ViewLayoutExample6Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface ViewLayoutExample6Controller ()

@end

@implementation ViewLayoutExample6Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"AutoLayout干瞪眼";
    self.view.backgroundColor = [UIColor whiteColor];

    UIEdgeInsets edge = controllerSafeInset(SafeAreaScopeNavigationBar, nil);

    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.paddingTop = YGPointValue(edge.top);
        layout.paddingLeft = YGPointValue(edge.left);
        layout.paddingBottom = YGPointValue(edge.bottom);
        layout.paddingRight = YGPointValue(edge.right);
    }];

    UIView * itemsView = [[[[UIView alloc] initWithFrame:CGRectZero] objectThen:^(UIView * _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    }] attachTo:self.view];

    [itemsView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexWrap = YGWrapWrap;
        layout.flexDirection = YGFlexDirectionRow;
        layout.padding = YGPointValue(10);
        layout.alignContent = YGAlignStretch;
    }];

    for (NSInteger i = 0; i < 20; i ++) {
        UILabel * textLabel = [[[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(UILabel * _Nonnull source) {
            source.backgroundColor = [UIColor randomColor];
            source.text = [@"DFADFADFDF" substringToIndex:arc4random() % 10];
        }] attachTo:itemsView];

        [textLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = YGPointValue(textLabel.yoga.intrinsicSize.width + 5);
            layout.borderWidth = 10;
            layout.marginLeft = YGPointValue(10);
        }];
    }


    [self.view.yoga applyLayoutPreservingOrigin:YES];
}


@end
