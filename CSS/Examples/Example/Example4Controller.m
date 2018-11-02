//
//  Example4Controller.m
//  CSS
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "Example4Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface Example4Controller () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <NSString *> * datas;

@end

@implementation Example4Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
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
    [showTableView registerReuseCellClass:[CustomCell class]];
    [showTableView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1.0;
    }];
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CustomCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomCell class])];
    [cell configure:_datas[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (NSString *)textForShow {
    return @"的饭卡的飞机啊；放假看jo9得jo9见啊烤看jo9得见豆腐jo9看得见几啊看得jo9见风看jo9得见景3i-83u549-138看得见409看得见2n29320斤看法是的；开机哦怕 阿的江否34092394kajflakjfkjeeklq;rj看得见qe;kjr;lke看得见nfq看看得见得见k看得见eaj看得见rklqwejr-98看得见ujaodf看得见jowiufj看得见ipodfjasdfjo94ru看得见0c";
}

@end

@interface CustomCell ()

@property (nonatomic, strong) UILabel * label;

@end

@implementation CustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUserInterface];
    }
    return self;
}

- (void)createUserInterface {
    UILabel * label = [[[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(UILabel *_Nonnull source) {
        source.backgroundColor = UIColor.randomColor;
        self->_label = source;
        source.numberOfLines = 0;
    }] attachTo:self.contentView];
    [self.contentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.width = YGPercentValue(100);
        layout.maxWidth = YGPercentValue(100);
        layout.flexDirection = YGFlexDirectionColumn;
        layout.padding = YGPointValue(5);
        layout.justifyContent = YGJustifyFlexStart;
    }];
    [label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 4;
        layout.flexShrink = 1;
    }];
    [self.contentView.yoga applyLayoutPreservingOrigin:YES];
}

- (void)configure:(NSString *)text {
    _label.text = text;
    [_label sizeToFit];
    [_label.yoga markDirty];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView.yoga applyLayoutPreservingOrigin:YES dimensionFlexibility:(YGDimensionFlexibilityFlexibleHeight)];
    [super layoutSubviews];
}

- (CGSize)sizeThatFits:(CGSize)size {
    [self.contentView.yoga applyLayoutPreservingOrigin:YES dimensionFlexibility:(YGDimensionFlexibilityFlexibleHeight)];
    return [self.contentView sizeThatFits:size];
}

@end
