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

//- (UIColor *)toColor {
//    const char * value = [self UTF8String];
//    if (strstr(value, "@")) {
//        char * string = strchr(value, '@');
//        size_t index = string - value;
//        printf("%zu", index);
//        const char * alpha = substring(string, 1, strlen(string) - 1);
//        double b = atof(alpha);
//        free(alpha);
//        free(string);
//
//        if (strstr(value, "#")) {
//
//        } else {
//
//        }
//        return nil;
//    } else {
//        size_t length = strlen(value);
//        if (length == 6) {
//            const char * red = substring(value, 0, 2);
//            const char * green = substring(value, 2, 2);
//            const char * blue = substring(value, 4, 2);
//            return [UIColor colorWithRed:strtoul(red, 0, 16) / 255.0 green:strtoul(green, 0, 16) / 255.0 blue:strtoul(blue, 0, 16) / 255.0 alpha:1.0];
//        } else if (length == 9) {
//            const char * red = substring(value, 0, 3);
//            const char * green = substring(value, 3, 3);
//            const char * blue = substring(value, 6, 3);
//            return [UIColor colorWithRed:strtoul(red, 0, 10) / 255.0 green:strtoul(green, 0, 10) / 255.0 blue:strtoul(blue, 0, 10) / 255.0 alpha:1.0];
//        } else if (length == 7) {
//            const char * red = substring(value, 1, 2);
//            const char * green = substring(value, 3, 2);
//            const char * blue = substring(value, 5, 2);
//            return [UIColor colorWithRed:strtoul(red, 0, 16) / 255.0 green:strtoul(green, 0, 16) / 255.0 blue:strtoul(blue, 0, 16) / 255.0 alpha:1.0];
//        } else if (length == 10) {
//            const char * red = substring(value, 1, 3);
//            const char * green = substring(value, 4, 3);
//            const char * blue = substring(value, 7, 3);
//            return [UIColor colorWithRed:strtoul(red, 0, 10) / 255.0 green:strtoul(green, 0, 10) / 255.0 blue:strtoul(blue, 0, 10) / 255.0 alpha:1.0];
//        } else {
//            return nil;
//        }
//    }
//}


@end
