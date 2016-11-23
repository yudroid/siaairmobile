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
    SummaryModel *summaryModel;// 首页概览数据
    FlightStusModel *flightModel;// 航班数据
    PassengerModel *psnModel;// 旅客数据
    SeatStatusModel *seatModel;// 机位数据
    
}
singleton_implementation(HomePageService);

-(void)startService
{
    if(summaryModel == nil){
        summaryModel = [SummaryModel new];
    }
    if(flightModel == nil){
        flightModel = [FlightStusModel new];
    }
    if(psnModel == nil){
        psnModel = [PassengerModel new];
    }
    if(seatModel == nil){
        seatModel = [SeatStatusModel new];
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
    } failure:nil];
    
    // 航班近10天放行正常率
    [HttpsUtils getFlightTenDayRatio:nil success:^(id responesObj) {
        [summaryModel updateTenDayReleased:responesObj];
    } failure:nil];
    
    // 今年航班放行正常率
    [HttpsUtils getFlightYearRatio:nil success:^(id responesObj) {
        [summaryModel updateYearReleased:responesObj];
    } failure:nil];
    
    // 航班延误指标 /fltLD
    [HttpsUtils getFlightDelayTarget:nil success:^(id responesObj) {
        [summaryModel updateFlightDelayTarget:responesObj];
    } failure:nil];
    
    // 计划进港航班小时分布 /flt/planArrFltPerHour
    [HttpsUtils getPlanArrHours:nil success:^(id responesObj) {
        [summaryModel updateFlightHourModel:responesObj flag:1];
    } failure:nil];
    
    // 实际进港航班小时分布 /flt/realArrFltPerHour
    [HttpsUtils getRealArrHours:nil success:^(id responesObj) {
        [summaryModel updateFlightHourModel:responesObj flag:2];
    } failure:nil];
    
    // 计划出港航班小时分布 /flt/depFltPerHour
    [HttpsUtils getPlanDepHours:nil success:^(id responesObj) {
        [summaryModel updateFlightHourModel:responesObj flag:3];
    } failure:nil];
    
    // 实际出港航班小时分布 /flt/realDepFltPerHour
    [HttpsUtils getRealDepHours:nil success:^(id responesObj) {
        [summaryModel updateFlightHourModel:responesObj flag:4];
    } failure:nil];
}



#pragma mark 首页航班汇总、异常原因分类、延误时长、小时分布

-(void) cacheFlightData
{
    
    [HttpsUtils getFlightStatusInfo:nil success:^(id responesObj) {
        [flightModel updateFlightStatusInfo:responesObj];
    } failure:nil];
    
    // 航班异常原因分类 /flt/delayReasonSort
    [HttpsUtils getFlightAbnReason:nil success:^(id responesObj) {
        [flightModel updateFlightAbnReason:responesObj];
    } failure:nil];
    
    // 航班区域延误时间 /flt/delayAreaSort
    [HttpsUtils getRegionDlyTime:nil success:^(id responesObj) {
        [flightModel updateRegionDlyTime:responesObj];
    } failure:nil];

}



#pragma mark 首页旅客页面 旅客摘要 旅客预测 隔离区内旅客小时分布 隔离区内旅客区域分布 机上等待旅客信息

-(void) cachePassengerData
{
    [HttpsUtils getPassengerSummary:nil success:^(id responseObj) {
        [psnModel updatePassengerSummary:responseObj];
    } failure:nil];
    
    [HttpsUtils getPassengerForecast:nil success:^(id responseObj) {
        [psnModel updatePassengerForecast:responseObj];
    } failure:nil];
    
    [HttpsUtils getSafetyPassenger:nil success:^(id responseObj) {
        [psnModel updateSafetyPassenger:responseObj];
    } failure:nil];
    
    [HttpsUtils getPassengerOnboard:nil success:^(id responseObj) {
        [psnModel updatePassengerOnboard:responseObj];
    } failure:nil];
    
    [HttpsUtils getArrPsnHours:nil success:^(id responseObj) {
        [psnModel updatePsnHours:responseObj flag:1];
    } failure:nil];
    
    [HttpsUtils getDepPsnHours:nil success:^(id responseObj) {
        [psnModel updatePsnHours:responseObj flag:2];
    } failure:nil];
    
    [HttpsUtils getSafetyPsnHours:nil success:^(id responseObj) {
        [psnModel updatePsnHours:responseObj flag:3];
    } failure:nil];
    
    [HttpsUtils getGlqNearPsn:nil success:^(id responseObj) {
        [psnModel updateGlqNearPsn:responseObj];
    } failure:nil];
    
    [HttpsUtils getPeakPnsDays:nil success:^(id responseObj) {
        [psnModel updatePeakPnsDays:responseObj];
    } failure:nil];
}


#pragma mark 首页资源 机位使用信息

-(void) cacheSeatUsedData
{
    // 机位占用信息
    [HttpsUtils getCraftSeatTakeUpInfo:nil success:^(id responseObj) {
        [seatModel updateCraftSeatTakeUpInfo:responseObj];
    } failure:nil];

    // 机位占用预测
    [HttpsUtils getWillCraftSeatTakeUp:nil success:^(id responseObj) {
        [seatModel updateWillCraftSeatTakeUp:responseObj];
    } failure:nil];
    
    // 机位类型占用详情
    [HttpsUtils getCraftSeatTypeTakeUpSort:nil success:^(id responseObj) {
        [seatModel updateCraftSeatTypeTakeUp:responseObj];
    } failure:nil];
}

@end
