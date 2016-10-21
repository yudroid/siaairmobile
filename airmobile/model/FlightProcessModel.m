//
//  FlightProcessModel.m
//  airmobile
//
//  Created by xuesong on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightProcessModel.h"

@implementation FlightProcessModel


//防止崩溃
- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
