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
        _tenDayReleased = [NSMutableArray array];
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

-(void)updateFlightHourModel:(NSDictionary *)data
{
    if([self isNull:data])
        return;

}

-(void)updateTenDayReleased:(NSDictionary *)data
{
    if([self isNull:data])
        return;
    for(NSDictionary *item in data){
//        FlightHourModel *model = [[self getFlightHoursArray] objectAtIndex:<#(NSUInteger)#>];
    }
}

-(void)updateYearReleased:(NSDictionary *)data
{
    if([self isNull:data])
        return;
    for(NSDictionary *item in data){
        //       FlightHourModel *model = [[self getFlightHoursArray] objectAtIndex:<#(NSUInteger)#>];
    }
}

-(void)updatePropertyData:(NSDictionary *)data
{
    if([self isNull:data])
        return;
    _flightDate = [data objectForKey:@"flightDate"];
    _userName = [data objectForKey:@"userName"];
    _allCnt = [[data objectForKey:@"allCnt"] intValue];
    _finishedCnt = [[data objectForKey:@"finishedCnt"] intValue];
    _unfinishedCnt = [[data objectForKey:@"unfinishedCnt"] intValue];
    _releaseRatio = [data objectForKey:@"releaseRatio"];
    _warning = [data objectForKey:@"warning"];
    _aovTxt = [data objectForKey:@"aovTxt"];
}

-(BOOL)isNull:(NSDictionary *)data
{
   return (data == nil || [[data allKeys] count]==0);
    
}

@end
