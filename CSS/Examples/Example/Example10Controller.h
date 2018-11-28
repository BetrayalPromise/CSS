//
//  Example10Controller.h
//  CSS
//
//  Created by 李阳 on 28/11/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Example10Controller : UIViewController

@end

@interface CustomCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel * textLabel;
- (void)configure:(id)model;

@end

NS_ASSUME_NONNULL_END
