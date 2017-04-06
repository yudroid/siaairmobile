//
//  ConcernModel.m
//  airmobile
//
//  Created by xuesong on 17/3/1.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "ConcernModel.h"

static NSString *CONCERNIDENTIFIER=@"CONCERNIDENTIFIER";

@implementation ConcernModel

-(instancetype)initWithFlightNo:(NSString *)flightNo
{
    self = [super init];
    if (self) {
        self.flightNo = flightNo;
    }
    return self;
}

+(NSArray<NSString *> *)allConcernModel
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:CONCERNIDENTIFIER];

}

+(void)addConcernModel:(NSString *)flightNo
{
    NSDictionary *dic = [self outFlightNo:flightNo];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [[userDefaults objectForKey:CONCERNIDENTIFIER] mutableCopy];
    if (array == nil) {
        array = [NSMutableArray array];
    }
    [array addObject:dic];
    [userDefaults setObject:[array copy] forKey:CONCERNIDENTIFIER];
}

+(void)removeConcernModel:(NSString *)flightNo
{
    NSDictionary *dic = [self outFlightNo:flightNo];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [[userDefaults objectForKey:CONCERNIDENTIFIER]mutableCopy];
    if (array == nil) {
        array = [NSMutableArray array];
    }
    for (NSDictionary *model in [array copy]) {
        if ([[model objectForKey:@"key"] isEqualToString:[dic objectForKey:@"key"]]) {
            [array removeObject:model];
        }
    }
    [userDefaults setObject:[array copy] forKey:CONCERNIDENTIFIER];
}

+(BOOL)isconcern:(NSString *)flightNo
{

    NSDictionary *dic = [self outFlightNo:flightNo];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [[userDefaults objectForKey:CONCERNIDENTIFIER] mutableCopy];
    if (array == nil) {
        return NO;
    }
    for (NSDictionary *model in array) {
        if ([[model objectForKey:@"key"] isEqualToString:dic[@"key"]]) {
            return YES;
        }
    }
    return NO;
}
+(void)removeAll
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:CONCERNIDENTIFIER];
}

//如果是关联航班截取出港段航班号，不是直接返回航班号
+(NSDictionary *)outFlightNo:(NSString *)flightNo
{
    if ([flightNo containsString:@"/"]) {
        NSArray *array = [flightNo componentsSeparatedByString:@"/"];
        if (array.count == 2) {
            return @{@"key":array[1],@"value":@(1)};
        }
    }
    return @{@"key":flightNo,@"value":@(0)};;

}
@end
