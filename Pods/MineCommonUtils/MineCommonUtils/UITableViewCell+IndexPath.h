//
//  UITableViewCell+IndexPath.h
//  Demo
//
//  Created by LiChunYang on 4/9/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (IndexPath)

@property (nonatomic, weak) NSIndexPath * indexPath;
@property (nonatomic, weak, class) UITableView * attachTableView;
@property (nonatomic, weak, readonly) UITableView * attachTableView;

@end
