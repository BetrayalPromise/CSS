//
//  NSObject+Property.m
//  UITextView
//
//  Created by 李阳 on 23/7/2017.
//  Copyright © 2017 qms. All rights reserved.
//

#import "NSObject+Persistent.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <pthread.h>

#pragma - mark -
#pragma - mark FunctionExtension

@implementation NSObject (FunctionExtension)

@end

#pragma - mark -
#pragma - mark UnaffectLifeCycleWeakRelated

@interface OriginalObject : NSObject

@property (nonatomic, copy) void (^_Nullable block)(void);
- (instancetype)initWithBlock:(void (^_Nullable)(void))block;

@end

@implementation OriginalObject

- (instancetype)initWithBlock:(void (^_Nullable)(void))block {
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}
- (void)dealloc {
    self.block ? self.block() : nil;
}

@end


@implementation NSObject (UnaffectLifeCycleWeakRelated)

- (void)setWeakUnaffectObject:(_Nullable id)weakUnaffectObject {
    OriginalObject *ob = [[OriginalObject alloc] initWithBlock:^{ objc_setAssociatedObject(self, @selector(weakUnaffectObject), nil, OBJC_ASSOCIATION_ASSIGN); }];
    // 这里关联的key必须唯一，如果使用_cmd，对一个对象多次关联的时候，前面的对象关联会失效。
    objc_setAssociatedObject(weakUnaffectObject, (__bridge const void *) (ob.block), ob, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @selector(weakUnaffectObject), weakUnaffectObject, OBJC_ASSOCIATION_ASSIGN);
}

- (_Nullable id)weakUnaffectObject {
    return objc_getAssociatedObject(self, _cmd);
}

@end

#pragma - mark -
#pragma - mark AffectLifeCycleWeakRelated

@implementation NSObject (AffectLifeCycleWeakRelated)

- (void)setWeakAffectObject:(_Nullable id)weakAffectObject {
    if (weakAffectObject != nil) {
        id __weak weakObject = weakAffectObject;
        id (^block)(void) = ^{ return weakObject; };
        objc_setAssociatedObject(self, @selector(weakAffectObject), block, OBJC_ASSOCIATION_COPY);
    }
}

- (_Nullable id)weakAffectObject {
    id (^block)(void) = objc_getAssociatedObject(self, _cmd);
    _Nullable id currentObject = (block ? block() : nil);
    return currentObject;
}

@end

#pragma - mark -
#pragma - mark Persistent

@implementation NSObject (Persistent)

- (NSArray *_Nullable)ignoredNames {
    return @[ @"Ignore_Nothing" ];
}

/// 解档
- (void)decode:(NSCoder *_Nonnull)aDecoder {
    if ([[[self ignoredNames] objectAtIndex:0] hasPrefix:@"_"] == YES) {
        Class c = self.class;
        while (c && c != [NSObject class]) {
            unsigned int outCount = 0;
            Ivar *ivars = class_copyIvarList(c, &outCount);
            for (int i = 0; i < outCount; i++) {
                Ivar ivar = ivars[i];
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
                if ([self respondsToSelector:@selector(ignoredNames)]) {
                    if ([[self ignoredNames] containsObject:key]) {
                        continue;
                    }
                }
                id value = [aDecoder decodeObjectForKey:key];
                [self setValue:value forKey:key];
            }
            free(ivars);
            c = [c superclass];
        }
    } else {
        Class c = self.class;
        while (c && c != [NSObject class]) {
            unsigned int outCount = 0;
            objc_property_t *propertys = class_copyPropertyList(c, &outCount);
            for (int i = 0; i < outCount; i++) {
                objc_property_t property = propertys[i];
                NSString *key = [NSString stringWithUTF8String:property_getName(property)];
                if ([self respondsToSelector:@selector(ignoredNames)]) {
                    if ([[self ignoredNames] containsObject:key]) {
                        continue;
                    }
                }
                id value = [aDecoder decodeObjectForKey:key];
                [self setValue:value forKey:key];
            }
            free(propertys);
            c = [c superclass];
        }
    }
}

/// 归档
- (void)encode:(NSCoder *_Nonnull)aCoder {
    if ([[[self ignoredNames] objectAtIndex:0] hasPrefix:@"_"] == YES) {
        Class c = self.class;
        while (c && c != [NSObject class]) {
            unsigned int outCount = 0;
            Ivar *ivars = class_copyIvarList([self class], &outCount);
            for (int i = 0; i < outCount; i++) {
                Ivar ivar = ivars[i];
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];

                NSLog(@"%@:%@", key, [self ignoredNames]);

                if ([self respondsToSelector:@selector(ignoredNames)]) {
                    if ([[self ignoredNames] containsObject:key]) {
                        continue;
                    }
                }
                id value = [self valueForKeyPath:key];
                [aCoder encodeObject:value forKey:key];
            }
            free(ivars);
            c = [c superclass];
        }
    } else {
        Class c = self.class;
        while (c && c != [NSObject class]) {
            unsigned int outCount = 0;
            objc_property_t *propertys = class_copyPropertyList(c, &outCount);
            for (int i = 0; i < outCount; i++) {
                objc_property_t property = propertys[i];
                NSString *key = [NSString stringWithUTF8String:property_getName(property)];
                if ([self respondsToSelector:@selector(ignoredNames)]) {
                    if ([[self ignoredNames] containsObject:key]) {
                        continue;
                    }
                }
                id value = [self valueForKeyPath:key];
                [aCoder encodeObject:value forKey:key];
            }
            free(propertys);
            c = [c superclass];
        }
    }
}

- (void)storeWithKey:(NSString *_Nonnull)key {
    if (key == nil) {
        return;
    }
    NSData *storeData = [FastCoder dataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:storeData forKey:key];
}

+ (instancetype _Nullable)fetchWithKey:(NSString *_Nonnull)key {
    if (key == nil) {
        return nil;
    }
    id data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (data) {
        id object = [FastCoder objectWithData:data];
        return object;
    }
    return nil;
}

+ (void)clearWithKey:(NSString *_Nonnull)key {
    NSAssert(key != nil, @"Key must exist!");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)archiverWithFilePath:(NSString *_Nonnull)filePath {
    NSAssert(filePath != nil, @"filePath can not be nil");
    BOOL success = [NSKeyedArchiver archiveRootObject:self toFile:filePath];
    if (success == YES) {
        return YES;
    }
    return NO;
}

+ (instancetype _Nullable)unarchiverWithFilePath:(NSString *_Nonnull)filePath {
    NSAssert(filePath != nil, @"filePath can not be nil");
    id object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (object) {
        return object;
    }
    return nil;
}

+ (void)clearArchiverWithFilePath:(NSString *_Nonnull)filePath {
    NSAssert(filePath != nil, @"filePath can not be nil");
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        [manager removeItemAtPath:filePath error:nil];
    }
}


@end
