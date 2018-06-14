//
//  NSObject+Property.h
//  UITextView
//
//  Created by 李阳 on 23/7/2017.
//  Copyright © 2017 qms. All rights reserved.
//

#import "FastCoder.h"
#import <Foundation/Foundation.h>

#pragma mark - Persistent
@interface NSObject (Persistent)

- (NSArray *_Nullable)ignoredNames;

- (void)encode:(NSCoder *_Nonnull)aCoder;
- (void)decode:(NSCoder *_Nonnull)aDecoder;

- (void)storeWithKey:(NSString *_Nonnull)key;
+ (instancetype _Nullable)fetchWithKey:(NSString *_Nonnull)key;
+ (void)clearWithKey:(NSString *_Nonnull)key;

- (BOOL)archiverWithFilePath:(NSString *_Nonnull)filePath;
+ (instancetype _Nullable)unarchiverWithFilePath:(NSString *_Nonnull)filePath;
+ (void)clearArchiverWithFilePath:(NSString *_Nonnull)filePath;

@end
