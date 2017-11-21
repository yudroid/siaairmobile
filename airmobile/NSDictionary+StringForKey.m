//
//  NSDictionary+StringForKey.m
//  airmobile
//
//  Created by xuesong on 2017/9/1.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "NSDictionary+StringForKey.h"

@implementation NSDictionary (StringForKey)

-(NSString *)stringForKey:(NSString *)key
{
    if (key == nil || [key isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if ([self objectForKey:key]== nil || [self objectForKey:key]) {
        return @"";
    }
    if (![[self objectForKey:key] isKindOfClass:[NSString class]]) {
        return @"";
    }
    return [self objectForKey:key];
}

@end
