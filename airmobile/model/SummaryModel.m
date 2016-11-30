//
//  SummaryModel.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "SummaryModel.h"

@implementation SummaryModel

//@property (nonatomic, copy) NSMutableArray<FlightHourModel *> *flightHours;// 航班小时分布
//@property (nonatomic, copy) FlightLargeDelayModel *delayTagart;// 判断是否大面积航延指标
//@property (nonatomic, copy) NSMutableArray<ReleasedRatioModel *> *tenDayReleased;// 近10的放行正常率
//@property (nonatomic, copy) NSMutableArray<ReleasedRatioModel *> *yearReleased;// 今年放行正常率

-(NSMutableArray *)getFlightHoursArray
{
    if(_flightHours == nil){
        _flightHours = [NSMutableArray array];
    }
    return _flightHours;
}

-(NSMutableArray *)getTenDayReleasedArray
{
    if(_tenDayReleased == nil){
        _tenDayReleased = [[NSMutableArray alloc] init];
    }
    return _tenDayReleased;
}

-(NSMutableArray *)getYearReleasedArray
{
    if(_yearReleased == nil){
        _yearReleased = [NSMutableArray array];
    }
    return _yearReleased;
}

-(FlightLargeDelayModel *)getFlightLargeDelayModel
{
    if(_delayTagart)
        _delayTagart = [FlightLargeDelayModel new];
    return _delayTagart;
}

-(void)updateFlightHourModel:(NSDictionary *)data flag:(int)flag
{
    if([self isNull:data])
        return;
    int index = 0;
    NSDictionary *dic = nil;
    switch (flag) {
        case 1:
            dic = [data objectForKey:@"planArrFltH"];
            break;
            
        case 2:
            dic = [data objectForKey:@"realArrFltH"];
            break;
            
        case 3:
            dic = [data objectForKey:@"planDepFltH"];
            break;
            
        case 4:
            dic = [data objectForKey:@"realDepFltH"];
            break;
            
        default:
            break;
    }
    
    if([self isNull:dic])
        return;
    
    for(NSDictionary *item in dic){
        FlightHourModel *model = nil;
        if([[self getFlightHoursArray] count]<index+1){
            model = [FlightHourModel new];
            [[self getTenDayReleasedArray] addObject:model];
        }else{
            model = [[self getTenDayReleasedArray] objectAtIndex:index];
        }
        switch (flag) {
            case 1:
                model.planArrCount = [[item objectForKey:@"count"] intValue];
                break;
                
            case 2:
                model.arrCount = [[item objectForKey:@"count"] intValue];
                break;
                
            case 3:
                model.planDepCount = [[item objectForKey:@"count"] intValue];
                break;
                
            case 4:
                model.depCount = [[item objectForKey:@"count"] intValue];
                break;
                
            default:
                break;
        }
        index ++;
    }
}

-(void)updateTenDayReleased:(NSDictionary *)data
{
    if([self isNull:data])
        return;
    int index = 0;
    for(NSDictionary *item in data){
        ReleasedRatioModel *model = nil;
        if([[self getTenDayReleasedArray] count]<index+1){
            model = [ReleasedRatioModel new];
            [[self getTenDayReleasedArray] addObject:model];
        }else{
            model = [[self getTenDayReleasedArray] objectAtIndex:index];
        }
        model.time = [item objectForKey:@"hour"];
        model.ratio = [[item objectForKey:@"ratio"] floatValue];
        index ++;
    }
}

-(void)updateYearReleased:(NSDictionary *)data
{
    if([self isNull:data])
        return;
    int index = 0;
    for(NSDictionary *item in data){
        ReleasedRatioModel *model = nil;
        if([[self getYearReleasedArray] count]<index+1){
            model = [ReleasedRatioModel new];
            [[self getYearReleasedArray] addObject:model];
        }else{
            model = [[self getYearReleasedArray] objectAtIndex:index];
        }
        model.time = [item objectForKey:@"hour"];
        model.ratio = [[item objectForKey:@"ratio"] floatValue];
        index ++;
    }
}

-(void)updatePropertyData:(NSDictionary *)data
{
    if([self isNull:data])
        return;
    _flightDate     =   [data objectForKey:@"flightDate"];
    _userName       =   [data objectForKey:@"userName"];
    _allCnt         =   [[data objectForKey:@"allCnt"] intValue];
    _finishedCnt    =   [[data objectForKey:@"finishedCnt"] intValue];
    _unfinishedCnt  =   [[data objectForKey:@"unfinishedCnt"] intValue];
    _releaseRatio   =   [data objectForKey:@"releaseRatio"];
    _warning        =   [data objectForKey:@"warning"];
    _aovTxt         =   [data objectForKey:@"aovTxt"];
}

-(void)updateFlightDelayTarget:(NSDictionary *)data
{
    if([self isNull:data])
        return;
    
    FlightLargeDelayModel *model = [self getFlightLargeDelayModel];

    model.allOutCnt                     = [[data objectForKey:@"allOutCnt"] intValue];
    model.delayOneHourCnt               = [[data objectForKey:@"delayOneHourCnt"] intValue];
    model.delayOneHourRatio             = [[data objectForKey:@"delayOneHourRatio"] floatValue];
    model.delayOneHourRatioThreshold    = [[data objectForKey:@"delayOneHourRatioThreshold"] floatValue];
    model.executeRateThreshold          = [[data objectForKey:@"executeRateThreshold"] floatValue];
    [model updateHourExecuteRateList:      [data objectForKey:@"hourExecuteRateList"]];
    model.glqPassenCnt                  = [[data objectForKey:@"glqPassenCnt"] intValue];
    model.glqPassenThreshold            = [[data objectForKey:@"glqPassenThreshold"] floatValue];
    model.noTakeoffAndLanding           = [[data objectForKey:@"noTakeoffAndLanding"] intValue];
    model.noTakeoffAndLandingThreshold  = [[data objectForKey:@"noTakeoffAndLandingThreshold"] intValue];
}


@end
