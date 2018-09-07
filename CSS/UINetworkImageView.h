//
//  UINetworkImageView.h
//  CSS
//
//  Created by 李阳 on 19/8/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINetworkImageView : UIImageView

/// 加载图片的URL
@property (nonatomic, strong) NSString * urlPath;
/// 作为cell子视图时候使用
@property (nonatomic, copy, readonly) NSString * uniqueneIdentifier;

/// 查询层级数 缺省为10
@property (nonatomic, assign) NSUInteger hierarchy;

@end
