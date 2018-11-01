//
//  UIButton+HandleEventBlock.h
//  MineCommonUtils_Example
//
//  Created by mac on 2018/10/9.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HandleEventBlock)

- (void)addEventHandler:(void (^)(UIButton * btn))block forControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
