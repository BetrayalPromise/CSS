//
//  UIImageViewController.m
//  
//
//  Created by LiChunYang on 15/8/2018.
//

#import "UIImageViewController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UINetworkImageView.h"

@interface UIImageViewController ()

@end

@implementation UIImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        //        layout.justifyContent = YGJustifyFlexStart;
        //        layout.alignItems = YGAlignFlexStart;
        layout.alignItems = YGAlignCenter;
        layout.justifyContent = YGJustifyCenter;
    }];

    UIImageView * button0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
//    [button0 setTitle:@"ABC" forState:(UIControlStateNormal)];
    button0.backgroundColor = [UIColor redColor];
    [self.view addSubview:button0];
    [button0 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexWrap = YGWrapWrap;
    }];

    UINetworkImageView * button1 = [[UINetworkImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
    button1.backgroundColor = [UIColor redColor];
    [self.view addSubview:button1];
    button1.urlPath = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1534650273&di=5396b68efeb4ef18ebb4db5c7aa1cc54&src=http://media-cdn.tripadvisor.com/media/photo-s/03/2b/29/c7/tupuna-safari.jpg";
    [button1 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexWrap = YGWrapWrap;
    }];

    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
