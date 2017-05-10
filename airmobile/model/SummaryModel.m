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
-(void)updateLastYearReleased:(NSArray *)data
{
    if (![data isKindOfClass:[NSArray class]]) {
        return;
    }
    _lastYearReleased = [data DictionaryToModel:[ReleasedRatioModel class]];
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

    _planTotal=((NSNumber *)[data objectForKey:@"planTotal"]).integerValue;
    _planIn=((NSNumber *)[data objectForKey:@"planIn"]).integerValue;//计划进港总数
    _planOut=((NSNumber *)[data objectForKey:@"planOut"]).integerValue;//计划出港总数
    //进港
    _inFinished=((NSNumber *)[data objectForKey:@"inFinished"]).integerValue;//进港已执行数
    _inNoFinished=((NSNumber *)[data objectForKey:@"inNoFinished"]).integerValue;//进港未执行数
    _inCancel=((NSNumber *)[data objectForKey:@"inCancel"]).integerValue;//进港取消数
    _inFinishedDelay=((NSNumber *)[data objectForKey:@"inFinishedDelay"]).integerValue;//进港已执行延误数
    _inNoFinishedDelay=((NSNumber *)[data objectForKey:@"inNoFinishedDelay"]).integerValue;//进港未执行延误数
    _inDelay=((NSNumber *)[data objectForKey:@"inDelay"]).integerValue;//进港延误数
    //出港
    _outFinished=((NSNumber *)[data objectForKey:@"outFinished"]).integerValue;//出港已执行数
    _outNoFinished=((NSNumber *)[data objectForKey:@"outNoFinished"]).integerValue;//出港未执行数
    _outCancel=((NSNumber *)[data objectForKey:@"outCancel"]).integerValue;//出港取消数
    _outFinishedDelay=((NSNumber *)[data objectForKey:@"outFinishedDelay"]).integerValue;//出港已执行延误数
    _outNoFinishedDelay=((NSNumber *)[data objectForKey:@"outNoFinishedDelay"]).integerValue;//出港未执行延误数
    _outDelay=((NSNumber *)[data objectForKey:@"outDelay"]).integerValue;//出港延误数
//
    _flightDate=[data objectForKey:@"flightDate"];//当天日期 年月日 格式为2016-09-08
    _leaderUserName=[data objectForKey:@"leaderUserName"];//值班领导名称
    _userName=[data objectForKey:@"userName"];//运行总监名称
    _allCnt=((NSNumber *)[data objectForKey:@"allCnt"]).integerValue; //当天所有航班数
    _finishedCnt=((NSNumber *)[data objectForKey:@"finishedCnt"]).integerValue;//已执行航班数
    _unfinishedCnt=((NSNumber *)[data objectForKey:@"unfinishedCnt"]).integerValue;//未执行航班数
    _releaseRatio=[data objectForKey:@"releaseRatio"];//放行正常率
    _warning=[data objectForKey:@"warning"];//航班正常性判定，分正常、蓝色IV级（小面积）、黄色Ⅲ级(一般)、橙色Ⅱ级(重大)、红色 Ⅰ级(严重)
    _releaseSpeed=((NSNumber *)[data objectForKey:@"releaseSpeed"]).floatValue;//出港放行速率
    _inSpeed=((NSNumber *)[data objectForKey:@"inSpeed"]).floatValue;//进港放行速率
    _yesterdayReleaseRatio=((NSNumber *)[data objectForKey:@"yesterdayReleaseRatio"]).floatValue;//昨日放行正常率
    _nowMonthAvgRatio=((NSNumber *)[data objectForKey:@"nowMonthAvgRatio"]).floatValue;//本月放行正常率


    if ([[data objectForKey:@"aovTxt"] isKindOfClass:[NSNull class]]) {
        _aovTxt     =   @"";
    }else{
        _aovTxt     =   [data objectForKey:@"aovTxt"];
    }

}
-(void)updateweekReleased:(NSArray *)data
{
    if (![data isKindOfClass:[NSArray class]]) {
        return;
    }
    _weekReleased = [data DictionaryToModel:[ReleasedRatioModel class]];
}

-(void)updatereleaseRatioThreshold2:(NSDictionary *)data
{
    _releaseRatioThreshold2 = ((NSNumber *)[data objectForKey:@"min"]).floatValue;
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
