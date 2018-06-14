//
//  FlexShrinkViewController.m
//  CSS
//
//  Created by LiChunYang on 14/6/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "FlexShrinkViewController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"


@interface FlexShrinkViewController ()

@end

@implementation FlexShrinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
    }];
    
    UILabel * v0 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.text = @"ABafadfadfadfadfadfadf aCDE";
    }] attachTo:self.view];
    [v0 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.marginTop = YGPointValue(100);
//        layout.flexGrow = 4;
        layout.height = YGPointValue(50);
        layout.flexShrink = 3;
    }];
    
    
    UILabel * v1 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.text = @"ABdfadfadfadfadfadfaE";
    }] attachTo:self.view];
    [v1 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.marginTop = YGPointValue(100);
//        layout.flexGrow = 1;
        layout.flexShrink = 3;
        layout.height = YGPointValue(50);
    }];
    
    UILabel * v2 = [[[UILabel new] objectThen:^(UILabel *  _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.text = @"ABCDfadfadfadfafadfdaE";
    }] attachTo:self.view];
    [v2 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.marginTop = YGPointValue(100);
//        layout.flexGrow = 1;
        layout.height = YGPointValue(50);
    }];
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
