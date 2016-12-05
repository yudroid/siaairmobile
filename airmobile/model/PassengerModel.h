//
//  PassengerModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/13.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"
#import "FlightHourModel.h"
#import "PassengerAreaModel.h"
#import "PassengerTopModel.h"

@interface PassengerModel : RootModel

@property (nonatomic,assign)    int hourInCount;// 30分钟内进港
@property (nonatomic,assign)    int hourOutCount;// 1小时内出港

@property (nonatomic,assign)    int maxCount;// 旅客最大值
@property (nonatomic,assign)    int minCount;// 旅客最小值

@property (nonatomic,assign)    int planInCount;// 计划进港人数
@property (nonatomic,assign)    int realInCount;// 实际进港人数
@property (nonatomic,assign)    int planOutCount;// 计划出港人数
@property (nonatomic,assign)    int realOutCount;// 实际出港人数

@property (nonatomic,assign)    int safeCount;// 隔离区旅客人数

@property (nonatomic,strong)    NSMutableArray<NSDictionary *>         *psnOnPlane;// 旅客机上等待时间
@property (nonatomic,strong)    NSMutableArray<FlightHourModel *>      *psnHours;// 旅客小时分布：进港旅客、出港旅客、隔离区内
@property (nonatomic,strong)    NSMutableArray<PassengerAreaModel *>   *psnNearAreas; //旅客区域分布 近机位
@property (nonatomic,strong)    NSMutableArray<PassengerAreaModel *>   *psnFarAreas; //旅客区域分布 近机位
@property (nonatomic,strong)    NSMutableArray<PassengerTopModel *>    *psnTops;// 旅客排名
@property (nonatomic, strong)   NSArray                                *psnInOutHours;//旅客小时分布

-(void) updatePassengerSummary:     (id)data;
-(void) updatePassengerForecast:    (id)data;
-(void) updateSafetyPassenger:      (id)data;

-(void) updatePassengerOnboard:     (id)data;
-(void) updatePsnHours:             (id)data
                  flag:             (int)flag;
-(void) updatePeakPnsDays:          (id)data;

-(void) updateGlqNearPsn:           (id)data;
- (void)updateGlqFarPsn:            (id)data;

@end
