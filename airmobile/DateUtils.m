//
//  DateUtils.m
//  lwgoose
//
//  Created by chunminglu on 16/2/18.
//  Copyright © 2016年 taocares. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

/**
 *  将时间转换为字符串
 *
 *  @param date   <#date description#>
 *  @param foramt 如"yyyy-MM-dd"  "yyyy-MM-dd HH:mm:ss"
 *
 *  @return <#return value description#>
 */
+(NSString*) convertToString:(NSDate*) date format:(NSString*) foramt{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:foramt];
    NSTimeZone *timeZone=[NSTimeZone timeZoneWithAbbreviation:@"UTC"];;
    [formatter setTimeZone:timeZone];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSLog(@"%@",[formatter stringFromDate:date]);
    return [formatter stringFromDate:date];
}

/**
 *  将字符串转换为时间
 *
 *  @param str   <#date description#>
 *  @param foramt 如"yyyy-MM-dd"  "yyyy-MM-dd HH:mm:ss"
 *
 *  @return <#return value description#>
 */
+(NSDate *) convertToDate:(NSString*) str format:(NSString*) foramt{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:foramt];//设定时间格式,这里可以设置成自己需要的格式
    NSTimeZone *timeZone=[NSTimeZone timeZoneWithAbbreviation:@"UTC"];;
    [dateFormat setTimeZone:timeZone];
    dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    return [dateFormat dateFromString:str];
}

/**
 *  @author yangql, 16-03-09 10:03:03
 *
 *  @brief 返回2个时间之间的时间间隔
 *
 *  @param date1 开始时间 HH:mm
 *  @param date2 结束时间 HH:mm
 *
 *  @return 时间间隔 分钟
 */
+(int) betweenDate:(NSString *)date1 and:(NSString *)date2
{
    date2 = [date2 compare:date1]==-1?[NSString stringWithFormat:@"2016-3-16 %@:00",date2]:[NSString stringWithFormat:@"2016-3-15 %@:00",date2];
    date1 = [NSString stringWithFormat:@"2016-3-15 %@:00",date1];
    NSDate *dt1 = [self convertToDate:date1 format:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt2 = [self convertToDate:date2 format:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval time = [dt2 timeIntervalSinceDate:dt1];
    return time/60;
}


+ (NSDate *)getNow
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return [date  dateByAddingTimeInterval: interval];
}

@end
