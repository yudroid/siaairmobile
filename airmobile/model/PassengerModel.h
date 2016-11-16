//
//  PassengerModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/13.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"
#import "FlightHourModel.h"
#import "PassengerTopModel.h"

@interface PassengerModel : RootModel

@property (nonatomic,assign) int hourInCount;
@property (nonatomic,assign) int hourOutCount;

@property (nonatomic,assign) int maxCount;
@property (nonatomic,assign) int minCount;

@property (nonatomic,assign) int planInCount;
@property (nonatomic,assign) int realInCount;// 实际进港人数
@property (nonatomic,assign) int planOutCount;// 计划出港人数
@property (nonatomic,assign) int realOutCount;// 实际出港人数

@property (nonatomic,assign) int safeCount;// 隔离区旅客人数

@property (nonatomic,copy) NSMutableArray<NSDictionary *> *psnOnPlane;// 旅客机上等待时间

@property (nonatomic,copy) NSMutableArray<FlightHourModel *> *psnHours;// 旅客小时分布：进港旅客、出港旅客、隔离区内
@property (nonatomic,copy) NSMutableArray<PassengerTopModel *> *psnTops;// 旅客排名


@end
