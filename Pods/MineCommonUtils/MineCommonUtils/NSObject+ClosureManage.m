//
//  NSObject+FunctionEnhancement.m
//  Position
//
//  Created by LiChunYang on 12/4/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "NSObject+ClosureManage.h"

#pragma mark - ClosureManage
@implementation NSObject (ClosureManage)

- (instancetype _Nonnull)objectThen:(void (^_Nullable)(id _Nonnull source))then {
    if (then) {
        then(self);
    }
    return self;
}

@end
