//
//  TableCellLayoutExample3Controller.h
//  CSS
//
//  Created by mac on 2018/11/29.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableCellLayoutExample3Controller : UIViewController

@end

@interface Custom3Cell : UITableViewCell

@property (nonatomic, strong) UILabel * label0;
@property (nonatomic, strong) UILabel * label1;
- (void)configure:(id)model;

@end

NS_ASSUME_NONNULL_END
