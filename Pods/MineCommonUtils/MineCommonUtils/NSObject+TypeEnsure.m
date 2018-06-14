//
//  NSObject+Property.m
//  UITextView
//
//  Created by 李阳 on 23/7/2017.
//  Copyright © 2017 qms. All rights reserved.
//

#import "NSObject+TypeEnsure.h"
#import <objc/runtime.h>

#pragma mark - TypeEnsure
@implementation NSObject (TypeEnsure)

+ (void)typeList {
    NSLog(@"c:  char");
    NSLog(@"i:  int");
    NSLog(@"s:  short");
    NSLog(@"l:  long");
    NSLog(@"q:  long long");
    NSLog(@"C:  unsign char");
    NSLog(@"I:  unsign int");
    NSLog(@"S:  unsign short");
    NSLog(@"L:  unsign long");
    NSLog(@"Q:  unsign long long");
    NSLog(@"f:  float");
    NSLog(@"d:  double");
    NSLog(@"B:  bool");
    NSLog(@"v:  void");
    NSLog(@"*:  char *");
    NSLog(@"@:  id");
    NSLog(@"#:  object");
    NSLog(@"::  SEL");
    NSLog(@"[array type]:   array");
    NSLog(@"{name=type}:    structure");
    NSLog(@"(name=type):    union");
    NSLog(@"b:  bit");
    NSLog(@"^type:  pointer");
    NSLog(@"?:  nuknown");
}

+ (NSString *)getPropertyType:(NSString *)property {
    objc_property_t p = class_getProperty(self, property.UTF8String);
    const char *cName = property_getName(p);
    NSLog(@"%s", cName);
    NSString *attrs = @(property_getAttributes(p));
    return attrs;

    //    NSString * code = nil;
    //    if (dotLoc == NSNotFound) {
    //        NSUInteger loc = 3;
    //        code = [attrs substringFromIndex:loc];
    //    } else {
    //        code = [attrs substringWithRange:NSMakeRange(1, dotLoc - 1)];
    //    }
    //    return code;
}

@end
