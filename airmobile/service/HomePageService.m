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
//    [self cacheSummaryData];
//    [self cacheFlightData];
//    [self cachePassengerData];
//    [self cacheSeatUsedData];
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

-(SummaryModel *)getSummaryModel
{
    summaryModel.flightDate = @"2016-11-23";
    summaryModel.userName = @"杨泉林";
    summaryModel.allCnt = 800;
    summaryModel.finishedCnt = 566;
    summaryModel.unfinishedCnt = 234;
    summaryModel.releaseRatio = @"71%";
    summaryModel.warning = @"";
    summaryModel.aovTxt = @"12:30   今日航班执行总体情况正常，因华东地区天气原因流量控制，前往该地区的航班放行正常率低于75%预计2小时候恢复正常";

    //航班小时分布
    NSMutableArray *eightMonthArray1 = [NSMutableArray array];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"1:00" count:25]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"2:00" count:35]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"3:00" count:15]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"4:00" count:10]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"5:00" count:25]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"6:00" count:35]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"7:00" count:45]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"8:00" count:65]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"9:00" count:70]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"10:00" count:48]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"11:00" count:62]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"12:00" count:45]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"13:00" count:55]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"14:00" count:60]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"15:00" count:75]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"16:00" count:60]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"17:00" count:45]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"18:00" count:35]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"19:00" count:45]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"20:00" count:25]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"21:00" count:20]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"22:00" count:25]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"23:00" count:30]];
    [eightMonthArray1 addObject:[[FlightHourModel alloc] initWithHour:@"00:00" count:15]];
    summaryModel.flightHours = [NSMutableArray arrayWithArray:[eightMonthArray1 copy] ];

    //大面积延误指标
    FlightLargeDelayModel *flightLargeDelay = [[FlightLargeDelayModel alloc]init];
    flightLargeDelay.executeRateThreshold = 0.5;
    flightLargeDelay.glqPassenCnt = 546;
    flightLargeDelay.glqPassenThreshold = 1000;
    flightLargeDelay.delayOneHourCnt = 3;
    flightLargeDelay.allOutCnt = 23;
    flightLargeDelay.delayOneHourRatio = 0.14;
    flightLargeDelay.delayOneHourRatioThreshold = 0.15;
    flightLargeDelay.noTakeoffAndLanding = 10;
    flightLargeDelay.noTakeoffAndLandingThreshold = 20;
    NSMutableArray *eightMonthArray= [NSMutableArray arrayWithArray:@[]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"1:00" count:25]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"2:00" count:35]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"3:00" count:15]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"4:00" count:10]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"5:00" count:25]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"6:00" count:35]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"7:00" count:45]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"8:00" count:65]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"9:00" count:70]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"10:00" count:48]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"11:00" count:62]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"12:00" count:45]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"13:00" count:55]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"14:00" count:60]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"15:00" count:75]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"16:00" count:60]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"17:00" count:45]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"18:00" count:35]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"19:00" count:45]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"20:00" count:25]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"21:00" count:20]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"22:00" count:25]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"23:00" count:30]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"00:00" count:15]];
    flightLargeDelay.hourExecuteRateList = eightMonthArray;
    summaryModel.delayTagart = flightLargeDelay;

    //近10天的放行正常率
    ReleasedRatioModel *tenDayReleased1 = [[ReleasedRatioModel alloc]init];
    tenDayReleased1.time = @"11-20";
    tenDayReleased1.ratio = 0.8;
    tenDayReleased1.realCount = 800;
    tenDayReleased1.planCount = 1000;
    summaryModel.tenDayReleased = [NSMutableArray arrayWithArray:@[tenDayReleased1]];

    //今年放行正常率
    ReleasedRatioModel *yearReleased1 = [[ReleasedRatioModel alloc]init];
    yearReleased1.time = @"11-23";
    yearReleased1.ratio = 0.9;
    yearReleased1.realCount = 700;
    yearReleased1.planCount = 800;
    summaryModel.yearReleased = [NSMutableArray arrayWithArray:@[yearReleased1]];


    return summaryModel;

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

