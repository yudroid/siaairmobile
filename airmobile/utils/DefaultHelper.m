//
//  DefaultHelper.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "DefaultHelper.h"

@implementation DefaultHelper

+(NSString*) getStringForKey:(NSString*) key{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    //Returns nil if the default does not exist or is not a string or number value.
    NSString* result = [userDefaults stringForKey:key];
    
    return result;
}

+(NSString*) getStringForKey:(NSString*) key default:(NSString*) defaultValue{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    //Returns nil if the default does not exist or is not a string or number value.
    NSString* result = [userDefaults stringForKey:key];
    
    if (result == nil) {
        return defaultValue;
    }
    else{
        return result;
    }
}

/**
 *  讲key和value组成的配置项写到磁盘上
 *
 *  @param value <#value description#>
 */
+(void) setString:(NSString*) value forKey:(NSString*)key{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    //同步到磁盘
    [userDefaults synchronize];
}

#pragma mark -BOOL

/**
 *  获取key关联的bool值，如果没有关联的key,返回NO
 *
 *  @param key key
 *
 *  @return bool
 */
+(BOOL) getBoolForKey:(NSString*)key{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    //If a boolean value is associated with defaultName in the user defaults, that value is returned. Otherwise, NO is returned.
    BOOL result = [userDefaults boolForKey:key];
    return result;
}

/**
 *  将key和value组成的配置项写到磁盘上
 *
 *  @param key <#key description#>
 */
+(void) setBool:(BOOL) value forKey:(NSString*) key{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    //同步到磁盘
    [userDefaults synchronize];
}

@end
