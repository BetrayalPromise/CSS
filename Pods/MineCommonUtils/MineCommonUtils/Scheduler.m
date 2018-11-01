//
//  GCD.m
//  GCDExtension
//
//  Created by 李阳 on 26/10/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "Scheduler.h"
#import <pthread.h>

DISPATCH_EXPORT void dispatch_main_sync(dispatch_block_t block) {
    if (pthread_main_np() != 0) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

DISPATCH_EXPORT void dispatch_main_async(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

DISPATCH_EXPORT void dispatch_main_execute(dispatch_block_t block) {
    if (pthread_main_np() != 0) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

PTHREAD_EXPORT pthread_mutex_t mutexAttribute(int attr) {
    pthread_mutex_t mutex = {};
    pthread_mutexattr_t attribute = {};
    pthread_mutexattr_init(&attribute);
    pthread_mutexattr_settype(&attribute, attr);
    pthread_mutex_init(&mutex,&attribute);
    return mutex;
}

PTHREAD_EXPORT void threadSafeExecute(void(^execute)(void)) {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    !execute ?: execute();
    dispatch_semaphore_signal(semaphore);
}
