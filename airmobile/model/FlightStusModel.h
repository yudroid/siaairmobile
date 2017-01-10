//
//  FlightStusModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"
#import "FlightHourModel.h"
#import "AbnReasonModel.h"
#import "RegionDlyTimeModel.h"

@interface FlightStusModel : RootModel

@property (nonatomic, assign) int flightCount;
@property (nonatomic, assign) int arrCount;
@property (nonatomic, assign) int depCount;

@property (nonatomic, assign) int arrDoneNormal;
@property (nonatomic, assign) int arrDoneAbn;
@property (nonatomic, assign) int arrPlanNormal;
@property (nonatomic, assign) int arrPlanAbn;
@property (nonatomic, assign) int arrDelay;
@property (nonatomic, assign) int arrCancel;

@property (nonatomic, assign) int depDoneNormal;
@property (nonatomic, assign) int depDoneAbn;
@property (nonatomic, assign) int depPlanNormal;
@property (nonatomic, assign) int depPlanAbn;
@property (nonatomic, assign) int depDelay;
@property (nonatomic, assign) int depCancel;

@property (nonatomic, assign) float depFltTarget;///出港航班阈值

@property (nonatomic, strong) NSMutableArray<AbnReasonModel *> *abnReasons;// 航班异常原因分类 不区分进出港
@property (nonatomic, strong) NSMutableArray<RegionDlyTimeModel *> *regionDlyTimes;// 区域延误时间分类 不区分进出港

-(void) updateFlightStatusInfo:(id)data;

-(void) updateFlightAbnReason:(id)data;

-(void) updateRegionDlyTime:(id)data;

-(void) updateDepFltTarget:(id)data;

@end
