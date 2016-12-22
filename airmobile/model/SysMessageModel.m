//
//  SysMessageModel.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/12/8.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "SysMessageModel.h"

@implementation SysMessageModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{

    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc]initWithDictionary:dictionary];
    NSArray *keys = [mutableDictionary allKeys];
    for (NSString *key in keys) {
        if ([key isEqualToString:@"msgid"]) {
            if ([[mutableDictionary objectForKey:key] isKindOfClass:[NSString class]]) {
                [mutableDictionary setObject:@(((NSString *)[mutableDictionary objectForKey:key]).integerValue) forKey:key];
            }
        }
    }
    return  [super initWithDictionary:[mutableDictionary copy]];
}


@end
