//
//  DelayModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface DelayModel : RootModel


@property (nonatomic, copy) NSArray *hourExecuteRateList;
@property (nonatomic, assign) float executeRateThreshold;
@property (nonatomic, assign) int glqPassenCnt;//隔离区旅客数
@property (nonatomic, assign) float glqPassenThreshold;
@property (nonatomic, assign) int delayOneHourCnt;//延误1小时以上未放行航班（预留）
@property (nonatomic, assign) int allOutCnt;//总计划出港航班数（预留）
@property (nonatomic, assign) float delayOneHourRatio;//延误1小时未放行航班数/总计划出港航班
@property (nonatomic, assign) float delayOneHourRatioThreshold;//延误1小时未放行航班数/总计划出港航班的阈值
@property (nonatomic, assign) int noTakeoffAndLanding;//无起降航班时间
@property (nonatomic, assign) float noTakeoffAndLandingThreshold;//阈值

@end
