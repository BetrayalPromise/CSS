#import "NSObject+DistributeSelector.h"
#import <objc/message.h>
#include <objc/runtime.h>

@implementation NSObject (Ddistribute)

+ (void)invokeTarget:(id _Nonnull)target selector:(SEL _Nonnull)selector info:(id)info {
    if (!target) {
        NSLog(@"target can't be set nil");
        return;
    }
    if (!selector) {
        NSLog(@"selector can't be set nil");
        return;
    }
    uint count;
    Method *methodList = class_copyMethodList([target class], &count);
    NSMutableArray<NSNumber *> *methodIndexArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        SEL name = method_getName(method);
        if (name == selector) {
            [methodIndexArray addObject:@(i)];
        }
    }
    //    va_list args;
    //    // 用于存放取出的参数
    //    id arg;
    //    // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
    //    va_start(args, info);
    //    // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
    //    while ((arg = va_arg(args, id))) {
    //    }
    //    // 清空参数列表，并置参数指针args无效
    //    va_end(args);

    for (NSUInteger i = 0; i < methodIndexArray.count; i++) {
        Method method = methodList[[methodIndexArray[i] integerValue]];
        IMP implementation = method_getImplementation(method);
        ((void *(*) (id, SEL, ...)) implementation)(target, selector, info);
    }
    free(methodList);
}

@end
