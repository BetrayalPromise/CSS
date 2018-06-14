//
//  UICollectionView+FunctionExtension.h
//  A
//
//  Created by LiChunYang on 26/12/2017.
//  Copyright © 2017 com.qmtv. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Reuse
@interface UICollectionView (Reuse)

@property (nonatomic, assign) BOOL isOpenDebug;

- (void)registerReuseCellClass:(_Nonnull Class)reuseCellClass;
- (void)registerReuseHeaderFooterViewClass:(_Nonnull Class)reuseHeaderFooterViewClass forSupplementaryViewOfKind:(NSString *_Nullable)elementKind;

@end

#pragma mark - DefaultReuseIdentifier
@interface UICollectionViewCell (DefaultReuseIdentifier)

+ (NSString *_Nonnull)defaultReuseIdentifier;
+ (NSString *_Nullable)prefixOfReuseIdentifier;
+ (NSString *_Nullable)postfixofReuseIdentifier;

@end

#pragma mark - DefaultReuseIdentifier
@interface UICollectionReusableView (DefaultReuseIdentifier)

+ (NSString *_Nonnull)defaultReuseIdentifier;
+ (NSString *_Nullable)prefixOfReuseIdentifier;
+ (NSString *_Nullable)postfixofReuseIdentifier;

@end
