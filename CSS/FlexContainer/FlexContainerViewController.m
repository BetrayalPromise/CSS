//
//  FlexContainerViewController.m
//  CSS
//
//  Created by LiChunYang on 14/6/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "FlexContainerViewController.h"
#import "FlexDirectionViewController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import "FlexWrapViewController.h"
#import "JustifyContentViewController.h"
#import "AlignContentViewController.h"

@interface FlexContainerViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<UIViewController *> *datas;

@end

@implementation FlexContainerViewController

- (void)loadView {
    [super loadView];
    _datas = @[[FlexDirectionViewController new], [FlexWrapViewController new], [JustifyContentViewController new], [AlignContentViewController new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Flex Container";
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *showTableView = [[[[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)] objectThen:^(UITableView *_Nonnull source) {
        source.translatesAutoresizingMaskIntoConstraints = NO;
        source.delegate = self;
        source.dataSource = self;
        [source registerReuseCellClass:[UITableViewCell class]];
    }] attachTo:self.view];
    
    [NSLayoutConstraint constraintWithItem:self.view.safeAreaLayoutGuide attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:showTableView attribute:(NSLayoutAttributeTop) multiplier:1.0 constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.view.safeAreaLayoutGuide attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:showTableView attribute:(NSLayoutAttributeLeft) multiplier:1.0 constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.view.safeAreaLayoutGuide attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:showTableView attribute:(NSLayoutAttributeBottom) multiplier:1.0 constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.view.safeAreaLayoutGuide attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:showTableView attribute:(NSLayoutAttributeRight) multiplier:1.0 constant:0.0].active = YES;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = [[NSString alloc] initWithCString:object_getClassName(_datas[indexPath.row]) encoding:NSUTF8StringEncoding];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_datas count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"FlexDirection" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        __block FlexDirectionViewController * viewController = nil;
        UIAlertAction * action0 = [UIAlertAction actionWithTitle:@"FlexDirectionColumn" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            viewController = [FlexDirectionViewController buildWithType:0];
            [controller dismissViewControllerAnimated:YES completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentViewController:viewController animated:YES completion:nil];
            });
        }];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"FlexDirectionColumnReverse" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            viewController = [FlexDirectionViewController buildWithType:1];
            [controller dismissViewControllerAnimated:YES completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentViewController:viewController animated:YES completion:nil];
            });
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"FlexDirectionRow" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            viewController = [FlexDirectionViewController buildWithType:2];
            [controller dismissViewControllerAnimated:YES completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentViewController:viewController animated:YES completion:nil];
            });
        }];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"FlexDirectionRowReverse" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            viewController = [FlexDirectionViewController buildWithType:3];
            [controller dismissViewControllerAnimated:YES completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentViewController:viewController animated:YES completion:nil];
            });
        }];
        UIAlertAction * action4 = [UIAlertAction actionWithTitle:@"cancel" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [controller dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [controller addAction:action0];
        [controller addAction:action1];
        [controller addAction:action2];
        [controller addAction:action3];
        [controller addAction:action4];
        [self presentViewController:controller animated:YES completion:nil];
    } else if (indexPath.row == 1) {
        UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"FlexWrap" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        __block FlexWrapViewController * viewController = nil;
        UIAlertAction * action0 = [UIAlertAction actionWithTitle:@"FlexWrapNoWrap" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            viewController = [FlexWrapViewController buildWithType:0];
            [controller dismissViewControllerAnimated:YES completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentViewController:viewController animated:YES completion:nil];
            });
        }];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"FlexWrapWrap" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            viewController = [FlexWrapViewController buildWithType:1];
            [controller dismissViewControllerAnimated:YES completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentViewController:viewController animated:YES completion:nil];
            });
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"FlexWrapWrapReverse" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            viewController = [FlexWrapViewController buildWithType:2];
            [controller dismissViewControllerAnimated:YES completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentViewController:viewController animated:YES completion:nil];
            });
        }];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"cancel" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [controller dismissViewControllerAnimated:YES completion:nil];
        }];
        [controller addAction:action0];
        [controller addAction:action1];
        [controller addAction:action2];
        [controller addAction:action3];
        [self presentViewController:controller animated:YES completion:nil];
    } else if (indexPath.row == 2) {
        UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"JustifyContent" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        for (NSInteger i = 0; i < 6; i ++) {
            NSString * title = @"";
            if (i == 0) {
                title = @"JustifyFlexStart";
            } else if (i == 1) {
                title = @"JustifyFlexEnd";
            } else if (i == 2) {
                title = @"JustifyCenter";
            } else if (i == 3) {
                title = @"JustifySpaceBetween";
            } else if (i == 4) {
                title = @"JustifySpaceAround";
            } else if (i == 5) {
                title = @"JustifySpaceEvenly";
            }
            UIAlertAction * action = [UIAlertAction actionWithTitle:title style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [controller dismissViewControllerAnimated:YES completion:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    JustifyContentViewController * viewController = [JustifyContentViewController buildWithType:i];
                    [self presentViewController:viewController animated:YES completion:nil];
                });
            }];
            [controller addAction:action];
        }
        
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [controller dismissViewControllerAnimated:YES completion:nil];
        }];
        [controller addAction:cancelAction];
        
        [self presentViewController:controller animated:YES completion:nil];
    } else if (indexPath.row == 3) {
        UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"AlignContent" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        for (NSInteger i = 0; i < 8; i ++) {
            NSString * title = @"";
            if (i == 0) {
                title = @"AlignAuto";
            } else if (i == 1) {
                title = @"AlignFlexStart";
            } else if (i == 2) {
                title = @"AlignCenter";
            } else if (i == 3) {
                title = @"AlignFlexEnd";
            } else if (i == 4) {
                title = @"AlignStretch";
            } else if (i == 5) {
                title = @"AlignBaseline";
            }else if (i == 6) {
                title = @"AlignSpaceBetween";
            }else if (i == 7) {
                title = @"AlignSpaceAround";
            }
            UIAlertAction * action = [UIAlertAction actionWithTitle:title style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [controller dismissViewControllerAnimated:YES completion:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    AlignContentViewController * viewController = [AlignContentViewController buildWithType:i];
                    [self presentViewController:viewController animated:YES completion:nil];
                });
            }];
            [controller addAction:action];
        }
        
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [controller dismissViewControllerAnimated:YES completion:nil];
        }];
        [controller addAction:cancelAction];
        
        [self presentViewController:controller animated:YES completion:nil];
    }
}

@end
