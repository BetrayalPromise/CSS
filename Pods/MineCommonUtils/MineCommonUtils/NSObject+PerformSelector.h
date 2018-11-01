//
//  NSObject+PerformSelector.h
//  Footstone
//
//  Created by LiChunYang on 8/3/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformSelector)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray<id> *)objects;
- (id)performSelector:(SEL)aSelector objects:(id)objects, ...;

@end
