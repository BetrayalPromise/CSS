//
//  NSObject+FunctionEnhancement.h
//  Position
//
//  Created by LiChunYang on 12/4/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Closure
@interface NSObject (ClosureManage)

- (instancetype _Nonnull)objectThen:(void (^_Nullable)(id _Nonnull source))then;

@end
