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

@property(nonatomic,copy) NSString *hour;

@property(nonatomic,assign) int count;// 实际总数
@property(nonatomic,assign) int planCount; // 计划总数

@property(nonatomic,assign) int arrCount;// 实际总数
@property(nonatomic,assign) int planArrCount; // 计划总数

@property(nonatomic,assign) int depCount;// 实际总数
@property(nonatomic,assign) int planDepCount; // 计划总数

@property(nonatomic,assign) BOOL before; // 当前时间之前

-(instancetype) initWithHour:(NSString *)hour count:(int)count;

-(instancetype) initWithHour:(NSString *)hour count:(int)count planCount:(int)planCount;

-(instancetype) initWithHour:(NSString *)hour count:(int)count planCount:(int)planCount arrCount:(int)arrCount planArrCount:(int)planArrCount depCount:(int)depCount planDepCount:(int)planDepCount before:(BOOL)before;

@end
