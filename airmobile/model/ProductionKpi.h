//
//  ProductionKpi.h
//  KaiYa
//
//  Created by 杨泉林研发部 on 16/3/5.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YearKpi.h"
#import "MonthKpi.h"

@interface ProductionKpi : NSObject

@property(nonatomic,retain) YearKpi *flightY; // 航班年度指标
@property(nonatomic,retain) MonthKpi *flightM; // 航班月度指标
@property(nonatomic,retain) YearKpi *passengerY; // 旅客年度指标
@property(nonatomic,retain) MonthKpi *passengerM; // 旅客月度指标
@property(nonatomic,retain) YearKpi *cargoY; // 货邮年度指标
@property(nonatomic,retain) MonthKpi *cargoM; // 货邮月度指标

- (void)updateFlightY:(id)responseObj;
- (void)updateFlightM:(id)responseObj;
- (void)updatePassengerY:(id)responseObj;
- (void)updatePassengerM:(id)responseObj;
- (void)updateCargoY:(id)responseObj;
- (void)updateCargoM:(id)responseObj;

@end
