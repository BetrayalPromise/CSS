//
//  NSObject+Swapper.m
//  A
//
//  Created by LiChunYang on 11/6/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "NSObject+Swapper.h"
#import <objc/message.h>

@implementation NSObject (Swapper)

+ (void)swizzleClassSelector:(SEL)originSelector withTargetSelector:(SEL)targetSelector {
    Class cls = [self class];
    
    Method originalMethod = class_getClassMethod(cls, originSelector);
    Method swizzledMethod = class_getClassMethod(cls, targetSelector);
    
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    if (class_addMethod(metacls, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) ) {
        /* swizzing super class method, added if not exist */
        class_replaceMethod(metacls, targetSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)swizzleInstanceSelector:(SEL)originSelector withTargetSelector:(SEL)targetSelector {
    Class cls = [self class];
    /* if current class not exist selector, then get super*/
    Method originalMethod = class_getInstanceMethod(cls, originSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, targetSelector);
    /* add selector if not exist, implement append with method */
    if (class_addMethod(cls, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) ) {
        /* replace class instance method, added if selector not exist */
        /* for class cluster , it always add new selector here */
        class_replaceMethod(cls, targetSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        /* swizzleMethod maybe belong to super */
        class_replaceMethod(cls, targetSelector, class_replaceMethod(cls, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)), method_getTypeEncoding(originalMethod));
    }
}

@end

