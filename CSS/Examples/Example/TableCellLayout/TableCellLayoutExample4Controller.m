//
//  TableCellLayoutExample4Controller.m
//  CSS
//
//  Created by mac on 2018/11/30.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "TableCellLayoutExample4Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface TableCellLayoutExample4Controller () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <NSString *> * datas;

@end

@implementation TableCellLayoutExample4Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UITableViewCell布局";
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionCount;
    }];
    _datas = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 500; i ++) {
        [_datas addObject:[[self textForShow] substringWithRange:NSMakeRange(0, arc4random() % ([self textForShow].length - 1))]];
    }
    
    /// 显示的表格视图
    UITableView * showTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    [self.view addSubview:showTableView];
    showTableView.delegate = self;
    showTableView.dataSource = self;
    showTableView.rowHeight = UITableViewAutomaticDimension;
    [showTableView registerReuseCellClass:[Custom4Cell class]];
    [showTableView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1.0;
    }];
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (NSString *)textForShow {
    return @"的饭卡的飞机啊；放假看jo9得jo9见啊烤看jo9得见豆腐jo9看得见几啊看得jo9见风看jo9得见景3i-83u549-138看得见409看得见2n29320斤看法是的；开机哦怕 阿的江否34092394kajflakjfkjeeklq;rj看得见qe;kjr;lke看得见nfq看看得见得见k看得见eaj看得见rklqwejr-98看得见ujaodf看得见jowiufj看得见ipodfjasdfjo94ru看得见0c";
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Custom4Cell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Custom4Cell class])];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

@end

@implementation Custom4Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUserInterface];
    }
    return self;
}

- (void)createUserInterface {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor randomColor];
    UIImageView * headerImageView = [[[UIImageView alloc] initWithFrame:CGRectZero] objectThen:^(__kindof UIImageView * _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    } attachTo:self.contentView];
    [self.contentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexWrap = YGWrapWrap;
        layout.padding = YGPointValue(5);
    }];
    
    [headerImageView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(80);
        layout.height = YGPointValue(80);
    }];
    
    [self.contentView.yoga applyLayoutPreservingOrigin:YES];
}

@end
