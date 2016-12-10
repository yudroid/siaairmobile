//
//  FlightHourModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootModel.h"

@interface FlightHourModel : RootModel

#pragma mark - property

@property(nonatomic,copy) NSString   *hour;

@property(nonatomic,assign) long     count;// 实际总数
@property(nonatomic,assign) long     planCount; // 计划总数

@property(nonatomic,assign) long     arrCount;// 实际总数
@property(nonatomic,assign) long     planArrCount; // 计划总数

@property(nonatomic,assign) long     depCount;// 实际总数
@property(nonatomic,assign) long     planDepCount; // 计划总数

@property(nonatomic,assign) BOOL     before; // 当前时间之前

@property(nonatomic,assign) float   radio;

#pragma mark - method

-(instancetype) initWithHour:(NSString *)   hour
                       count:(int)          count;

-(instancetype) initWithHour:(NSString *)   hour
                       count:(int)          count
                   planCount:(int)          planCount;

-(instancetype) initWithHour:(NSString *)   hour
                       count:(int)          count
                   planCount:(int)          planCount
                    arrCount:(int)          arrCount
                planArrCount:(int)          planArrCount
                    depCount:(int)          depCount
                planDepCount:(int)          planDepCount
                      before:(BOOL)         before;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(long) getCount;

-(long) getPlanCount;

@end
