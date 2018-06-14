//
//  NSObject+Swapper.h
//  A
//
//  Created by LiChunYang on 11/6/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swapper)

+ (void)swizzleClassSelector:(SEL)originSelector withTargetSelector:(SEL)targetSelector;
- (void)swizzleInstanceSelector:(SEL)originSelector withTargetSelector:(SEL)targetSelector;

@end

