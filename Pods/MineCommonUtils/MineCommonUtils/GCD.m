//
//  GCD.m
//  GCDExtension
//
//  Created by 李阳 on 26/10/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#import "GCD.h"
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


static dispatch_source_t __source_async__ = nil;

DISPATCH_EXPORT void  dispatch_interval_async(dispatch_queue_t queue, dispatch_time_t interval, dispatch_block_t block) {
    if (!__source_async__) {
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        __source_async__ = timer;
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            dispatch_async(queue, block);
            dispatch_cancel(timer);
            __source_async__ = nil;
        });
        dispatch_resume(timer);
    }
}

static dispatch_source_t __source_sync__ = nil;

DISPATCH_EXPORT void  dispatch_interval_sync(dispatch_queue_t queue, dispatch_time_t interval, dispatch_block_t block) {
    if (!__source_sync__) {
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        __source_sync__ = timer;
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            dispatch_sync(queue, block);
            dispatch_cancel(timer);
            __source_sync__ = nil;
        });
        dispatch_resume(timer);
    }
}

static dispatch_source_t __group_async__ = nil;

DISPATCH_EXPORT void dispatch_group_interval_async(dispatch_group_t group, dispatch_queue_t  queue, dispatch_time_t interval, dispatch_block_t block) {
    if (!__group_async__) {
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        __group_async__ = timer;
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            dispatch_group_async(group, queue, block);
            dispatch_cancel(timer);
            __group_async__ = nil;
        });
        dispatch_resume(timer);
    }
}

static dispatch_source_t __after__ = nil;

DISPATCH_EXPORT void dispatch_interva_after(dispatch_time_t when, dispatch_time_t interval, dispatch_queue_t queue, dispatch_block_t block) {
    if (!__after__) {
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        __after__ = timer;
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(when * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
            dispatch_cancel(timer);
            __after__ = nil;
        });
        dispatch_resume(timer);
    }
}
