//
//  ViewLayoutExample8Controller.m
//  CSS
//
//  Created by mac on 2018/11/29.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "ViewLayoutExample8Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"
#import "UILabel+EffectSize.h"

@interface ViewLayoutExample8Controller ()

@end

@implementation ViewLayoutExample8Controller

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
        layout.alignItems = YGAlignCenter;
        layout.flexWrap = YGWrapWrap;
    }];
    
    UILabel * textLabel = [[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(__kindof UILabel * _Nonnull source) {
        source.numberOfLines = 0;
        source.text = @"等放假啊快点放假啊；大卡短发短发呢；爱看的短发饭短发短发卡经典款；放假短发啊短发dfadfa短发等放假啊；dfad短发fa 看";
        [source lineSpace:30 wordSpace:10];
        source.backgroundColor = [UIColor randomColor];
    } attachTo:self.view];
    
    [textLabel startMonitorText];
    
    [textLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];

    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

@end
