//
//  ViewController.m
//  Layout
//
//  Created by LiChunYang on 23/5/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "ViewController.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <objc/runtime.h>
#import <Aspects/Aspects.h>
#import "FlexContainerViewController.h"
#import "FlexItemViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<UIViewController *> *datas;

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    _datas = @[[FlexContainerViewController new], [FlexItemViewController new]];
    
    [self aspect_hookSelector:@selector(viewDidLoad) withOptions:(AspectPositionAfter) usingBlock:^{
        NSLog(@"AAA");
    } error:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    [self.navigationController pushViewController:_datas[indexPath.row] animated:YES];
//    [self presentViewController:_datas[indexPath.row] animated:YES completion:nil];
}

@end
