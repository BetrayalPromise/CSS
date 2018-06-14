//
//  UITableView+FunctionExteniosn.h
//  Test
//
//  Created by 李阳 on 30/3/2015.
//  Copyright © 2015 BetrayalPromise. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Reuse
@interface UITableView (Reuse)

@property (nonatomic, assign) BOOL isOpenDebug;

- (void)registerReuseCellClass:(_Nonnull Class)reuseCellClass;
- (void)registerReuseHeaderFooterViewClass:(_Nonnull Class)reuseHeaderFooterViewClass;

@end

#pragma mark - DefaultReuseIdentifier
@interface UITableViewCell (DefaultReuseIdentifier)

+ (NSString *_Nonnull)defaultReuseIdentifier;
+ (NSString *_Nullable)prefixOfReuseIdentifier;
+ (NSString *_Nullable)postfixofReuseIdentifier;

@end

#pragma mark - DefaultReuseIdentifier
@interface UITableViewHeaderFooterView (DefaultReuseIdentifier)

+ (NSString *_Nonnull)defaultReuseIdentifier;
+ (NSString *_Nullable)prefixOfReuseIdentifier;
+ (NSString *_Nullable)postfixofReuseIdentifier;

@end
