//
//  UICollectionView+FunctionExtension.m
//  A
//
//  Created by LiChunYang on 26/12/2017.
//  Copyright © 2017 com.qmtv. All rights reserved.
//

#import "UICollectionView+Reuse.h"
#import <objc/runtime.h>

#pragma mark - Reuse
@implementation UICollectionView (Reuse)

- (void)setIsOpenDebug:(BOOL)isOpenDebug {
    objc_setAssociatedObject(self, @selector(isOpenDebug), @(isOpenDebug), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isOpenDebug {
    return objc_getAssociatedObject(self, _cmd) != nil ? [objc_getAssociatedObject(self, _cmd) boolValue] : NO;
}

- (void)registerReuseCellClass:(_Nonnull Class)reuseCellClass {
    NSAssert(reuseCellClass != nil, @"class must be not nil");
    if ([reuseCellClass isSubclassOfClass:[UICollectionViewCell class]]) {
        if (self.isOpenDebug) {
            NSLog(@"DefaultReuseIdentifier: %@", [reuseCellClass defaultReuseIdentifier]);
        }
        [self registerClass:reuseCellClass forCellWithReuseIdentifier:[reuseCellClass defaultReuseIdentifier]];
    } else {
        NSAssert(NO, @"class is not subclass of UITableViewCell");
    }
}

- (void)registerReuseHeaderFooterViewClass:(_Nonnull Class)reuseHeaderFooterViewClass forSupplementaryViewOfKind:(NSString *)elementKind {
    NSAssert(reuseHeaderFooterViewClass != nil, @"class must be not nil");
    if ([reuseHeaderFooterViewClass isSubclassOfClass:[UITableViewHeaderFooterView class]]) {
        if (self.isOpenDebug) {
            NSLog(@"DefaultReuseIdentifier: %@", [reuseHeaderFooterViewClass defaultReuseIdentifier]);
        }
        [self registerClass:[reuseHeaderFooterViewClass class] forSupplementaryViewOfKind:elementKind withReuseIdentifier:[reuseHeaderFooterViewClass defaultReuseIdentifier]];
        return;
    }
    NSAssert(NO, @"class is not subclass of UITableViewHeaderFooterView");
}

@end

#pragma mark - DefaultReuseIdentifier
@implementation UICollectionViewCell (DefaultReuseIdentifier)

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
@implementation UICollectionReusableView (DefaultReuseIdentifier)

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
