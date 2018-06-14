//
//  UIView+FunctionExtension.m
//  PersistentStorageUsage
//
//  Created by 李阳 on 3/5/2016.
//  Copyright © 2016 TuoErJia. All rights reserved.
//

#import "MessageTrash.h"
#import "UIView+Style.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#pragma - mark
#pragma - mark StyleFormat

@interface UIView ()

@property (nonatomic, copy) void (^_Nullable ownStyle)(id _Nonnull source);

@end

@implementation UIView (StyleFormat)

- (void)setOwnStyle:(void (^)(id _Nonnull source))ownStyle {
    if (ownStyle) {
        ownStyle(self);
    }
    objc_setAssociatedObject(self, @selector(ownStyle), ownStyle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^_Nullable)(id _Nonnull source))ownStyle {
    return objc_getAssociatedObject(self, _cmd);
}

- (instancetype _Nonnull)createStyle:(void (^_Nullable)(id _Nonnull source))style store:(BOOL)store {
    if (!objc_getAssociatedObject(self, @selector(associatedObjectLifeCycle))) {
        objc_setAssociatedObject(self, @selector(associatedObjectLifeCycle), [MessageTrash new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    if (style) {
        if (store) {
            self.ownStyle = style;
        }
        style(self);
    }
    return self;
}

- (instancetype _Nonnull)copyStyle:(UIView *)view {
    if (view && view.ownStyle) {
        @try {
            view.ownStyle(self);
        } @catch (NSException *e) { NSLog(@"%@", e); }
    }
    return self;
}

- (void)associatedObjectLifeCycle {
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return objc_getAssociatedObject(self, @selector(associatedObjectLifeCycle)) != nil ? objc_getAssociatedObject(self, @selector(associatedObjectLifeCycle)) : [MessageTrash new];
}

@end
