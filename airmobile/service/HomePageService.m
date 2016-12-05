 //
//  HomePageService.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/2.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "HomePageService.h"
#import "SummaryModel.h"
#import "FlightStusModel.h"
#import "PassengerModel.h"
#import "SeatStatusModel.h"
#import "HttpsUtils+Business.h"

@implementation HomePageService
{
    SummaryModel    *summaryModel;  // 首页概览数据
    FlightStusModel *flightModel;   // 航班数据
    PassengerModel  *psnModel;      // 旅客数据
    SeatStatusModel *seatModel;     // 机位数据
    
}
singleton_implementation(HomePageService);

-(void)startService
{
    if(summaryModel == nil){
        summaryModel    = [SummaryModel new];
    }
    if(flightModel  == nil){
        flightModel     = [FlightStusModel new];
    }
    if(psnModel     == nil){
        psnModel        = [PassengerModel new];
    }
    if(seatModel    == nil){
        seatModel       = [SeatStatusModel new];
    }
    
    [super startService:^{
        [self cacheHomePageData];
    }];
}

-(void)cacheHomePageData
{
    [self cacheSummaryData];
    [self cacheFlightData];
    [self cachePassengerData];
    [self cacheSeatUsedData];
}

#pragma mark 首页摘要信息、小时分布、放行正常率、航延关键指标

-(void) cacheSummaryData
{
    [HttpsUtils getSummaryInfo:nil success:^(id responesObj) {
        [summaryModel updatePropertyData:responesObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SummaryInfo"
                                                            object:summaryModel];
    } failure:nil];
    
    // 航班近10天放行正常率

    [HttpsUtils getFlightTenDayRatio:nil success:^(id responesObj) {
        [summaryModel updateTenDayReleased:responesObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FlightTenDayRatio"
                                                            object:summaryModel.tenDayReleased];
    } failure:nil];
    
    // 今年航班放行正常率
    [HttpsUtils getFlightYearRatio:nil success:^(id responesObj) {
        [summaryModel updateYearReleased:responesObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FlightYearRatio"
                                                            object:summaryModel.yearReleased];
    } failure:nil];
    
    // 航班延误指标 /fltLD
    [HttpsUtils getFlightDelayTarget:nil success:^(id responesObj) {
        [summaryModel updateFlightDelayTarget:responesObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FlightDelayTarget"
                                                            object:summaryModel.delayTagart];
    } failure:nil];
    
    // 计划进港航班小时分布 /flt/planArrFltPerHour
    [HttpsUtils getPlanArrHours:nil success:^(id responesObj) {
        [summaryModel updateFlightHourModel:responesObj flag:1];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlanArrHours" object:summaryModel.flightHours];
    } failure:nil];
    
    // 实际进港航班小时分布 /flt/realArrFltPerHour
    [HttpsUtils getRealArrHours:nil success:^(id responesObj) {
        [summaryModel updateFlightHourModel:responesObj flag:2];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RealArrHours" object:summaryModel.flightHours];
    } failure:nil];
    
    // 计划出港航班小时分布 /flt/depFltPerHour
    [HttpsUtils getPlanDepHours:nil success:^(id responesObj) {
        [summaryModel updateFlightHourModel:responesObj flag:3];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlanDepHours" object:summaryModel.flightHours];
    } failure:nil];
    
    // 实际出港航班小时分布 /flt/realDepFltPerHour
    [HttpsUtils getRealDepHours:nil success:^(id responesObj) {
        [summaryModel updateFlightHourModel:responesObj flag:4];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RealDepHours" object:summaryModel.flightHours];
    } failure:nil];
}

-(SummaryModel *)getSummaryModel
{


    return summaryModel;

}


#pragma mark 首页航班汇总、异常原因分类、延误时长、小时分布

-(void) cacheFlightData
{
    
    [HttpsUtils getFlightStatusInfo:nil success:^(id responesObj) {
        [flightModel updateFlightStatusInfo:responesObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FlightStatusInfo"
                                                            object:flightModel];
    } failure:nil];
    
    // 航班异常原因分类 /flt/delayReasonSort
    [HttpsUtils getFlightAbnReason:nil success:^(id responesObj) {
        [flightModel updateFlightAbnReason:responesObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FlightAbnReason"
                                                            object:flightModel];
    } failure:nil];
    
    // 航班区域延误时间 /flt/delayAreaSort
    [HttpsUtils getRegionDlyTime:nil success:^(id responesObj) {
        [flightModel updateRegionDlyTime:responesObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RegionDlyTime"
                                                            object:flightModel.regionDlyTimes];
    } failure:nil];

}

-(FlightStusModel *)getFlightStusModel
{

    return flightModel;
}

#pragma mark 首页旅客页面 旅客摘要 旅客预测 隔离区内旅客小时分布 隔离区内旅客区域分布 机上等待旅客信息

