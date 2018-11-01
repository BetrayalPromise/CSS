//
//  NSObject+PerformSelector.m
//  Footstone
//
//  Created by LiChunYang on 8/3/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "NSObject+PerformSelector.h"

@implementation NSObject (PerformSelector)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray<id> *)objects {
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (!signature) {
        //抛出异常
        NSString *info = [NSString stringWithFormat:@"-[%@ %@]:unrecognized selector sent to instance", [self class], NSStringFromSelector(aSelector)];
        @throw [[NSException alloc] initWithName:@"ifelseboyxx remind:" reason:info userInfo:nil];
        return nil;
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    NSInteger arguments = signature.numberOfArguments - 2;
    NSUInteger objectsCount = objects.count;
    NSInteger count = MIN(arguments, objectsCount);
    for (int i = 0; i < count; i++) {
        id obj = objects[i];
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = nil;
        }
        [invocation setArgument:&obj atIndex:i + 2];
    }
    [invocation invoke];
    id res = nil;
    if (signature.methodReturnLength != 0) {
        [invocation getReturnValue:&res];
    }
    return res;
}

- (id)performSelector:(SEL)aSelector objects:(id)objects, ... {
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (!signature) {
        NSString *info = [NSString stringWithFormat:@"-[%@ %@]:unrecognized selector sent to instance", [self class], NSStringFromSelector(aSelector)];
        @throw [[NSException alloc] initWithName:@"ifelseboyxx remind:" reason:info userInfo:nil];
        return nil;
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    va_list args;
    va_start(args, objects);
    id arg;
    if (objects) {
        [invocation setArgument:&objects atIndex:2];
        NSInteger index = 3;
        while ((arg = va_arg(args, id))) {
            [invocation setArgument:&arg atIndex:index];
            ++ index;
        }
    }
    va_end(args);
    [invocation invoke];
    id res = nil;
    if (signature.methodReturnLength != 0) {
        [invocation getReturnValue:&res];
    }
    return res;
}

@end
