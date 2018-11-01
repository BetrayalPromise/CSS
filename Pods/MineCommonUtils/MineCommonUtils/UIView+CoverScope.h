//
//  UIView+CoverScope.h
//  Position
//
//  Created by 李阳 on 17/3/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger, SafeAreaScope) {
    SafeAreaScopeNavigationBar = 1 << 0,
    SafeAreaScopeTabBar = 1 << 1,
};

@interface UIView (CoverScope)

@end

extern BOOL styleX(void);
extern UIEdgeInsets windowSafeAreaInset(void);
extern UIEdgeInsets controllerSafeInset(SafeAreaScope scopes, ...);
