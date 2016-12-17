//
//  DateUtils.h
//  lwgoose
//
//  Created by chunminglu on 16/2/18.
//  Copyright © 2016年 taocares. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

/**
 *  将时间转换为字符串
 *
 *  @param date   <#date description#>
 *  @param foramt 如"yyyy-MM-dd"  "yyyy-MM-dd HH:mm:ss"
 *
 *  @return <#return value description#>
 */
+(NSString*) convertToString:(NSDate*) date format:(NSString*) foramt;


/**
 *  将时间转换为字符串
 *
 *  @param str   <#date description#>
 *  @param foramt 如"yyyy-MM-dd"  "yyyy-MM-dd HH:mm:ss"
 *
 *  @return <#return value description#>
 */
+(NSDate*) convertToDate:(NSString*) str format:(NSString*) foramt;


/**
 *  @author yangql, 16-03-09 10:03:03
 *
 *  @brief 返回2个时间之间的时间间隔
 *
 *  @param date1 开始时间
 *  @param date2 结束时间
 *
 *  @return 时间间隔 分钟
 */
+(int) betweenDate:(NSString *)date1 and:(NSString *)date2;

+ (NSDate *) getNow;
@end
