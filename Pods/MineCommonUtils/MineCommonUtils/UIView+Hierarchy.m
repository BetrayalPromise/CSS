//
//  UIView+FunctionEnhancement.m
//  Position
//
//  Created by LiChunYang on 12/4/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "UIView+Hierarchy.h"
#import <objc/message.h>

#pragma mark - Hierarchy
@implementation UIView (Hierarchy)

- (instancetype _Nonnull)attachTo:(UIView *_Nullable)dependView {
    !dependView ?: [dependView addSubview:self];
    return self;
}

- (instancetype _Nonnull)objectThen:(void (^_Nullable)(__kindof UIView * _Nonnull source))then {
    !then ?: then(self);
    return self;
}

- (instancetype _Nonnull)objectThen:(void (^_Nullable)(__kindof UIView * _Nonnull source))then attachTo:(UIView *_Nullable)dependView {
    !then ?: then(self);
    [dependView addSubview:self];
    return self;
}

@end
