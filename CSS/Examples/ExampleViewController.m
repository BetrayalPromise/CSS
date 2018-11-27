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
#import "Example0Controller.h"
#import "Example1Controller.h"
#import "Example2Controller.h"
#import "Example3Controller.h"
#import "Example4Controller.h"
#import "Example5Controller.h"
#import "Example6Controller.h"
#import "Example7Controller.h"
#import "Example8Controller.h"

@interface ExampleViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <NSString *> * datas;

@end

@implementation ExampleViewController

- (void)loadView {
    [super loadView];
    
    _datas = @[@"安全区范围处理", @"标签的抗拉抗压属性处理", @"标签布局例子0", @"标签布局例子1", @"中心", @"cell布局不指定高度", @"cell布局指定高度", @"自定义空间自尺寸", @"标签排列布局"];
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
    cell.textLabel.text = _datas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class className = NSClassFromString([NSString stringWithFormat:@"Example%ldController", (long)indexPath.row]);
    [self.navigationController pushViewController:[className new] animated:YES];
}

@end
