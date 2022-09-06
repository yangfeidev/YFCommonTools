//
//  NSDate+YFAdd.h
//  IOSMall
//
//  Created by YangFei on 2016/12/30.
//  Copyright © 2016年 Social. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YFAdd)


/**
 通过服务器返回的毫秒数, 计算当前时间

 @param milliSecond 毫秒数值
 @return 当前时间字符串
 */
+ (NSString *)yf_dateWithMilliSecond:(int64_t)milliSecond;


+ (NSString *)yf_dateWithSecond:(int64_t)second;


/**
 判断一个date是否在一个时间段内

 @param date 要判断的时间
 @param beginDate 开始时间
 @param endDate 结束时间
 @return 是否在这个时间内 bool值
 */
- (BOOL)yf_isBetweenBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate;



/**
 获取当前时间戳, 秒级

 @return 时间戳字符串,
 */
+ (NSString *)yf_timestamp;


/*
 时间字符串转时间 转化为  NSDate
 
 2014-01-20 12:24:48
 2014-01-20T12:24:48
 2014-01-20 12:24:48.000
 2014-01-20T12:24:48.000
 */

NSDate* YFDateFromString(NSString *string);


/// 判断两个date是否是同一天
/// @param date1
/// @param date2
BOOL IsSameDay(NSDate *date1, NSDate *date2);


/// 传入formatter的格式, 输出格式化时间字符串
/// 输入 yyyy年MM月dd日 输出 2018年08月08日
/// @param string  yyyy-MM-dd HH:mm:ss   yyyy年MM月dd日  ...
- (NSString *)yf_formatterDateToString:(NSString *)string;


- (BOOL) yf_isEarlierThanDate: (NSDate *) aDate;


- (BOOL) yf_isLaterThanDate: (NSDate *) aDate;



@end
