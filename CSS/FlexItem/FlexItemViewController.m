//
//  FlexItemViewController.m
//  CSS
//
//  Created by LiChunYang on 14/6/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "FlexItemViewController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import "FlexGrowViewController.h"
#import "FlexShrinkViewController.h"

@interface FlexItemViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <UIViewController *> * datas;

@end

@implementation FlexItemViewController

- (void)loadView {
    [super loadView];
    _datas = @[[FlexGrowViewController new], [FlexShrinkViewController new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Flex Item";
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *showTableView = [[[UITableView structureView:(UITableViewStylePlain)] objectThen:^(UITableView *_Nonnull source) {
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
        FlexGrowViewController * controller = [FlexGrowViewController new];
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        FlexShrinkViewController * controller = [FlexShrinkViewController new];
        [self presentViewController:controller animated:YES completion:nil];
    }
}


@end
