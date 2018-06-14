//
//  MessageTrash.m
//  PersistentStorageUsage
//
//  Created by 李阳 on 3/5/2016.
//  Copyright © 2016 TuoErJia. All rights reserved.
//

#import "MessageTrash.h"
#import <objc/runtime.h>

@implementation MessageTrash

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod([self class], sel, (IMP) realizationFunction, "v@:");
    return YES;
}

void realizationFunction(id obj, SEL _cmd) {
    NSLog(@"%@:%@", obj, NSStringFromSelector(_cmd));
}

@end
