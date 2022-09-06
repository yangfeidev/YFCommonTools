//
//  NSDate+YFAdd.m
//  IOSMall
//
//  Created by YangFei on 2016/12/30.
//  Copyright © 2016年 Social. All rights reserved.
//

#import "NSDate+YFAdd.h"

@implementation NSDate (YFAdd)

/// 毫秒转时间
+ (NSString *)yf_dateWithMilliSecond:(int64_t)milliSecond {
    
    long long second = milliSecond/1000.0f;
    NSDate *dateTime = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [dateFormatter stringFromDate:dateTime];
    
    return dateString;
}
/// 秒转时间
+ (NSString *)yf_dateWithSecond:(int64_t)second {
    NSDate *dateTime = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [dateFormatter stringFromDate:dateTime];
    
    return dateString;
}


- (BOOL)yf_isBetweenBeginDate:(NSDate*)beginDate endDate:(NSDate*)endDate {
    if ([self compare:beginDate] == NSOrderedAscending)  return NO;
    if ([self compare:endDate] == NSOrderedDescending)  return NO;
    return YES;
}

+ (NSString *)yf_timestamp {
    NSDate *date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", sec];
    return timeString;
}

NSDate* YFDateFromString(NSString *string) {
    
    /// 去掉 时间后边的毫秒
    NSArray *timesArr = [string componentsSeparatedByString:@"."];
    string = (timesArr.count == 2) ? timesArr.firstObject : string;
    
    
    typedef NSDate* (^YYNSDateParseBlock)(NSString *string);
    #define kParserNum 34
    static YYNSDateParseBlock blocks[kParserNum + 1] = {0};
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        {
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.dateFormat = @"HH:mm:ss";
            blocks[8] = ^(NSString *string) { return [formatter dateFromString:string]; };
        }
        
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd";
            blocks[10] = ^(NSString *string) { return [formatter dateFromString:string]; };
        }
        
        {

            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            formatter1.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
            
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            formatter2.dateFormat = @"yyyy-MM-dd HH:mm:ss";

            NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
            formatter3.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS";

            NSDateFormatter *formatter4 = [[NSDateFormatter alloc] init];
            formatter4.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
            
            
            NSDateFormatter *formatter5 = [[NSDateFormatter alloc] init];
            formatter5.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SS";
            
            NSDateFormatter *formatter6 = [[NSDateFormatter alloc] init];
            formatter6.dateFormat = @"yyyy-MM-dd HH:mm:ss.SS";
            
            
            blocks[22] = ^(NSString *string) {
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter5 dateFromString:string];
                } else {
                    return [formatter6 dateFromString:string];
                }
            };
            
            
            
            blocks[19] = ^(NSString *string) {
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter1 dateFromString:string];
                } else {
                    return [formatter2 dateFromString:string];
                }
            };
            
      

            blocks[23] = ^(NSString *string) {
                if ([string characterAtIndex:10] == 'T') {
                    return [formatter3 dateFromString:string];
                } else {
                    return [formatter4 dateFromString:string];
                }
            };
        }
        
        {
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";

            NSDateFormatter *formatter2 = [NSDateFormatter new];
            formatter2.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";

            blocks[20] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[24] = ^(NSString *string) { return [formatter dateFromString:string]?: [formatter2 dateFromString:string]; };
            blocks[25] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[28] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
            blocks[29] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
        }
        
        {
            /*
             Fri Sep 04 00:12:21 +0800 2015 // Weibo, Twitter
             Fri Sep 04 00:12:21.000 +0800 2015
             */
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.timeZone = [NSTimeZone defaultTimeZone];
            formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";

            NSDateFormatter *formatter2 = [NSDateFormatter new];
            formatter2.timeZone = [NSTimeZone defaultTimeZone];
            formatter2.dateFormat = @"EEE MMM dd HH:mm:ss.SSS Z yyyy";

            blocks[30] = ^(NSString *string) { return [formatter dateFromString:string]; };
            blocks[34] = ^(NSString *string) { return [formatter2 dateFromString:string]; };
        }

    });
    if (!string) return nil;
    if (string.length > kParserNum) return nil;
    YYNSDateParseBlock parser = blocks[string.length];
    if (!parser) return nil;
    return parser(string);
    #undef kParserNum
}

- (NSString *)yf_formatterDateToString:(NSString *)string {
    
    static NSDictionary * formatterStrings = nil;
    static NSMutableArray *formatters = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        formatterStrings = @{@"yyyy-MM-dd"       :@"yyyy-MM-dd",
                             @"yyyy年MM月dd日"    :@"yyyy年MM月dd日",
                             @"yyyy年MM月"        :@"yyyy年MM月",
                             @"MM月dd日"          :@"MM月dd日",
                             @"yyyy.MM.dd"       :@"yyyy.MM.dd",
                             @"yyyy.MM.dd HH:mm" :@"yyyy.MM.dd HH:mm",
                             @"HH:mm:ss"         :@"HH:mm:ss",
                             @"HH:mm"            :@"HH:mm",
                             @"yyyy-MM-dd HH:mm" :@"yyyy-MM-dd HH:mm",
                             @"yyyy-MM-dd HH.mm.ss" :@"yyyy-MM-dd HH.mm.ss",
                             @"yyyy.MM.dd HH:mm:ss": @"yyyy.MM.dd HH:mm:ss",
                             @"(EEE)HH:mm"      :    @"(EEE)HH:mm"
                             
        };
        NSMutableArray *tempArr = [NSMutableArray new];
        for (NSString *string in formatterStrings.allKeys) {
            NSDateFormatter *formatter1 = [NSDateFormatter new];
            formatter1.timeZone = [NSTimeZone defaultTimeZone];
            [formatter1 setDateFormat:string];
            [tempArr addObject:formatter1];
        }
        formatters = tempArr;
    });
    
    for (NSDateFormatter *formatter in formatters) {
        if ([formatter.dateFormat isEqualToString:string]) {
            return [formatter stringFromDate:self];
        }
    }

    return nil;
}

- (BOOL) yf_isEarlierThanDate: (NSDate *) aDate {
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) yf_isLaterThanDate: (NSDate *) aDate {
    return ([self compare:aDate] == NSOrderedDescending);
}

// 判断两个date 是否是同一天
BOOL IsSameDay(NSDate *date1, NSDate *date2) {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    // 要比较的那个日期，NSDate类型
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:date2];
    // 跟现在的时间相比
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:date1];
    return  [comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year]  == [comp2 year];
}

@end
