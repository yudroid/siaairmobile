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
    PassengerTopModel *psnModel;// 旅客数据
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
        psnModel = [PassengerTopModel new];
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
    
    /**
     今年航班放行正常率 /ov/fltFMR
     
     @param date <#date description#>
     @param success <#success description#>
     @param failure <#failure description#>
     */
//    +(void)getFlightYearRatio:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
    
    
    /**
     航班延误指标 /fltLD
     
     @param date <#date description#>
     @param success <#success description#>
     @param failure <#failure description#>
     */
//    +(void)getFlightDelayTarget:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
    
    
    /**
     计划进港航班小时分布 /flt/planArrFltPerHour
     
     @param date <#date description#>
     @param success <#success description#>
     @param failure <#failure description#>
     */
//    +(void)getPlanArrHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
    
    
    /**
     实际进港航班小时分布 /flt/realArrFltPerHour
     
     @param date <#date description#>
     @param success <#success description#>
     @param failure <#failure description#>
     */
//    +(void)getRealArrHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
    
    
    /**
     计划出港航班小时分布 /flt/depFltPerHour
     
     @param date <#date description#>
     @param success <#success description#>
     @param failure <#failure description#>
     */
//    +(void)getPlanDepHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
    
    
    /**
     实际出港航班小时分布 /flt/realDepFltPerHour
     
     @param date <#date description#>
     @param success <#success description#>
     @param failure <#failure description#>
     */
//    +(void)getRealDepHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
}



#pragma mark 首页航班汇总、异常原因分类、延误时长、小时分布

-(void) cacheFlightData
{
    
//    /**
//     获取航班信息汇总 /ov/fltCnt
//     
//     @param date <#date description#>
//     @param success <#success description#>
//     @param failure <#failure description#>
//     */
//    +(void)getFlightStatusInfo:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
//    
//    
//    /**
//     航班异常原因分类 /flt/delayReasonSort
//     
//     @param date <#date description#>
//     @param success <#success description#>
//     @param failure <#failure description#>
//     */
//    +(void)getFlightAbnReason:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
//    
//    
//    /**
//     航班区域延误时间 /flt/delayAreaSort
//     
//     @param date <#date description#>
//     @param success <#success description#>
//     @param failure <#failure description#>
//     */
//    +(void)getRegionDlyTime:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
}



#pragma mark 首页旅客页面 旅客摘要 旅客预测 隔离区内旅客小时分布 隔离区内旅客区域分布 机上等待旅客信息

-(void) cachePassengerData
{
    /**
     获取旅客的摘要信息 /psn/inOutPsn
     
     @param date <#date description#>
     @param success <#success description#>
     @param failure <#failure description#>
     */
//    +(void)getPassengerSummary:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
//    
//    
//    /**
//     获取旅客预测信息 /psn/willInOutPsn
//     
//     @param date <#date description#>
//     @param success <#success description#>
//     @param failure <#failure description#>
//     */
//    +(void)getPassengerForecast:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
//    
//    
//    /**
//     获取隔离区内旅客信息 /psn/glqRelatedPsn
//     
//     @param date <#date description#>
//     @param success <#success description#>
//     @param failure <#failure description#>
//     */
//    +(void)getSafetyPassenger:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
//    
//    
//    /**
//     机上旅客等待信息 /psn/planeWaitSort
//     
//     @param date <#date description#>
//     @param success <#success description#>
//     @param failure <#failure description#>
//     */
//    +(void)getPassengerOnboard:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
//    
//    
//    /**
//     进港旅客小时分布 /psn/arrPsnPerHour
//     
//     @param date <#date description#>
//     @param success <#success description#>
//     @param failure <#failure description#>
//     */
//    +(void)getArrPsnHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
//    
//    
//    /**
//     出港旅客小时分布 /psn/depPsnPerHour
//     
//     @param date <#date description#>
//     @param success <#success description#>
//     @param failure <#failure description#>
//     */
//    +(void)getDepPsnHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
//    
//    
//    /**
//     隔离区内旅客小时分布 /psn/glqPsnPerHour
//     
//     @param date <#date description#>
//     @param success <#success description#>
//     @param failure <#failure description#>
//     */
//    +(void)getSafetyPsnHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
}


#pragma mark 首页资源 机位使用信息

-(void) cacheSeatUsedData
{
    
    /**
     当前占用 当前占用、剩余机位、占用比 /rs/craftSeatTakeUpInfo
     
     @param date <#date description#>
     @param success <#success description#>
     @param failure <#failure description#>
     */
//    +(void)getCraftSeatTakeUpInfo:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
//    
//    
//    /**
//     机位占用预测 <1小时到港：10 <1小时出港：15 下小时机位占用：-5  /rs/willCraftSeatTakeUp
//     
//     @param date <#date description#>
//     @param success <#success description#>
//     @param failure <#failure description#>
//     */
//    +(void)getWillCraftSeatTakeUp:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
//    
//    
//    /**
//     机位类型占用详情 /rs/craftSeatTypeTakeUpSort
//     
//     @param date <#date description#>
//     @param success <#success description#>
//     @param failure <#failure description#>
//     */
//    +(void)getCraftSeatTypeTakeUpSort:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
}

@end
