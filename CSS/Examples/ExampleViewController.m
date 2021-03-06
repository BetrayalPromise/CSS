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
#import "ViewLayoutViewController.h"
#import "TableCellLayoutViewController.h"
#import "CollectionCellLayoutViewController.h"

@interface ExampleViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <NSString *> * datas;

@end

@implementation ExampleViewController

- (void)loadView {
    [super loadView];
    
//    _datas = @[@"安全区范围处理", @"标签的抗拉抗压属性处理", @"标签布局例子0", @"标签布局例子1", @"中心", @"cell布局不指定高度", @"cell布局指定高度", @"自定义空间自尺寸", @"标签排列布局", @"FlexShrink", @"UICollectionView"];
    
    _datas = @[@"View布局", @"TableCell布局", @"CollectionCell布局"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YogaKit demo";
    
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
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[[ViewLayoutViewController alloc] init] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[[TableCellLayoutViewController alloc] init] animated:YES];
    } else {
        [self.navigationController pushViewController:[[CollectionCellLayoutViewController alloc] init] animated:YES];
    }
}

@end
