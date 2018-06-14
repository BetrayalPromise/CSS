//
//  NSObject+Property.m
//  UITextView
//
//  Created by 李阳 on 23/7/2017.
//  Copyright © 2017 qms. All rights reserved.
//

#import "NSObject+FileManager.h"

#pragma mark - FileManager
@implementation NSObject (FileManager)

+ (void)getFileSizeWithFileName:(NSString *_Nullable)path completion:(void (^_Nullable)(unsigned long long totalSize))completionBlock {
    if (!path) {
        return;
    }
    if (!completionBlock) {
        return;
    }

    // 在子线程中计算文件大小
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 1.文件总大小
        unsigned long long totalSize = 0;
        // 2.创建文件管理者
        NSFileManager *fileManager = [NSFileManager defaultManager];

        // 3.判断文件存不存在以及是否是文件夹
        BOOL isDirectory = NO;
        BOOL isFileExist = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
        if (!isFileExist)
            return; // 文件不存在
        if (isDirectory) { // 是文件夹
            NSArray *subPaths = [fileManager subpathsAtPath:path];
            for (NSString *subPath in subPaths) {
                NSString *filePath = [path stringByAppendingPathComponent:subPath];
                BOOL isDirectory = NO;
                BOOL isExistFile = [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
                if (!isDirectory && isExistFile && ![filePath containsString:@"DS"]) {
                    totalSize += [fileManager attributesOfItemAtPath:filePath error:nil].fileSize;
                }
            }
        } else { // 不是文件夹
            totalSize = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        }

        // 回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(totalSize);
            }
        });
    });
}

- (void)getFileSizeWithFileName:(NSString *_Nullable)path completion:(void (^_Nullable)(unsigned long long totalSize))completionBlock {
    [NSObject getFileSizeWithFileName:path completion:completionBlock];
}

/** 获取路径 */
+ (NSString *_Nullable)cachesPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSString *_Nullable)cachesPath {
    return [NSObject cachesPath];
}

/** 删除caches */
+ (void)removeCachesWithCompletion:(void (^_Nullable)(void))completionBlock {
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        // 创建文件管理者
        NSFileManager *fileManager = [NSFileManager defaultManager];
        // 删除文件
        NSString *path = self.cachesPath;
        BOOL isDirectory = NO;
        BOOL isfileExist = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
        if (!isfileExist)
            return;
        if (isDirectory) {
            // 迭代器
            NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:path];
            for (NSString *subPath in enumerator) {
                NSString *filePath = [path stringByAppendingPathComponent:subPath];
                // 移除文件Or文件夹
                [fileManager removeItemAtPath:filePath error:nil];
            }
        }
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (completionBlock) {
                completionBlock();
            }
        }];
    }];
}

- (void)removeCachesWithCompletion:(void (^_Nullable)(void))completionBlock {
    [NSObject removeCachesWithCompletion:completionBlock];
}

@end
