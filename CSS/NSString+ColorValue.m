//
//  NSString+ColorValue.m
//  CSS
//
//  Created by LiChunYang on 16/7/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "NSString+ColorValue.h"
#import <UIKit/UIColor.h>

@implementation NSString (ColorValue)

- (UIColor *)color {
    if (![self hasPrefix:@"#"]) {
        if ([self containsString:@"@"]) {
            NSArray <NSString *> * values = [self componentsSeparatedByString:@"@"];
            return [self toColor:values[0] alpha:values[1]];
        } else {
            return [self toColor:self alpha:@"1"];
        }
    } else {
        NSString * value = [self substringFromIndex:1];
        if ([self containsString:@"@"]) {
            NSArray <NSString *> * values = [value componentsSeparatedByString:@"@"];
            return [self toColor:values[0] alpha:values[1]];
        } else {
            return [self toColor:value alpha:@"1"];
        }
    }
}

- (UIColor *)toColor:(NSString *)value alpha:(NSString *)alpha {
    if (value.length == 6) {
        const char * redValue = [[value substringWithRange:NSMakeRange(0, 2)] UTF8String];
        const char * greenValue = [[value substringWithRange:NSMakeRange(2, 2)] UTF8String];
        const char * blueValue = [[value substringWithRange:NSMakeRange(4, 2)] UTF8String];
        unsigned long red = strtoul(redValue, 0, 16);
        unsigned long green = strtoul(greenValue, 0, 16);
        unsigned long blue = strtoul(blueValue, 0, 16);
        return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:[alpha floatValue]];
    } else if (value.length == 9) {
        unsigned long red = [[value substringWithRange:NSMakeRange(0, 3)] intValue];
        unsigned long green= [[value substringWithRange:NSMakeRange(3, 3)] intValue];
        unsigned long blue = [[value substringWithRange:NSMakeRange(6, 3)] intValue];
        return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:[alpha floatValue]];
    } else {
        NSAssert(NO, @"error color value: %@", self);
        return nil;
    }
}

@end