-(void) cachePassengerData
{
    //旅客摘要
    [HttpsUtils getPassengerSummary:nil success:^(id responseObj) {
        [psnModel updatePassengerSummary:responseObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PassengerSummary"
                                                            object:psnModel];
    } failure:nil];
    //预测
    [HttpsUtils getPassengerForecast:nil success:^(id responseObj) {
        [psnModel updatePassengerForecast:responseObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PassengerForecast"
                                                            object:psnModel];
    } failure:nil];

    //获取隔离区内旅客信息
    [HttpsUtils getSafetyPassenger:nil success:^(id responseObj) {
        [psnModel updateSafetyPassenger:responseObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SafetyPassenger"
                                                            object:psnModel];
    } failure:nil];

    //机上旅客等待信息
    [HttpsUtils getPassengerOnboard:nil success:^(id responseObj) {
        [psnModel updatePassengerOnboard:responseObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PassengerOnboard"
                                                            object:psnModel];
    } failure:nil];

    //进港旅客小时分布
    [HttpsUtils getArrPsnHours:nil success:^(id responseObj) {
        [psnModel updatePsnHours:responseObj flag:1];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ArrPsnHours"
                                                            object:psnModel];
    } failure:nil];

    //出港旅客小时分布
    [HttpsUtils getDepPsnHours:nil success:^(id responseObj) {
        [psnModel updatePsnHours:responseObj flag:2];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DepPsnHours"
                                                            object:psnModel];
    } failure:nil];

    //隔离区内旅客小时分布
    [HttpsUtils getSafetyPsnHours:nil success:^(id responseObj) {
        [psnModel updatePsnHours:responseObj flag:3];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SafetyPsnHours"
                                                            object:psnModel.psnHours];
    } failure:nil];

    //旅客区域分布
    [HttpsUtils getGlqNearPsn:nil success:^(id responseObj) {
        [psnModel updateGlqNearPsn:responseObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GlqNearPsn"
                                                            object:psnModel.psnNearAreas];
    } failure:nil];

    [HttpsUtils getGlqFarPsn:nil success:^(id responseObj) {
        [psnModel updateGlqFarPsn:responseObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GlqFarPsn"
                                                            object:psnModel.psnFarAreas];
    } failure:nil];    //高峰旅客日排名
    [HttpsUtils getPeakPnsDays:nil success:^(id responseObj) {
        [psnModel updatePeakPnsDays:responseObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PeakPnsDays"
                                                            object:psnModel];
    } failure:nil];
}

-(PassengerModel *)getPassengerTopModel
{

    return  psnModel;
}

#pragma mark 首页资源 机位使用信息

-(void) cacheSeatUsedData
{
    // 机位占用信息
    [HttpsUtils getCraftSeatTakeUpInfo:nil success:^(id responseObj) {
        [seatModel updateCraftSeatTakeUpInfo:responseObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CraftSeatTakeUpInfo"
                                                            object:seatModel];
    } failure:nil];

    // 机位占用预测
    [HttpsUtils getWillCraftSeatTakeUp:nil success:^(id responseObj) {
        [seatModel updateWillCraftSeatTakeUp:responseObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WillCraftSeatTakeUp"
                                                            object:seatModel];
    } failure:nil];
    
    // 机位类型占用详情
    [HttpsUtils getCraftSeatTypeTakeUpSort:nil success:^(id responseObj) {
        [seatModel updateCraftSeatTypeTakeUp:responseObj];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CraftSeatTypeTakeUpSort"
                                                            object:seatModel.usedDetail];
    } failure:nil];
}

-(SeatStatusModel *)getSeatStatusModel
{
    seatModel.seatNum = 325;
    seatModel.seatUsed = 301;
    seatModel.seatFree = 24;
    seatModel.nextIn = 150;
    seatModel.nextOut = 30;

    CraftseatCntModel *craftSeatCntModel = [[CraftseatCntModel alloc]init];
    craftSeatCntModel.allCount = 900;
    craftSeatCntModel.currentTakeUp = 800;
    craftSeatCntModel.unusable = 50;
    craftSeatCntModel.longTakeUp = 50;
    craftSeatCntModel.todayFltTakeUp = 500;
    craftSeatCntModel.idle = 7;
    craftSeatCntModel.passNight = 10;
    craftSeatCntModel.takeUpRatio = 8/9.0;

    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:[[SeatUsedModel alloc] initWithType:@"B" free:25 used:75]];
    [array addObject:[[SeatUsedModel alloc] initWithType:@"C" free:35 used:40]];
    [array addObject:[[SeatUsedModel alloc] initWithType:@"D" free:40 used:35]];
    [array addObject:[[SeatUsedModel alloc] initWithType:@"E" free:25 used:15]];
    [array addObject:[[SeatUsedModel alloc] initWithType:@"F" free:25 used:35]];
    craftSeatCntModel.seatUsed = array;
    seatModel.usedDetail = craftSeatCntModel;
    return seatModel;
}

@end
