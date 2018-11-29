//
//  Example6Controller.h
//  CSS
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableCellLayoutExample1Controller : UIViewController

@end


@interface CustomCell : UITableViewCell

- (void)configure:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
