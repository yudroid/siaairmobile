//
//  FlightStusModel.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightStusModel.h"

@implementation FlightStusModel

-(NSMutableArray *)getAbnReasonArray
{
    if(_abnReasons == nil){
        _abnReasons = [[NSMutableArray alloc] init];
    }
    return _abnReasons;
}

-(NSMutableArray *)getRegionDlyTimeArray
{
    if(_regionDlyTimes == nil){
        _regionDlyTimes = [NSMutableArray array];
    }
    return _regionDlyTimes;
}

-(void) updateFlightStatusInfo:(id)data
{
    if([self isNull:data])
        return;
    
    _flightCount = [[data objectForKey:@"flightCount"] intValue];
    _arrCount = [[data objectForKey:@"arrCount"] intValue];
    _depCount = [[data objectForKey:@"depCount"] intValue];
    
    _arrDoneNormal = [[data objectForKey:@"arrDoneNormal"] intValue];
    _arrDoneAbn = [[data objectForKey:@"arrDoneAbn"] intValue];
    _arrPlanNormal = [[data objectForKey:@"arrPlanNormal"] intValue];
    _arrPlanAbn = [[data objectForKey:@"arrPlanAbn"] intValue];
    _arrDelay = [[data objectForKey:@"arrDelay"] intValue];
    _arrCancel = [[data objectForKey:@"arrCancel"] intValue];
    
    _depDoneNormal = [[data objectForKey:@"depDoneNormal"] intValue];
    _depDoneAbn = [[data objectForKey:@"depDoneAbn"] intValue];
    _depPlanNormal = [[data objectForKey:@"depPlanNormal"] intValue];
    _depPlanAbn = [[data objectForKey:@"depPlanAbn"] intValue];
    _depDelay = [[data objectForKey:@"depDelay"] intValue];
    _depCancel = [[data objectForKey:@"depCancel"] intValue];

}

-(void) updateFlightAbnReason:(id)data
{
    if([self isNull:data])
        return;
    int index = 0;
    for(NSDictionary *item in data){
        AbnReasonModel *model = nil;
        if([[self getAbnReasonArray] count]<index+1){
            model = [AbnReasonModel new];
            [[self getAbnReasonArray] addObject:model];
        }else{
            model = [[self getAbnReasonArray] objectAtIndex:index];
        }
        // hour：延误原因 count：延误数
        model.reason = [item objectForKey:@"hour"];
        model.count = [[item objectForKey:@"count"] intValue];
        index ++;
    }
}

-(void) updateRegionDlyTime:(id)data
{
    if([self isNull:data])
        return;
    int index = 0;
    for(NSDictionary *item in data){
        RegionDlyTimeModel *model = nil;
        if([[self getRegionDlyTimeArray] count]<index+1){
            model = [RegionDlyTimeModel new];
            [[self getRegionDlyTimeArray] addObject:model];
        }else{
            model = [[self getRegionDlyTimeArray] objectAtIndex:index];
        }
        // hour：地区 count：平均延误时间 ratio：延误的航班数
        model.region = [item objectForKey:@"hour"];
        model.count = [[item objectForKey:@"ratio"] floatValue];
        model.time = [[item objectForKey:@"count"] intValue];
        index ++;
    }
}

@end
