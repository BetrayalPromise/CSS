//
//  MessageThrottle.h
//  MessageThrottle
//
//  Created by 杨萧玉 on 2017/11/04.
//  Copyright © 2017年 杨萧玉. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 消息节流模式

 - MTPerformModeFirstly: Throttle 模式：执行最靠前发送的消息，后面发送的消息会被忽略
 - MTPerformModeLast: Throttle 模式：执行最靠后发送的消息，前面发送的消息会被忽略，执行时间会有延时
 - MTPerformModeDebounce: Debounce 模式：消息发送后延迟一段时间执行，如果在这段时间内继续发送消息，则重新计时
 */
typedef NS_ENUM(NSUInteger, MTPerformMode) {
    MTPerformModeFirstly,
    MTPerformModeLast,
    MTPerformModeDebounce,
};

NS_ASSUME_NONNULL_BEGIN

/**
 获取元类

 @param cls 类对象
 @return 类对象的元类
 */
Class mt_metaClass(Class cls);

/**
 消息节流的规则。durationThreshold = 0.1，则代表 0.1 秒内最多发送一次消息，多余的消息会被忽略掉。
 */
@interface MTRule : NSObject

/**
 target, 可以为实例，类，元类(可以使用 mt_metaClass 函数获取元类）
 */
@property (nonatomic, weak, readonly) id target;

/**
 节流消息的 SEL
 */
@property (nonatomic, readonly) SEL selector;

/**
 消息节流时间的阈值，单位：秒
 */
@property (nonatomic) NSTimeInterval durationThreshold;

/**
 消息节流模式
 */
@property (nonatomic) MTPerformMode mode;

/**
 是否必须执行消息。block 的参数列表可选，返回值为 BOOL 类型。
 block 传入的第一个参数为 `self`，其余参数列表与消息调用的参数列表相同。
 block 如果返回 YES，则消息立即执行，但不会影响当前节流模式。
 */
@property (nonatomic) id alwaysInvokeBlock;

/**
 MTModePerformLastly 和 MTModePerformDebounce 模式下消息发送的队列，默认在主队列
 */
@property (nonatomic) dispatch_queue_t messageQueue;

- (instancetype)initWithTarget:(id)target selector:(SEL)selector durationThreshold:(NSTimeInterval)durationThreshold NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

/**
 应用规则，会覆盖已有的规则

 @return 更新成功返回 YES；如果规则不合法或继承链上已有相同 selector 的规则，则返回 NO
 */
- (BOOL)apply;

/**
 废除规则

 @return 废除成功返回 YES；如果规则不存在或不合法，或者废除 target 对象后依然存在 target 为类的规则，则返回 NO
 */
- (BOOL)discard;

@end

@interface MTEngine : NSObject

@property (nonatomic, class, readonly) MTEngine *defaultEngine;
@property (nonatomic, readonly) NSArray<MTRule *> *allRules;

/**
 应用规则，会覆盖已有的规则

 @param rule MTRule 对象
 @return 更新成功返回 YES；如果规则不合法或继承链上已有相同 selector 的规则，则返回 NO
 */
- (BOOL)applyRule:(MTRule *)rule;

/**
 废除规则

 @param rule MTRule 对象
 @return 废除成功返回 YES；如果规则不存在或不合法，或者废除 target 对象后依然存在 target 为类的规则，则返回 NO
 */
- (BOOL)discardRule:(MTRule *)rule;

@end

@interface NSObject (MessageThrottle)

@property (nonatomic, readonly) NSArray<MTRule *> *mt_allRules;

/**
 对方法调用防抖（Debounce）限频，主队列执行

 @param selector 限频的方法
 @param durationThreshold 限频的阈值
 @return 如果限频成功则返回规则对象，否则返回 nil
 */
- (nullable MTRule *)mt_limitSelector:(SEL)selector oncePerDuration:(NSTimeInterval)durationThreshold;

/**
 对方法调用限频，主队列执行

 @param selector 限频的方法
 @param durationThreshold 限频的阈值
 @param mode 限频模式
 @return 如果限频成功则返回规则对象，否则返回 nil
 */
- (nullable MTRule *)mt_limitSelector:(SEL)selector oncePerDuration:(NSTimeInterval)durationThreshold usingMode:(MTPerformMode)mode;

/**
 对方法调用限频

 @param selector 限频的方法
 @param durationThreshold 限频的阈值
 @param mode 限频模式
 @param messageQueue 延时执行方法的队列
 @return 如果限频成功则返回规则对象，否则返回 nil
 */
- (nullable MTRule *)mt_limitSelector:(SEL)selector oncePerDuration:(NSTimeInterval)durationThreshold usingMode:(MTPerformMode)mode onMessageQueue:(dispatch_queue_t)messageQueue;

/**
 对方法调用限频，可以指定方法某种情况下一定会调用

 @param selector 限频的方法
 @param durationThreshold 限频的阈值
 @param mode 限频模式
 @param messageQueue 延时执行方法的队列
 @param alwaysInvokeBlock 是否必须执行消息。block 的参数列表可选，返回值为 BOOL 类型。参考 `MTRule`。
 @return 如果限频成功则返回规则对象，否则返回 nil
 */
- (nullable MTRule *)mt_limitSelector:(SEL)selector oncePerDuration:(NSTimeInterval)durationThreshold usingMode:(MTPerformMode)mode onMessageQueue:(dispatch_queue_t)messageQueue alwaysInvokeBlock:(nullable id)alwaysInvokeBlock;

@end

NS_ASSUME_NONNULL_END
