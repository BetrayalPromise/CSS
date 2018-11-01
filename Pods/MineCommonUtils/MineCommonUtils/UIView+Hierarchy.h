//
//  UIView+FunctionEnhancement.h
//  Position
//
//  Created by LiChunYang on 12/4/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Hierarchy
@interface UIView (Hierarchy)

- (instancetype _Nonnull)attachTo:(UIView *_Nullable)dependView;
- (instancetype _Nonnull)objectThen:(void (^_Nullable)(__kindof UIView * _Nonnull source))then;
- (instancetype _Nonnull)objectThen:(void (^_Nullable)(__kindof UIView * _Nonnull source))then attachTo:(UIView *_Nullable)dependView;

@end
