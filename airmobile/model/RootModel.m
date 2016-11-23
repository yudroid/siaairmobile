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
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

-(id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

-(BOOL)isNull:(NSDictionary *)data
{
    return (data == nil || ([data isKindOfClass:[NSArray class]] && [data count]==0) || ([data isKindOfClass:[NSDictionary class]] && [[data allKeys] count]==0));
}

@end
