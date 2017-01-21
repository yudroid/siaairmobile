//
//  NSArray+ObjectTransform.m
//  airmobile
//
//  Created by xuesong on 17/1/17.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "NSArray+ObjectTransform.h"

@implementation NSArray (ObjectTransform)

-(NSArray <Class>*)DictionaryToModel:(Class)class
{
    id x = [[class alloc] init];
    NSMutableArray *mutableArray = [NSMutableArray array];
    if ([x respondsToSelector:@selector(initWithDictionary:)]) {
        for (NSDictionary *dic in self) {
            id element = [[class alloc]initWithDictionary:dic];
            [mutableArray addObject:element];
        }
    }
    return [mutableArray copy];
}

@end
