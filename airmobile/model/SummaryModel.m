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
    NSDictionary *planDic = nil;
    NSDictionary *realDic = nil;
    switch (flag) {
        case 1:
            planDic = [data objectForKey:@"planArrFltH"];
            realDic = [data objectForKey:@"realArrFltH"];
            break;
        case 2:
            planDic = [data objectForKey:@"planDepFltH"];
            realDic = [data objectForKey:@"realDepFltH"];
            break;
            
        default:
            break;
    }
    

    
    for(NSDictionary *item in planDic){
        FlightHourModel *model = nil;
        if([[self getFlightHoursArray] count]<index+1){
            model = [FlightHourModel new];
            [[self getFlightHoursArray] addObject:model];
        }else{
            model = [[self getFlightHoursArray] objectAtIndex:index];
        }
        model.hour = [item objectForKey:@"hour"];
        switch (flag) {
            case 1:
                model.planArrCount  = [[item objectForKey:@"count"] intValue];
                break;
            case 2:
                model.planDepCount  = [[item objectForKey:@"count"] intValue];
                break;
            default:
                break;
        }
        index ++;
    }
    index = 0;
    for(NSDictionary *item in realDic){
        FlightHourModel *model = nil;
        if([[self getFlightHoursArray] count]<index+1){
            model = [FlightHourModel new];
            [[self getFlightHoursArray] addObject:model];
        }else{
            model = [[self getFlightHoursArray] objectAtIndex:index];
        }
        model.hour = [item objectForKey:@"hour"];
        switch (flag) {
            case 1:
                model.arrCount  = [[item objectForKey:@"count"] intValue];
                break;
            case 2:
                model.depCount  = [[item objectForKey:@"count"] intValue];
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

-(void)updateReleaseRatioThreshold:(NSString *)data
{
    if ([data isKindOfClass:[data class]]) {
        _releaseRatioThreshold = data.floatValue;
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
    if ([[data objectForKey:@"aovTxt"] isKindOfClass:[NSNull class]]) {
        _aovTxt     =   @"";
    }else{
        _aovTxt     =   [data objectForKey:@"aovTxt"];
    }

}

-(void)updateFlightDelayTarget:(NSDictionary *)data
{
    if([self isNull:data])
        return;
    
//    FlightLargeDelayModel *model = [self getFlightLargeDelayModel];
    if(_delayTagart==nil){
        _delayTagart = [[FlightLargeDelayModel alloc]init];
    }

    _delayTagart.allOutCnt                     = [[data objectForKey:@"allOutCnt"] intValue];
    _delayTagart.delayOneHourCnt               = [[data objectForKey:@"delayOneHourCnt"] intValue];
    _delayTagart.delayOneHourRatio             = [[data objectForKey:@"delayOneHourRatio"] doubleValue]+0.0001;
    _delayTagart.delayOneHourRatioThreshold    = [[data objectForKey:@"delayOneHourRatioThreshold"] floatValue];
    _delayTagart.executeRateThreshold          = [[data objectForKey:@"executeRateThreshold"] floatValue];
    [_delayTagart updateHourExecuteRateList:      [data objectForKey:@"hourExecuteRateList"]];
    _delayTagart.glqPassenCnt                  = [[data objectForKey:@"glqPassenCnt"] intValue];
    _delayTagart.glqPassenThreshold            = [[data objectForKey:@"glqPassenThreshold"] floatValue];
    _delayTagart.noTakeoffAndLanding           = [[data objectForKey:@"noTakeoffAndLanding"] intValue];
    _delayTagart.noTakeoffAndLandingThreshold  = [[data objectForKey:@"noTakeoffAndLandingThreshold"] intValue];
}


@end
