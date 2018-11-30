//
//  OCExtension.h
//  A
//
//  Created by 李阳 on 29/11/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^__CLEAN_UP__)(void);

#define concat_(A, B) A ## B
#define concat(A, B) concat_(A, B)

#define defer autoreleasepool {} __strong __CLEAN_UP__ concat(block, __LINE__) __attribute__((cleanup(blockCleanUp), unused)) = ^

void blockCleanUp(__strong void (^ *block)(void));

#define Array$(...) [NSArray arrayWithObjects:__VA_ARGS__, nil]
#define MutableArray$(...)  [NSMutableArray arrayWithObjects:__VA_ARGS__, nil]

#define Set$(...)    [NSSet setWithObjects:__VA_ARGS__, nil]
#define MutableSet$(...)  [NSMutableSet setWithObjects:__VA_ARGS__, nil]

#define Dictionary$(...)  [NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define MutableDictionary$(...) [NSMutableDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]

/// 创建字符串 GCC支持
#define GNUString(fmt, arg...) [NSString stringWithFormat:fmt, ##arg]
#define String$(...) [NSString stringWithFormat:__VA_ARGS__]
#define MutableString$(...)  [NSMutableString stringWithFormat:__VA_ARGS__]

#define Bool$(val) [NSNumber numberWithBool:(val)]
#define Char$(val) [NSNumber numberWithChar:(val)]
#define Double$(val) [NSNumber numberWithDouble:(val)]
#define Float$(val) [NSNumber numberWithFloat:(val)]
#define Int$(val) [NSNumber numberWithInt:(val)]
#define Integer$(val) [NSNumber numberWithInteger:(val)]
#define Long$(val) [NSNumber numberWithLong:(val)]
#define Longlong$(val) [NSNumber numberWithLongLong:(val)]
#define Short$(val) [NSNumber numberWithShort:(val)]
#define Uchar$(val) [NSNumber numberWithUnsignedChar:(val)]
#define Uint$(val) [NSNumber numberWithUnsignedInt:(val)]
#define Uinteger$(val) [NSNumber numberWithUnsignedInteger:(val)]
#define Ulong$(val) [NSNumber numberWithUnsignedLong:(val)]
#define Ulonglong$(val) [NSNumber numberWithUnsignedLongLong:(val)]
#define Ushort$(val) [NSNumber numberWithUnsignedShort:(val)]
#define Nonretained$(val) [NSValue valueWithNonretainedObject:(val)]
#define Pointer$(val) [NSValue valueWithPointer:(val)]
#define Point$(val) [NSValue valueWithPoint:(val)]
#define Range$(val) [NSValue valueWithRange:(val)]
#define Rect$(val) [NSValue valueWithRect:(val)]
#define Size$(val) [NSValue valueWithSize:(val)]
