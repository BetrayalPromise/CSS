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

/**
 添加到父视图上

 @param dependView 父视图
 @return 视图自身
 */
- (instancetype _Nonnull)attachTo:(UIView *_Nullable)dependView;

@end
