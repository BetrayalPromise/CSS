//
//  UIView+FunctionEnhancement.m
//  Position
//
//  Created by LiChunYang on 12/4/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "UIView+StructureView.h"
#import <objc/message.h>


#pragma mark - Structure
@implementation UIView (StructureView)

+ (instancetype _Nonnull)structureView {
    return [[[self class] alloc] initWithFrame:CGRectZero];
}

+ (instancetype _Nonnull)structureView:(CGRect)frame {
    return [[[self class] alloc] initWithFrame:frame];
}

@end

@implementation UITextView (StructureView)

+ (instancetype _Nonnull)structureView:(NSTextContainer *_Nullable)textContainer {
    return [[[self class] alloc] initWithFrame:CGRectZero textContainer:textContainer];
}

+ (instancetype _Nonnull)structureView:(CGRect)frame textContainer:(NSTextContainer *_Nullable)textContainer {
    return [[[self class] alloc] initWithFrame:frame textContainer:textContainer];
}

@end

@implementation UITableView (StructureView)

+ (instancetype _Nonnull)structureView:(UITableViewStyle)style {
    return [[[self class] alloc] initWithFrame:CGRectZero style:style];
}

+ (instancetype _Nonnull)structureView:(CGRect)frame style:(UITableViewStyle)style {
    return [[[self class] alloc] initWithFrame:frame style:style];
}

@end

@implementation UICollectionView (StructureView)

+ (instancetype _Nonnull)structureView:(UICollectionViewLayout *_Nonnull)layout {
    return [[[self class] alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
}

+ (instancetype _Nonnull)structureView:(CGRect)frame layout:(UICollectionViewLayout *_Nonnull)layout {
    return [[[self class] alloc] initWithFrame:frame collectionViewLayout:layout];
}

@end


@implementation UISegmentedControl (StructureView)

+ (instancetype _Nonnull)structureView:(NSArray *_Nullable)items {
    //    struct objc_super superClass = {
    //        .receiver = self,
    //        .super_class = class_getSuperclass(object_getClass(self))
    //    };
    return [[[self class] alloc] initWithArray:items];
}

@end
