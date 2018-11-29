//
//  Example10Controller.m
//  CSS
//
//  Created by mac on 2018/11/28.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "Example10Controller.h"
#import <MineCommonUtils/MineCommonUtils.h>
#import <YogaKit/UIView+Yoga.h>
#import "UIColor+Random.h"

@interface Example10Controller () <UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray <NSString *> * datas;

@end

@implementation Example10Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UICollectionViewCell布局";
    _datas = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i ++) {
        [_datas addObject:[[self textForShow] substringWithRange:NSMakeRange(0, arc4random() % ([self textForShow].length - 1))]];
    }
    UIEdgeInsets edge = controllerSafeInset(SafeAreaScopeNavigationBar, nil);
    [self.view configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.paddingTop = YGPointValue(edge.top);
        layout.paddingLeft = YGPointValue(edge.left);
        layout.paddingBottom = YGPointValue(edge.bottom);
        layout.paddingRight = YGPointValue(edge.right);
    }];

    _datas = [NSMutableArray array];

    for (NSInteger i = 0; i < 10; i ++) {
        [_datas addObject:[[self textForShow] substringWithRange:NSMakeRange(0, arc4random() % ([self textForShow].length - 1))]];
    }

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.estimatedItemSize = CGSizeMake(100, 95.0);
    layout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
    
    UICollectionView * showCollectionView = [[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout] objectThen:^(__kindof UICollectionView * _Nonnull source) {
        [source registerReuseCellClass:[CustomCollectionViewCell class]];
        source.delegate = self;
        source.dataSource = self;
    } attachTo:self.view];
    [showCollectionView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1.0;
    }];

    [self.view.yoga applyLayoutPreservingOrigin:YES];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CustomCollectionViewCell class]) forIndexPath:indexPath];
    [cell configure:_datas[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _datas.count;
}

- (NSString *)textForShow {
    return @"的饭卡的飞机啊；放假看jo9得jo9见啊烤看jo9得见豆腐jo9看得见几啊看得jo9见风看jo9得见景3i-83u549-138看得见409看得见2n29320斤看法是的；开机哦怕 阿的江否34092394kajflakjfkjeeklq;rj看得见qe;kjr;lke看得见nfq看看得见得见k看得见eaj看得见rklqwejr-98看得见ujaodf看得见jowiufj看得见ipodfjasdfjo94ru看得见0c";
}

@end


@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUserInterface];
    }
    return self;
}

- (void)createUserInterface {
    UILabel * textLabel = [[[UILabel alloc] initWithFrame:CGRectZero] objectThen:^(__kindof UILabel * _Nonnull source) {
        source.backgroundColor = [UIColor randomColor];
        source.numberOfLines = 0;
        self->_textLabel = source;
    } attachTo:self.contentView];

    [self.contentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexWrap = YGWrapWrap;
    }];
    [self.textLabel configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexGrow = 1.0;
        layout.flexShrink = 1.0;
    }];
    [self.contentView.yoga applyLayoutPreservingOrigin:YES];
}
- (void)configure:(id)model {
    self.textLabel.text = model;
    [self.textLabel.yoga markDirty];
//    [self.contentView.yoga applyLayoutPreservingOrigin:YES];
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    CGSize size = [self.textLabel sizeThatFits:CGSizeMake(100, MAXFLOAT)];
    attributes.frame = CGRectMake(0, 0, size.width, size.height);
    return attributes;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView.yoga applyLayoutPreservingOrigin:YES];
}

@end
