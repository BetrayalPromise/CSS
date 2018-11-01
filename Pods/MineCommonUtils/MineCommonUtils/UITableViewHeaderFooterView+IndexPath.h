//
//  UITableViewHeaderFooterView+IndexPath.h
//  Demo
//
//  Created by LiChunYang on 4/9/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewHeaderFooterView (IndexPath)

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak, class) UITableView * attachTableView;
@property (nonatomic, weak, readonly) UITableView * attachTableView;

@end
