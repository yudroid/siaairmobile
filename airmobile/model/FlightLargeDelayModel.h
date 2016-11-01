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


//执行率
@property (nonatomic, copy) NSArray *hourExecuteRateList;//小时执行正常数
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
