//
//  UIButton+HandleEventBlock.m
//  MineCommonUtils_Example
//
//  Created by mac on 2018/10/9.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "UIButton+HandleEventBlock.h"
#import <objc/runtime.h>

@implementation UIButton (HandleEventBlock)

- (void)setButtonHandler:(void (^)(UIButton *))buttonHandler {
    objc_setAssociatedObject(self, @selector(buttonHandler), buttonHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIButton *))buttonHandler {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)addEventHandler:(void (^)(UIButton * btn))block forControlEvents:(UIControlEvents)controlEvents {
    [self setButtonHandler:block];
    [self addTarget:self action:@selector(blcokButtonClicked:) forControlEvents:controlEvents];
}

- (void)blcokButtonClicked:(id)sender {
    ![self buttonHandler] ?: [self buttonHandler](sender);
}

@end
