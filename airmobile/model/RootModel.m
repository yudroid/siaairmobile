//
//  RootModel.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@implementation RootModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
//            NSArray *allKeys = [dictionary allKeys];
//            for (NSString *key in allKeys) {
//                if ([[dictionary objectForKey:key] isKindOfClass:[NSNull class]]) {
//
//                }
//            }
            [self setValuesForKeysWithDictionary:dictionary];
        }
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    return;
}

-(BOOL)isNull:(NSDictionary *)data
{
    return (data == nil
            || ([data isKindOfClass:[NSArray class]] && [data count]==0)
            || ([data isKindOfClass:[NSDictionary class]] && [[data allKeys] count]==0));
}

@end
