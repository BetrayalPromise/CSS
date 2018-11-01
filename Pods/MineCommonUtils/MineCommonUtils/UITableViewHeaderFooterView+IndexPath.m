//
//  UITableViewHeaderFooterView+IndexPath.m
//  Demo
//
//  Created by LiChunYang on 4/9/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "UITableViewHeaderFooterView+IndexPath.h"
#import <objc/runtime.h>

__weak static UITableView * __attachTableView;

@implementation UITableViewHeaderFooterView (IndexPath)

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
    objc_removeAssociatedObjects(self);
    [self exchange_dealloc];
}

- (void)setSection:(NSInteger)section {
    objc_setAssociatedObject(self, @selector(section), @(section), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)section {
    return objc_getAssociatedObject(self, _cmd) != nil ? [objc_getAssociatedObject(self, _cmd) integerValue] : -1;
}

+ (void)setAttachTableView:(UITableView *)attachTableView {
    __attachTableView = attachTableView;
}

+ (UITableView *)attachTableView {
    return __attachTableView;
}

- (UITableView *)attachTableView {
    return __attachTableView;
}

@end
