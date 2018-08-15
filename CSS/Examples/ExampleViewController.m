//
//  ExampleViewController.m
//  CSS
//
//  Created by LiChunYang on 15/8/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "ExampleViewController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UILabelController.h"
#import "UIButtonController.h"
#import "UIImageViewController.h"

@interface ExampleViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <UIViewController *> * datas;

@end

@implementation ExampleViewController

- (void)loadView {
    [super loadView];
    
    _datas = @[[[UILabelController new] objectThen:^(UILabelController * _Nonnull source) {
        
    }], [[UIButtonController new] objectThen:^(UIButtonController * _Nonnull source) {
                   
    }], [[UIImageViewController new] objectThen:^(UIButtonController * _Nonnull source) {
        
    }]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.flexWrap = YGWrapWrap;
    }];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerReuseCellClass:[UITableViewCell class]];
    [tableView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
    }];
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.defaultReuseIdentifier];
    cell.textLabel.text = NSStringFromClass([_datas[indexPath.row] class]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self presentViewController:_datas[indexPath.row] animated:YES completion:nil];
}

@end
