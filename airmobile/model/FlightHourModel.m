//
//  FlightHourModel.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightHourModel.h"

@implementation FlightHourModel

-(instancetype) initWithHour:(NSString *)hour count:(int)count
{
    return [self initWithHour:hour count:count planCount:0];
}

-(instancetype) initWithHour:(NSString *)hour count:(int)count planCount:(int)planCount
{
    self = [super init];
    if(self){
        _hour = hour;
        _count = count;
        _planCount = planCount;
    }
    return self;
}

-(instancetype) initWithHour:(NSString *)hour
                       count:(int)count
                   planCount:(int)planCount
                    arrCount:(int)arrCount
                planArrCount:(int)planArrCount
                    depCount:(int)depCount
                planDepCount:(int)planDepCount
                      before:(BOOL)before
{
    self = [super init];
    if(self){
        _hour           = hour;
        _arrCount       = arrCount;
        _planArrCount   = planArrCount;
        _depCount       = depCount;
        _planDepCount   = planDepCount;
        _before         = before;

        //        _count = count;
        //        _planCount = planCount;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self  = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

-(long) getCount
{
    return _arrCount+_depCount;
}

-(long) getPlanCount
{
    return _planArrCount+_planDepCount;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"hour:%@",_hour];
}




@end
