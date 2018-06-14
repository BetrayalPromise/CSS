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
    if (dependView) {
        [dependView addSubview:self];
    }
    return self;
}

@end