-(FlightStusModel *)getFlightStusModel
{
    flightModel.flightCount = 1000;
    flightModel.arrCount = 448;
    flightModel.depCount = 552;
    flightModel.arrDoneNormal = 447;
    flightModel.arrDoneAbn = 1;
    flightModel.arrPlanNormal = 448;
    flightModel.arrPlanAbn = 0;
    flightModel.arrDelay = 1;
    flightModel.arrCancel = 0;

    flightModel.depDoneNormal = 550;
    flightModel.depDoneAbn = 2;
    flightModel.depPlanAbn = 0;
    flightModel.depPlanNormal = 552;
    flightModel.depDelay = 1;
    flightModel.depCancel = 1;

    NSMutableArray *hourArray = [NSMutableArray array];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"1:00" count:25 planCount:25]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"2:00" count:35 planCount:35]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"3:00" count:15 planCount:15]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"4:00" count:10 planCount:10]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"5:00" count:25 planCount:25]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"6:00" count:35 planCount:35]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"7:00" count:45 planCount:50]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"8:00" count:55 planCount:65]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"9:00" count:50 planCount:50]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"10:00" count:48 planCount:48]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"11:00" count:50 planCount:62]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"12:00" count:45 planCount:45]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"13:00" count:55 planCount:55]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"14:00" count:60 planCount:60]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"15:00" count:50 planCount:50]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"16:00" count:60 planCount:60]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"17:00" count:45 planCount:45]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"18:00" count:35 planCount:35]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"19:00" count:45 planCount:45]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"20:00" count:25 planCount:25]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"21:00" count:20 planCount:20]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"22:00" count:25 planCount:25]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"23:00" count:30 planCount:30]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"00:00" count:15 planCount:15]];
//    flightModel.flightHours = hourArray;

    NSMutableArray *array = [NSMutableArray new];
    [array addObject: [[AbnReasonModel alloc] initWithReason:@"天气原因" count:15 percent:0.15]];
    [array addObject: [[AbnReasonModel alloc] initWithReason:@"军事控制" count:25 percent:0.25]];
    [array addObject: [[AbnReasonModel alloc] initWithReason:@"航空公司" count:25 percent:0.25]];
    [array addObject: [[AbnReasonModel alloc] initWithReason:@"空管" count:20 percent:0.2]];
    [array addObject: [[AbnReasonModel alloc] initWithReason:@"机场" count:5 percent:0.05]];
    [array addObject: [[AbnReasonModel alloc] initWithReason:@"其他" count:10 percent:0.10]];
    flightModel.abnReasons = [array copy];

    NSMutableArray *hourArray1 = [NSMutableArray array];
    [hourArray1 addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"华东" count:25 time:45]];
    [hourArray1 addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"华北" count:15 time:60]];
    [hourArray1 addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"华中" count:35 time:70]];
    [hourArray1 addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"华南" count:25 time:35]];
    [hourArray1 addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"西南" count:15 time:55]];
    [hourArray1 addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"西北" count:60 time:10]];
    [hourArray1 addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"东北" count:70 time:12]];
    [hourArray1 addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"地区" count:21 time:45]];
    [hourArray1 addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"国际" count:25 time:16]];
    flightModel.regionDlyTimes = hourArray1;


    return flightModel;
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

