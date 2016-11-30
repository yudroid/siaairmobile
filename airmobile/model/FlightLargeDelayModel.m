//
//  FlightLargeDelayModel.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightLargeDelayModel.h"

@implementation FlightLargeDelayModel

-(void) updateHourExecuteRateList:(NSDictionary *)responesObj
{
    if([self isNull:responesObj]){
        return;
    }
    
    // NSDictionary {"count":0,"hour":"23","ratio":0.8}
    [[self getHourExecuteRateList] removeAllObjects];
    for(NSDictionary *item in responesObj){
        [[self getHourExecuteRateList] addObject:item];
    }
}

-(NSMutableArray *) getHourExecuteRateList
{
    if(_hourExecuteRateList==nil)
        _hourExecuteRateList = [NSMutableArray array];
    return _hourExecuteRateList;
}

@end
