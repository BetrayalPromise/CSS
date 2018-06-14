#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MethodType) {
    MethodTypeClass,
    MethodTypeInstance,
};

@interface NSObject (Distribute)

+ (void)invokeTarget:(id _Nonnull)target selector:(SEL _Nonnull)selector info:(id _Nullable)info;
+ (BOOL)exchangeMethodType:(MethodType)methodType sourceSel:(SEL _Nonnull)sourceSel targetSel:(SEL _Nonnull)targetSel;

@end
