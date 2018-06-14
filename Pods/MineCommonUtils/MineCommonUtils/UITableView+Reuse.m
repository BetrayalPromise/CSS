//
//  UITableView+FunctionExteniosn.m
//  Test
//
//  Created by 李阳 on 30/3/2015.
//  Copyright © 2015 BetrayalPromise. All rights reserved.
//

#import "UITableView+Reuse.h"
#import <objc/runtime.h>


#pragma - mark-- ---ConvenienceRegister-- ---
@implementation UITableView (Reuse)

- (void)setIsOpenDebug:(BOOL)isOpenDebug {
    objc_setAssociatedObject(self, @selector(isOpenDebug), @(isOpenDebug), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isOpenDebug {
    return objc_getAssociatedObject(self, _cmd) != nil ? [objc_getAssociatedObject(self, _cmd) boolValue] : NO;
}

- (void)registerReuseCellClass:(_Nonnull Class)reuseCellClass {
    NSAssert(reuseCellClass != nil, @"class must be not nil");
    if ([reuseCellClass isSubclassOfClass:[UITableViewCell class]]) {
        if (self.isOpenDebug) {
            NSLog(@"DefaultReuseIdentifier: %@", [reuseCellClass defaultReuseIdentifier]);
        }
        [self registerClass:[reuseCellClass class] forCellReuseIdentifier:[reuseCellClass defaultReuseIdentifier]];
        return;
    }
    NSAssert(NO, @"class is not subclass of UITableViewCell");
}

- (void)registerReuseHeaderFooterViewClass:(_Nonnull Class)reuseHeaderFooterViewClass {
    NSAssert(reuseHeaderFooterViewClass != nil, @"class must be not nil");
    if ([reuseHeaderFooterViewClass isSubclassOfClass:[UITableViewHeaderFooterView class]]) {
        if (self.isOpenDebug) {
            NSLog(@"DefaultReuseIdentifier: %@", [reuseHeaderFooterViewClass defaultReuseIdentifier]);
        }
        [self registerClass:[reuseHeaderFooterViewClass class] forHeaderFooterViewReuseIdentifier:[reuseHeaderFooterViewClass defaultReuseIdentifier]];
        return;
    }
    NSAssert(NO, @"class is not subclass of UITableViewHeaderFooterView");
}

@end

#pragma mark - DefaultReuseIdentifier
@implementation UITableViewCell (DefaultReuseIdentifier)

+ (NSString *_Nonnull)defaultReuseIdentifier {
    NSAssert(self != nil, @"class can not be nil");
    NSString *prefix = [self prefixOfReuseIdentifier];
    NSString *postfix = [self postfixofReuseIdentifier];
    if (!prefix && !postfix) {
        return NSStringFromClass(self);
    } else if (prefix && !postfix) {
        return [NSString stringWithFormat:@"%@%@", prefix, NSStringFromClass(self)];
    } else if (!prefix && postfix) {
        return [NSString stringWithFormat:@"%@%@", NSStringFromClass(self), postfix];
    }
    return [NSString stringWithFormat:@"%@%@%@", prefix, NSStringFromClass(self), postfix];
}

+ (NSString *_Nullable)postfixofReuseIdentifier {
    return nil;
}

+ (NSString *_Nullable)prefixOfReuseIdentifier {
    return nil;
}

@end

#pragma mark - DefaultReuseIdentifier
@implementation UITableViewHeaderFooterView (DefaultReuseIdentifier)

+ (NSString *_Nonnull)defaultReuseIdentifier {
    NSAssert(self != nil, @"class can not be nil");
    NSString *prefix = [self prefixOfReuseIdentifier];
    NSString *postfix = [self postfixofReuseIdentifier];
    if (!prefix && !postfix) {
        return NSStringFromClass(self);
    } else if (prefix && !postfix) {
        return [NSString stringWithFormat:@"%@%@", prefix, NSStringFromClass(self)];
    } else if (!prefix && postfix) {
        return [NSString stringWithFormat:@"%@%@", NSStringFromClass(self), postfix];
    }
    return [NSString stringWithFormat:@"%@%@%@", prefix, NSStringFromClass(self), postfix];
}

+ (NSString *_Nullable)postfixofReuseIdentifier {
    return nil;
}

+ (NSString *_Nullable)prefixOfReuseIdentifier {
    return nil;
}

@end
