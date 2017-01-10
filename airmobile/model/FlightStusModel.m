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
    

    _flightCount    = [[data objectForKey:@"planTotal"]     intValue];
    _arrCount       = [[data objectForKey:@"planIn"]        intValue];
    _depCount       = [[data objectForKey:@"planOut"]       intValue];
    
    _arrDoneNormal  = [[data objectForKey:@"inFinished"]    intValue];
    _arrDoneAbn     = [[data objectForKey:@"inFinishedDelay"]   intValue];
    _arrPlanNormal  = [[data objectForKey:@"inNoFinished"]  intValue];
    _arrPlanAbn     = [[data objectForKey:@"inNoFinishedDelay"] intValue];
    _arrDelay       = [[data objectForKey:@"inDelay"]       intValue];
    _arrCancel      = [[data objectForKey:@"inCancel"]      intValue];
    
    _depDoneNormal  = [[data objectForKey:@"outFinished"]   intValue];
    _depDoneAbn     = [[data objectForKey:@"outFinishedDelay"] intValue];
    _depPlanNormal  = [[data objectForKey:@"outNoFinished"] intValue];
    _depPlanAbn     = [[data objectForKey:@"outNoFinishedDelay"] intValue];
    _depDelay       = [[data objectForKey:@"outDelay"]      intValue];
    _depCancel      = [[data objectForKey:@"outCancel"]     intValue];

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
        model.region    = [item objectForKey:@"areaName"];
        model.count     = [[item objectForKey:@"delayFlightCnt"] floatValue];
        model.time      = [[item objectForKey:@"avgDelayTime"] intValue];
        index ++;
    }
}

-(void) updateDepFltTarget:(NSDictionary *)data
{
    if ([data isKindOfClass:[NSDictionary class]]&&[[data objectForKey:@"hourDepFltThreshold"] isKindOfClass:[NSString class]] ) {
        _depFltTarget = ((NSString *)[data objectForKey:@"hourDepFltThreshold"]).floatValue;
    }
}

@end
