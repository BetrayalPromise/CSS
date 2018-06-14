//
//  UIView+FunctionEnhancement.h
//  Position
//
//  Created by LiChunYang on 12/4/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Structure
@interface UIView (StructureView)

+ (instancetype _Nonnull)structureView;
+ (instancetype _Nonnull)structureView:(CGRect)frame;

@end

@interface UITextView (StructureView)

+ (instancetype _Nonnull)structureView:(NSTextContainer *_Nullable)textContainer;
+ (instancetype _Nonnull)structureView:(CGRect)frame textContainer:(NSTextContainer *_Nullable)textContainer;

@end

@interface UITableView (StructureView)

+ (instancetype _Nonnull)structureView:(UITableViewStyle)style;
+ (instancetype _Nonnull)structureView:(CGRect)frame style:(UITableViewStyle)style;

@end

@interface UICollectionView (StructureView)

+ (instancetype _Nonnull)structureView:(UICollectionViewLayout *_Nonnull)layout;
+ (instancetype _Nonnull)structureView:(CGRect)frame layout:(UICollectionViewLayout *_Nonnull)layout;

@end

@interface UISegmentedControl (StructureView)

+ (instancetype _Nonnull)structureView:(NSArray *_Nullable)items;

@end
