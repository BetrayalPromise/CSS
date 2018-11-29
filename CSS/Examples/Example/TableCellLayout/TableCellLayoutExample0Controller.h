//
//  Example5Controller.h
//  CSS
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableCellLayoutExample0Controller : UIViewController

@end

@interface Custom0Cell : UITableViewCell

@property (nonatomic, strong) UILabel * label;
- (void)configure:(NSString *)text;

@end

@interface UITableView (TemplateCell)
- (CGFloat)heightForData:(id)model cellIdentifier:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
