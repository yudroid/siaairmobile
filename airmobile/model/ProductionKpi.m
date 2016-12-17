//
//  ProductionKpi.m
//  KaiYa
//
//  Created by 杨泉林研发部 on 16/3/5.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "ProductionKpi.h"

@implementation ProductionKpi

- (void)updateCargoM:(id)responseObj
{
    [self setMonthKpi:_cargoM obj:responseObj];
}

- (void)updateCargoY:(id)responseObj
{
    [self setYearKpi:_cargoY obj:responseObj];
}

- (void)updatePassengerM:(id)responseObj
{
    [self setMonthKpi:_passengerM obj:responseObj];
}

- (void)updatePassengerY:(id)responseObj
{
    [self setYearKpi:_passengerY obj:responseObj];
}

- (void)updateFlightM:(id)responseObj
{
    [self setMonthKpi:_flightM obj:responseObj];
}

- (void)updateFlightY:(id)responseObj
{
    [self setYearKpi:_flightY obj:responseObj];
}

- (void)setMonthKpi:(MonthKpi *)month obj:(id)responseObj
{
    month.finished = [responseObj[@"finished"] floatValue];
    month.monthPlan = [responseObj[@"monthPlan"] floatValue];
    month.ratio = [responseObj[@"ratio"] floatValue];
}

- (void)setYearKpi:(YearKpi *)year obj:(id)responseObj
{
    year.finished = [responseObj[@"finished"] floatValue];
    year.finishedRatio = [responseObj[@"finishedRatio"] floatValue];
    year.planFinished = [responseObj[@"planFinished"] floatValue];
    year.planRatio = [responseObj[@"planRatio"] floatValue];
    year.yearPlan = [responseObj[@"yearPlan"] floatValue];
}

@end
