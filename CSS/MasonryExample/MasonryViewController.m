//
//  MasonryViewController.m
//  CSS
//
//  Created by LiChunYang on 5/9/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "MasonryViewController.h"
#import <YogaKit/UIView+Yoga.h>
#import "Base.h"

@interface MasonryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray <NSString *> * datas;

@end

@implementation MasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datas = @[@"Base"];

    self.view.backgroundColor = [UIColor redColor];
    
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
   
    [tableView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
    }];
    
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _datas[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[Base new] animated:YES];
}

@end
