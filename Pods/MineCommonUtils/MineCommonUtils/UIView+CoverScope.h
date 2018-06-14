//
//  UIView+CoverScope.h
//  Position
//
//  Created by 李阳 on 17/3/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, Scope) {
    ScopeTop = 1 << 0,
    ScopeLeft = 1 << 1,
    ScopeBottom = 1 << 2,
    ScopeRight = 1 << 3,
    ScopeContent = 1 << 4,
};

@interface UIView (CoverScope)

- (CGRect)scopeRect:(Scope)scope;

@end