-(PassengerModel *)getPassengerTopModel
{
    psnModel.hourInCount = 300;
    psnModel.hourOutCount = 500;
    psnModel.maxCount = 1000;
    psnModel.minCount = 00;

    psnModel.planInCount = 1000;
    psnModel.realInCount = 900;
    psnModel.planOutCount = 800;
    psnModel.realOutCount = 700;
    psnModel.safeCount = 578;

    NSMutableArray *hourArray = [NSMutableArray array];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"1:00" count:25 planCount:25]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"2:00" count:35 planCount:35]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"3:00" count:15 planCount:15]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"4:00" count:10 planCount:10]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"5:00" count:25 planCount:25]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"6:00" count:35 planCount:35]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"7:00" count:45 planCount:50]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"8:00" count:55 planCount:65]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"9:00" count:50 planCount:50]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"10:00" count:48 planCount:48]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"11:00" count:50 planCount:62]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"12:00" count:45 planCount:45]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"13:00" count:55 planCount:55]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"14:00" count:60 planCount:60]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"15:00" count:50 planCount:50]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"16:00" count:60 planCount:60]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"17:00" count:45 planCount:45]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"18:00" count:35 planCount:35]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"19:00" count:45 planCount:45]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"20:00" count:25 planCount:25]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"21:00" count:20 planCount:20]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"22:00" count:25 planCount:25]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"23:00" count:30 planCount:30]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"00:00" count:15 planCount:15]];
    psnModel.psnHours = hourArray;

    NSMutableArray *farArray = [NSMutableArray array];
    [farArray addObject:[[PassengerAreaModel alloc] initWithRegion:@"北指廊" count:2512 isFar:NO]];
    [farArray addObject:[[PassengerAreaModel alloc] initWithRegion:@"东北"  count:2055 isFar:NO]];
    [farArray addObject:[[PassengerAreaModel alloc] initWithRegion:@"西北"  count:2315 isFar:NO]];
    [farArray addObject:[[PassengerAreaModel alloc] initWithRegion:@"东南"  count:1985 isFar:NO]];
    [farArray addObject:[[PassengerAreaModel alloc] initWithRegion:@"西南"  count:1205 isFar:NO]];
    psnModel.psnAreas = farArray;

    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-5-25" count:5410 index:1]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-6-25" count:5230 index:2]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-7-25" count:5120 index:3]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-8-25" count:5048 index:4]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-9-25" count:5042 index:5]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-7-25" count:5120 index:6]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-8-25" count:5048 index:7]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-9-25" count:5042 index:8]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-7-25" count:5120 index:9]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-8-25" count:5048 index:10]];
    [array addObject:[[PassengerTopModel alloc] initWithDate:@"2016-9-25" count:5042 index:11]];
    psnModel.psnTops = array;


    NSMutableArray *array2 = [NSMutableArray array];

    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"1:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"2:00" count:0 planCount:0 arrCount:260 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"3:00" count:0 planCount:0 arrCount:241 planArrCount:250 depCount:210 planDepCount:210 before:YES]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"4:00" count:0 planCount:0 arrCount:264 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"5:00" count:0 planCount:0 arrCount:281 planArrCount:250 depCount:260 planDepCount:178 before:YES]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"6:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"7:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"8:00" count:0 planCount:0 arrCount:231 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"9:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:230 before:YES]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"10:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"11:00" count:0 planCount:0 arrCount:150 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"12:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"13:00" count:0 planCount:0 arrCount:170 planArrCount:250 depCount:220 planDepCount:220 before:YES]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"14:00" count:0 planCount:0 arrCount:270 planArrCount:250 depCount:280 planDepCount:240 before:NO]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"15:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:NO]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"16:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:350 before:NO]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"17:00" count:0 planCount:0 arrCount:260 planArrCount:250 depCount:350 planDepCount:350 before:NO]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"18:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:350 planDepCount:260 before:NO]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"19:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:213 before:NO]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"20:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:245 before:NO]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"21:00" count:0 planCount:0 arrCount:230 planArrCount:254 depCount:260 planDepCount:260 before:NO]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"22:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:NO]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"23:00" count:0 planCount:0 arrCount:280 planArrCount:250 depCount:260 planDepCount:206 before:NO]];
    [array2 addObject:[[FlightHourModel alloc] initWithHour:@"00:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:NO]];

    psnModel.psnInOutHours = array2;

    psnModel.psnOnPlane =[NSMutableArray arrayWithArray: @[@{@"count":@(10),@"ratio":@(0.5),@"hour":@"45min一下"},
                            @{@"count":@(10),@"ratio":@(0.5),@"hour":@"45min一下"},
                            @{@"count":@(10),@"ratio":@(0.5),@"hour":@"45min一下"}]];

    return  psnModel;
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
    craftSeatCntModel.unusable = 2;
    craftSeatCntModel.longTakeUp = 1;
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
