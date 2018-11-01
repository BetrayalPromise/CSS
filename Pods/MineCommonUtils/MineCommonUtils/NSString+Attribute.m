//
//  NSString+Attributed.m
//  Demo
//
//  Created by LiChunYang on 15/8/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "NSString+Attribute.h"

@implementation NSString (Attribute)

- (NSMutableAttributedString *)attributedText {
    return [[NSMutableAttributedString alloc] initWithAttributedString:[[NSAttributedString alloc] initWithString:self]];
}

@end
