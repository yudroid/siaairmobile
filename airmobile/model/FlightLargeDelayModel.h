//
//  FlightLargeDelayModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//


/*
 * 航班大面积延误
 */
#import "RootModel.h"

@interface FlightLargeDelayModel : RootModel

//{"allOutCnt":199,"delayOneHourCnt":0,"delayOneHourRatio":0,"delayOneHourRatioThreshold":0.05,"executeRateThreshold":0,"glqPassenCnt":0,"glqPassenThreshold":5000,"hourExecuteRateList":[{"count":0,"hour":"08","ratio":0.867},{"count":0,"hour":"09","ratio":0.667},{"count":0,"hour":"10","ratio":0.563},{"count":0,"hour":"11","ratio":0.4},{"count":0,"hour":"12","ratio":0.357},{"count":0,"hour":"13","ratio":0.533},{"count":0,"hour":"14","ratio":0.571},{"count":0,"hour":"15","ratio":0.786},{"count":0,"hour":"16","ratio":0.615},{"count":0,"hour":"17","ratio":0.714},{"count":0,"hour":"18","ratio":0.692},{"count":0,"hour":"19","ratio":0.667},{"count":0,"hour":"20","ratio":0.5},{"count":0,"hour":"21","ratio":0.353},{"count":0,"hour":"22","ratio":0.778},{"count":0,"hour":"23","ratio":0.8}],"noTakeoffAndLanding":15024,"noTakeoffAndLandingThreshold":30}
//执行率
@property (nonatomic, copy) NSMutableArray *hourExecuteRateList;//小时执行正常数
@property (nonatomic, assign) float executeRateThreshold;//执行率阈值 默认是0.5
//隔离区
@property (nonatomic, assign) int glqPassenCnt;//隔离区（航站楼）旅客人数
@property (nonatomic, assign) float glqPassenThreshold;//隔离区（航站楼）旅客人数阈值
//延误1小时
@property (nonatomic, assign) int delayOneHourCnt;//延误1小时以上未放行航班
@property (nonatomic, assign) int allOutCnt;//总计划出港航班数
@property (nonatomic, assign) float delayOneHourRatio;//延误1小时未放行航班数/总计划出港航班
@property (nonatomic, assign) float delayOneHourRatioThreshold;//延误1小时未放行航班数/总计划出港航班的阈值
//无起降航班
@property (nonatomic, assign) int noTakeoffAndLanding;//无起降航班时间
@property (nonatomic, assign) float noTakeoffAndLandingThreshold;//无起降航班时间阈值


@end
