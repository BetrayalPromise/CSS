#import <Foundation/Foundation.h>

@interface NSObject (Distribute)

+ (void)invokeTarget:(id _Nonnull)target selector:(SEL _Nonnull)selector info:(id _Nullable)info;

@end
