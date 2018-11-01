//
//  NSString+Attributed.h
//  Demo
//
//  Created by LiChunYang on 15/8/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 创建字符串 GCC支持
#define GNUString(fmt, arg...) [NSString stringWithFormat:fmt, ##arg]

@interface NSString (Attribute)

@property (nonatomic, weak, readonly) NSMutableAttributedString * attributedText;

@end
