//
//  NSObject+Property.m
//  UITextView
//
//  Created by 李阳 on 23/7/2017.
//  Copyright © 2017 qms. All rights reserved.
//

#import "NSObject+SubClasses.h"
#import <objc/runtime.h>
#import <pthread.h>

#pragma mark - SubClasses
@implementation NSObject (SubClasses)

+ (NSArray<Class> *)findSubClass {
    int count = objc_getClassList(NULL, 0);
    if (count <= 0) {
        return @[];
    }
    NSMutableArray *subClassesArray = [NSMutableArray arrayWithObject:self];
    Class *classes = (Class *) malloc(sizeof(Class) * count);
    objc_getClassList(classes, count);
    pthread_mutex_t mutex;
    pthread_mutex_init(&mutex, NULL);
    for (NSUInteger i = 0; i < count; i++) {
        if (self == class_getSuperclass(classes[i])) {
            pthread_mutex_lock(&mutex);
            [subClassesArray addObject:classes[i]];
            pthread_mutex_unlock(&mutex);
        }
    }
    pthread_mutex_destroy(&mutex);
    free(classes);
    return subClassesArray;
}

@end
