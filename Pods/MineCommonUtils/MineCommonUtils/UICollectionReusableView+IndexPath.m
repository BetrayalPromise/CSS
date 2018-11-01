//
//  UICollectionReusableView+IndexPath.m
//  Demo
//
//  Created by LiChunYang on 4/9/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "UICollectionReusableView+IndexPath.h"
#import <objc/runtime.h>

__weak static UICollectionView * __attachCollectionView;

@implementation UICollectionReusableView (IndexPath)

+ (void)load {
    SEL originalSelector = NSSelectorFromString(@"dealloc");
    SEL swizzledSelector = @selector(exchange_dealloc);
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (!originalMethod || !swizzledMethod) {
        return;
    }
    IMP originalIMP = method_getImplementation(originalMethod);
    IMP swizzledIMP = method_getImplementation(swizzledMethod);
    const char *originalType = method_getTypeEncoding(originalMethod);
    const char *swizzledType = method_getTypeEncoding(swizzledMethod);
    class_replaceMethod(self, swizzledSelector, originalIMP,originalType);
    class_replaceMethod(self, originalSelector, swizzledIMP,swizzledType);
}

- (void)exchange_dealloc {
    /// 移除关联
    objc_setAssociatedObject(self, @selector(indexPath), nil, OBJC_ASSOCIATION_ASSIGN);
    [self exchange_dealloc];
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, @selector(indexPath), indexPath, OBJC_ASSOCIATION_ASSIGN);
}

- (NSIndexPath *)indexPath {
    return objc_getAssociatedObject(self, _cmd);
}

+ (void)setAttachCollectionView:(UICollectionView *)attachCollectionView {
    __attachCollectionView = attachCollectionView;
}

+ (UICollectionView *)attachCollectionView {
    return __attachCollectionView;
}

- (UICollectionView *)attachCollectionView {
    return __attachCollectionView;
}

@end
