//
//  TableCellLayoutExample3Controller.m
//  CSS
//
//  Created by mac on 2018/11/29.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "TableCellLayoutExample3Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface TableCellLayoutExample3Controller () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * datas;

@end

@implementation TableCellLayoutExample3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
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
    [showTableView registerReuseCellClass:[Custom3Cell class]];
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
    Custom3Cell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Custom3Cell class])];
    [cell configure:_datas[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

@end

@implementation Custom3Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUserInterface];
    }
    return self;
}

- (void)createUserInterface {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView * headerImageView = [[[UIImageView alloc] initWithFrame:CGRectZero] objectThen:^(__kindof UIImageView * _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    } attachTo:self.contentView];
    
    UIView * rightView = [[[UIView alloc] initWithFrame:CGRectZero] objectThen:^(__kindof UIView * _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
    } attachTo:self.contentView];
    
    self.label0 = [[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(__kindof UILabel * _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.numberOfLines = 0;
    } attachTo:rightView];
    
    self.label1 = [[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(__kindof UILabel * _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.numberOfLines = 0;
    } attachTo:rightView];
    
    [self.contentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexWrap = YGWrapWrap;
        layout.padding = YGPointValue(5);
        layout.flexDirection = YGFlexDirectionRow;
        layout.flexWrap = YGWrapNoWrap;
    }];
    
    [headerImageView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(80);
        layout.height = YGPointValue(80);
    }];
    
    [rightView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexWrap = YGWrapWrap;
        layout.flexShrink = 1.0;
        layout.flexGrow = 1.0;
        layout.flexDirection = YGFlexDirectionColumn;
    }];
    
    [self.label0 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    [self.label1 configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    [self.contentView.yoga applyLayoutPreservingOrigin:YES];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
    CGSize size = [self.contentView.yoga calculateLayoutWithSize:CGSizeMake(targetSize.width, MAXFLOAT)];
    /// cell分割线占据0.5高度 因此要补上0.5高度
    return CGSizeMake(size.width, size.height + 0.5);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView.yoga applyLayoutPreservingOrigin:NO];
}

- (void)configure:(id)model {
    self.label0.text = model;
    [self.label0.yoga markDirty];
    
    if (arc4random() % 2 == 0) {
        self.label1.yoga.display = YGDisplayFlex;
        self.label1.text = model;
        [self.label1.yoga markDirty];
    } else {
        self.label1.yoga.display = YGDisplayNone;
    }
    
}

@end
