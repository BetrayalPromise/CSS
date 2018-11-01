//
//  GCD.h
//  GCDExtension
//
//  Created by 李阳 on 26/10/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <pthread.h>

#if   __GNUC__
#define PTHREAD_EXPORT extern __attribute__((visibility("default")))
#else
#define PTHREAD_EXPORT extern
#endif

#define MainQueue() dispatch_get_main_queue()
#define GlobalQueue(identifier, flags) dispatch_get_global_queue(identifier, flags)
#define CommonQueue(label, attr) dispatch_queue_create(label, attr)

/**
 如果dispatch_main_sync函数处于主线程中 则同步派发 同步执行 如果dispatch_main_sync非主线程中 则会等待主runloop处于空闲状态 才会派发 等待执行 类似于自旋锁 并且也会导致环境线程任务也处于等待状态 直到主runloop空闲 保证任务在主线程执行

 @param block 需要执行的任务
 */
DISPATCH_EXPORT void dispatch_main_sync(dispatch_block_t block);

/**
 可以在任何线程中执行该block 并且保证在主线程串行之行

 @param block 需要执行的任务
 */
DISPATCH_EXPORT void dispatch_main_async(dispatch_block_t block);


/**
 如果dispatch_main_execute处于主线程则立即派发到主线程 如果处于非主线程则异步派发到主线程

 @param block 需要执行的任务
 */
DISPATCH_EXPORT void dispatch_main_execute(dispatch_block_t block);


/// PTHREAD_MUTEX_NORMAL 0 常规互斥 PTHREAD_MUTEX_RECURSIVE 1 递归互斥 PTHREAD_MUTEX_ERRORCHECK 2 检错互斥
PTHREAD_EXPORT pthread_mutex_t mutexAttribute(int attr);

/// 线程安全执行
PTHREAD_EXPORT void threadSafeExecute(void(^execute)(void));
