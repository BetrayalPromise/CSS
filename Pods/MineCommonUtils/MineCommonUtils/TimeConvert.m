//
//  TimeManage.m
//  PreemptiveAnswer
//
//  Created by LiChunYang on 25/1/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "TimeConvert.h"

@implementation TimeManage

//  时间戳  --> NSDate
+ (NSDate *_Nullable)convertFromTimestampToDateWithTimestamp:(NSTimeInterval)timestamp {
    //这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致
    NSTimeInterval seconds = timestamp / 1000.0;
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

//  NSDate --> 时间戳 从1970/1/1开始
+ (NSTimeInterval)convertFromDateToTimestampWithDate:(NSDate *_Nullable)date {
    NSTimeInterval interval = [date timeIntervalSince1970];
    NSTimeInterval totalMilliseconds = interval * 1000;
    return totalMilliseconds;
}

//   Format--> NSDate 从1970/1/1开始
+ (NSDate *_Nullable)convertFromFormatStringToDateWithFormatString:(NSString *_Nonnull)formatString format:(NSString *_Nonnull)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDate *destDate = [dateFormatter dateFromString:formatString];
    return destDate;
}

// NSDate --> Format
+ (NSString *_Nullable)convertFromDateToFormatStringWith:(NSDate *_Nonnull)date format:(NSString *_Nonnull)format {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSString *string = [dateFormat stringFromDate:date];
    return string;
}

//   Format--> 时间戳
+ (NSTimeInterval)convertFormatStringToTimestampWithFormatString:(NSString *_Nonnull)formatString format:(NSString *_Nonnull)format {
    NSTimeInterval time;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSDate *fromdate = [dateFormat dateFromString:formatString];
    time = [fromdate timeIntervalSince1970];
    return time;
}

//   Format--> 时间戳
+ (NSString *_Nullable)convertFromTimestampToFormatStringWithTimestamp:(NSTimeInterval)timestamp format:(NSString *_Nonnull)format {
    return [self convertFromDateToFormatStringWith:[self convertFromTimestampToDateWithTimestamp:timestamp] format:format];
}

@end


@implementation NSDate (GetTime)

- (NSString *_Nullable)getTimeWithFormat:(NSString *_Nonnull)format {
    return [TimeManage convertFromDateToFormatStringWith:self format:format];
}

@end
