//
//  NSObject+Property.h
//  UITextView
//
//  Created by 李阳 on 23/7/2017.
//  Copyright © 2017 qms. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - FileManager
@interface NSObject (FileManager)

/**
 获取文件的大小

 @param path 路径
 @param completionBlock 完成回掉
 */
+ (void)getFileSizeWithFileName:(NSString *_Nullable)path completion:(void (^_Nullable)(unsigned long long totalSize))completionBlock;

/**
 获取caches路径

 @return caches路径
 */
+ (NSString *_Nullable)cachesPath;

/**
 移除caches

 @param completionBlock 完成回掉
 */
+ (void)removeCachesWithCompletion:(void (^_Nullable)(void))completionBlock;

/**
 获取文件尺寸

 @param filePath 文件路径
 @param diskMode 是否为磁盘模式
 @return 文件尺寸
 */
+ (uint64_t)sizeAtPath:(NSString *)filePath diskMode:(BOOL)diskMode;

@end
