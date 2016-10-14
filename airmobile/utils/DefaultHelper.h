//
//  DefaultHelper.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  作为NSUserDefaults的拓展工具类
 *  NSUserDefaults用于存储数据量小的数据，如用户配置
 *  NSUserDefaults支持NSSString NSNumber,NSArray,NSDictionary,NSDate
 */
@interface DefaultHelper : NSObject

/**
 *  获取字符串关联的字符串值
 *
 *  @param key <#key description#>
 *
 *  @return 如果没有关联的key，返回nil
 */
+(NSString*) getStringForKey:(NSString*) key;

/**
 *  获取字符串关联的字符串值
 *
 *  @param key          <#key description#>
 *  @param defaultValue <#defaultValue description#>
 *
 *  @return 如果没有关联的key,返回defaultValue
 */
+(NSString*) getStringForKey:(NSString*) key default:(NSString*) defaultValue;

/**
 *  将key和value组成的配置项写到磁盘上
 *
 *  @param value <#value description#>
 */
+(void) setString:(NSString*) value forKey:(NSString*)key;

/**
 *  获取key关联的bool值，如果没有关联的key,返回NO
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
+(BOOL) getBoolForKey:(NSString*)key;

/**
 *  将key和value组成的配置项写到磁盘上
 *
 *  @param key <#key description#>
 */
+(void) setBool:(BOOL) value forKey:(NSString*) key;

@end
