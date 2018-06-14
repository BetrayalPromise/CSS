//
//  UIView+FunctionExtension.h
//  PersistentStorageUsage
//
//  Created by 李阳 on 3/5/2016.
//  Copyright © 2016 TuoErJia. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - StyleFormat
@interface UIView (Style)

/**
 样式 开启存储会有循环引用问题需要注意

 @param style 配置样式
 @param store 是否存储演示
 @return 调用者本身
 */
- (instancetype _Nonnull)createStyle:(void (^_Nullable)(id _Nonnull source))style store:(BOOL)store;

/**
 复制样式

 @param view 从view中复制样式到自身
 @return 调用者本身
 */
- (instancetype _Nonnull)copyStyle:(UIView *_Nullable)view;

@end
