//
//  NSString+ColorValue.h
//  CSS
//
//  Created by LiChunYang on 16/7/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <Foundation/NSString.h>
@class UIColor;

@interface NSString (ColorValue)

/// 十六进制可以为 #FFFFFF@0.5 #FFFFFF FFFFFF 十进制可以为 #255255255@0.5 #255255255 255255255
@property (nonatomic, weak, readonly) UIColor * color;

@end
