//
//  FlightModel.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightModel.h"

@implementation FlightModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dictionary];
        for (NSString *key in dic.allKeys) {
            id value = [dic objectForKey:key];
            if ([value isKindOfClass:[NSNull class]]) {
                [dic setObject:@"" forKey:key];
            }
        }


        [self setValuesForKeysWithDictionary:dic];


        //判断是进港 出港 还是关联航班
        if([self.mInCity isKindOfClass:[NSNull class]]||[self.mInCity isEqualToString:@""]){
            self.flightType = FlightTypeOut;
        }else if (!self.mOutCity||[self.mOutCity isEqualToString:@""]){
            self.flightType = FlightTypeIn;
        }
        else{
            self.flightType = FlightTypeInOut;
        }
    }
    return self;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _id = ((NSNumber *)value).intValue;
    }

    return;
}


@end
