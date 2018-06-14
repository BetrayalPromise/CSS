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

/** 类方法获取文件的大小 有回调 */
+ (void)getFileSizeWithFileName:(NSString *_Nullable)path completion:(void (^_Nullable)(unsigned long long totalSize))completionBlock;
/** 对象方法获取文件的大小 有回调 */
- (void)getFileSizeWithFileName:(NSString *_Nullable)path completion:(void (^_Nullable)(unsigned long long totalSize))completionBlock;

/** 类方法获取caches路径 */
+ (NSString *_Nullable)cachesPath;
/** 对象方法获取caches路径 */
- (NSString *_Nullable)cachesPath;

/** 类方法移除caches 有回调 */
+ (void)removeCachesWithCompletion:(void (^_Nullable)(void))completionBlock;
/** 对象方法移除caches 有回调 */
- (void)removeCachesWithCompletion:(void (^_Nullable)(void))completionBlock;

@end
