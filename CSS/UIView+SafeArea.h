//
//  UIView+SafeArea.h
//  CSSLayout
//
//  Created by 李阳 on 24/11/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, SafeAreaScope) {
    SafeAreaScopeNavigationBar = 1 << 0,
    SafeAreaScopeTabBar = 1 << 1,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SafeArea)

@end

extern BOOL styleX(void);
extern UIEdgeInsets windowSafeAreaInset(void);
extern UIEdgeInsets controllerSafeInset(SafeAreaScope scopes, ...);

NS_ASSUME_NONNULL_END
