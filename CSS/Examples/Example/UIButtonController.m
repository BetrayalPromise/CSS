//
//  UIButtonController.m
//  CSS
//
//  Created by LiChunYang on 15/8/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "UIButtonController.h"

@interface UIButtonController ()

@end

@implementation UIButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
