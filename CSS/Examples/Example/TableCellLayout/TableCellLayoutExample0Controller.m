//
//  Example5Controller.m
//  CSS
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "TableCellLayoutExample0Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface TableCellLayoutExample0Controller () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray <NSString *> * datas;
@end

@implementation TableCellLayoutExample0Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    _datas = [NSMutableArray array];
    for (NSInteger i = 0; i < 500; i ++) {
        [_datas addObject:[[self textForShow] substringWithRange:NSMakeRange(0, arc4random() % ([self textForShow].length - 1))]];
    }
    
    self.title = @"UITableViewCell布局";
    UIEdgeInsets edge = controllerSafeInset(SafeAreaScopeNavigationBar, nil);
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.paddingTop = YGPointValue(edge.top);
        layout.paddingLeft = YGPointValue(edge.left);
        layout.paddingBottom = YGPointValue(edge.bottom);
        layout.paddingRight = YGPointValue(edge.right);
    }];
    
    /// 显示的表格视图
    UITableView * showTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    [self.view addSubview:showTableView];
    showTableView.delegate = self;
    showTableView.dataSource = self;
    showTableView.estimatedRowHeight = 0;
    showTableView.tableFooterView = [UIView new];
    [showTableView registerReuseCellClass:[Custom0Cell class]];
    [showTableView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1.0;
    }];
    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Custom0Cell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Custom0Cell class])];
    [cell configure:_datas[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView heightForData:_datas[indexPath.row] cellIdentifier:NSStringFromClass([Custom0Cell class])];
}

- (NSString *)textForShow {
    return @"的饭卡的飞机啊；放假看jo9得jo9见啊烤看jo9得见豆腐jo9看得见几啊看得jo9见风看jo9得见景3i-83u549-138看得见409看得见2n29320斤看法是的；开机哦怕 阿的江否34092394kajflakjfkjeeklq;rj看得见qe;kjr;lke看得见nfq看看得见得见k看得见eaj看得见rklqwejr-98看得见ujaodf看得见jowiufj看得见ipodfjasdfjo94ru看得见0c";
}

@end


@implementation Custom0Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUserInterface];
    }
    return self;
}

- (void)createUserInterface {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel * label = [[[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(UILabel *_Nonnull source) {
        source.backgroundColor = UIColor.randomColor;
        source.numberOfLines = 0;
        source.text = @"10JQKA";
    }] attachTo:self.contentView];
    self.label = label;
    [self.contentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionColumn;
        layout.flexWrap = YGWrapWrap;
        layout.width = YGPointValue([UIScreen mainScreen].bounds.size.width);        
        layout.padding = YGPointValue(5);
    }];
    [self.label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1;
        layout.flexShrink = 1;
    }];
}

- (void)configure:(NSString *)text {
    _label.text = text;
    [_label.yoga markDirty];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView.yoga applyLayoutPreservingOrigin:YES dimensionFlexibility:(YGDimensionFlexibilityFlexibleHeight)];
}

@end

@implementation  UITableView (TemplateCell)

- (CGFloat)heightForData:(id)model cellIdentifier:(NSString *)identifier {
    Custom0Cell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    [cell prepareForReuse];
    [cell configure:model];
    CGFloat height = cell.contentView.yoga.intrinsicSize.height + 0.5;
    return height;
}

@end
