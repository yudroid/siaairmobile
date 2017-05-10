
//
//  SummaryModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"
#import "FlightHourModel.h"
#import "FlightLargeDelayModel.h"
#import "ReleasedRatioModel.h"

@interface SummaryModel : RootModel

@property (nonatomic, assign) NSInteger planTotal;//计划总数
@property (nonatomic, assign) NSInteger planIn;//计划进港总数
@property (nonatomic, assign) NSInteger planOut;//计划出港总数
//进港
@property (nonatomic, assign) NSInteger inFinished;//进港已执行数
@property (nonatomic, assign) NSInteger inNoFinished;//进港未执行数
@property (nonatomic, assign) NSInteger inCancel;//进港取消数
@property (nonatomic, assign) NSInteger inFinishedDelay;//进港已执行延误数
@property (nonatomic, assign) NSInteger inNoFinishedDelay;//进港未执行延误数
@property (nonatomic, assign) NSInteger inDelay;//进港延误数
//出港
@property (nonatomic, assign) NSInteger outFinished;//出港已执行数
@property (nonatomic, assign) NSInteger outNoFinished;//出港未执行数
@property (nonatomic, assign) NSInteger outCancel;//出港取消数
@property (nonatomic, assign) NSInteger outFinishedDelay;//出港已执行延误数
@property (nonatomic, assign) NSInteger outNoFinishedDelay;//出港未执行延误数
@property (nonatomic, assign) NSInteger outDelay;//出港延误数

@property (nonatomic, strong) NSString* flightDate;//当天日期 年月日 格式为2016-09-08
@property (nonatomic, strong) NSString* leaderUserName;//值班领导名称
@property (nonatomic, strong) NSString* userName;//运行总监名称
@property (nonatomic, assign) NSInteger allCnt; //当天所有航班数
@property (nonatomic, assign) NSInteger finishedCnt;//已执行航班数
@property (nonatomic, assign) NSInteger unfinishedCnt;//未执行航班数
@property (nonatomic, strong) NSString* releaseRatio;//放行正常率
@property (nonatomic, strong) NSString* warning;//航班正常性判定，分正常、蓝色IV级（小面积）、黄色Ⅲ级(一般)、橙色Ⅱ级(重大)、红色 Ⅰ级(严重)
@property (nonatomic, strong) NSString* aovTxt;//aov输入的自由文本
@property (nonatomic, assign) CGFloat releaseSpeed;//出港放行速率
@property (nonatomic, assign) CGFloat  inSpeed;//进港放行速率
@property (nonatomic, assign) CGFloat yesterdayReleaseRatio;//昨日放行正常率
@property (nonatomic, assign) CGFloat nowMonthAvgRatio;//本月放行正常率

//@property (nonatomic, copy) NSString *flightDate;//当天日期 年月日 格式为2016-09-08
//@property (nonatomic, copy) NSString *userName;//运行总监名称
//@property (nonatomic, copy) NSString *leaderUserName;//值班领导
//@property (nonatomic, assign) int allCnt; //当天所有航班数
//@property (nonatomic, assign) int finishedCnt;//已执行航班数
//@property (nonatomic, assign) int unfinishedCnt;//未执行航班数
//@property (nonatomic, copy) NSString *releaseRatio;//放行正常率
//@property (nonatomic, assign) CGFloat yesterdayReleaseRatio;//昨日放行正常率
@property (nonatomic, assign) CGFloat releaseRatioThreshold;//放行正常率阈值
@property (nonatomic, assign) CGFloat releaseRatioThreshold2;//放行正常率阈值
@property (nonatomic, copy) NSString *dayNum;//放行正常率天数 ---最近10天
@property (nonatomic, copy) NSString *month;//放行正常率 --最近几个月
//@property (nonatomic, copy) NSString *warning;//航班正常性判定，分正常、黄色Ⅲ级(一般)、橙色Ⅱ级(重大)、红色 Ⅰ级(严重)
//@property (nonatomic, copy) NSString *aovTxt;//aov输入的自由文本









@property (nonatomic, strong) NSMutableArray<FlightHourModel *> *flightHours;// 航班小时分布

@property (nonatomic, strong) FlightLargeDelayModel *delayTagart;// 判断是否大面积航延指标
@property (nonatomic, strong) NSMutableArray<ReleasedRatioModel *> *tenDayReleased;// 近10的放行正常率
@property (nonatomic, strong) NSMutableArray<ReleasedRatioModel *> *yearReleased;// 今年放行正常率
@property (nonatomic, strong) NSArray<ReleasedRatioModel *>        *lastYearReleased;//去年放行正常率
@property (nonatomic, strong) NSArray<ReleasedRatioModel *>        *weekReleased;//去年放行正常率

/**
 <#Description#>

 @param data <#data description#>
 @param flag 1:计划进港 2:实际进港 3:计划出港  4:实际出港
 */
-(void)updateFlightHourModel:(NSDictionary *)data flag:(int)flag;

-(void)updateTenDayReleased:(NSDictionary *)data;

-(void)updateYearReleased:(NSDictionary *)data;

-(void)updatePropertyData:(NSDictionary *)data;

-(void)updateFlightDelayTarget:(NSDictionary *)data;

-(void)updateLastYearReleased:(NSArray *)data;

-(void)updateweekReleased:(NSArray *)data;

-(void)updateReleaseRatioThreshold:(id)data;

-(void)updatereleaseRatioThreshold2:(NSDictionary *)data;

@end
