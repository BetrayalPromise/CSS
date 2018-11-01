//
//  TimeManage.h
//  PreemptiveAnswer
//
//  Created by LiChunYang on 25/1/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeManage : NSObject
/// Timestamp -> Date
+ (NSDate *_Nullable)convertFromTimestampToDateWithTimestamp:(NSTimeInterval)timestamp;
/// Date -> Timestamp
+ (NSTimeInterval)convertFromDateToTimestampWithDate:(NSDate *_Nullable)date;
/// Format -> Date
+ (NSDate *_Nullable)convertFromFormatStringToDateWithFormatString:(NSString *_Nonnull)formatString format:(NSString *_Nonnull)format;
/// Date -> Format
+ (NSString *_Nullable)convertFromDateToFormatStringWith:(NSDate *_Nonnull)date format:(NSString *_Nonnull)format;
/// Format -> Timestamp
+ (NSTimeInterval)convertFormatStringToTimestampWithFormatString:(NSString *_Nonnull)formatString format:(NSString *_Nonnull)format;
/// Timestamp -> Format
+ (NSString *_Nullable)convertFromTimestampToFormatStringWithTimestamp:(NSTimeInterval)timestamp format:(NSString *_Nonnull)format;

@end

@interface NSDate (GetTime)

- (NSString *_Nullable)getTimeWithFormat:(NSString *_Nonnull)format;

@end

extern int64_t dayOfYear(int64_t year);
extern struct tm * localTimeDetail(void);
