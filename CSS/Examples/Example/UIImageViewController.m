//
//  UIImageViewController.m
//  
//
//  Created by LiChunYang on 15/8/2018.
//

#import "UIImageViewController.h"

@interface UIImageViewController ()

@end

@implementation UIImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
