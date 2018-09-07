//
//  Base.m
//  CSS
//
//  Created by LiChunYang on 5/9/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "Base.h"
#import <YogaKit/UIView+Yoga.h>
#import "UIViewController+SafeAreaView.h"

@interface Base ()

@end

@implementation Base

- (void)loadView {
    [super loadView];
    
    self.safeAreaView.backgroundColor = [UIColor greenColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.safeAreaView setNeedsLayout];
//    [self.safeAreaView layoutIfNeeded];
//    NSLog(@"%@", self.safeAreaView);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.safeAreaView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.alignContent = YGAlignCenter;
            layout.justifyContent = YGJustifyCenter;
            layout.flexGrow = YGFlexDirectionColumn;
        }];
        
        
        UIView * v0 = [[UIView alloc] init];
        [self.safeAreaView addSubview:v0];
        v0.backgroundColor = [UIColor redColor];
        [v0 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = YGPointValue(100);
            layout.height = YGPointValue(100);
        }];
    
        UIView * v1 = [[UIView alloc] init];
        [self.safeAreaView addSubview:v1];
        v1.backgroundColor = [UIColor redColor];
        [v1 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled = YES;
            layout.width = YGPointValue(100);
            layout.height = YGPointValue(100);
        }];
        
        [self.safeAreaView.yoga applyLayoutPreservingOrigin:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
