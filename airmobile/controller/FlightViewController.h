//
//  FlightViewController.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "HasTabbarRootViewController.h"
@class FlightModel;
@class AirlineModel;
@interface FlightViewController : RootViewController


@property (nonatomic, strong) Airport       *arriveCity;
@property (nonatomic, strong) Airport       *outCity;

@property (nonatomic, copy) NSString        *flightNo;
@property (nonatomic, copy) NSString        *flightDate;
@property (nonatomic, strong)AirlineModel    *airlineModel;
@property (nonatomic, copy) NSString        *planeNo;//机号
@property (nonatomic, copy) NSString        *seat;//机位
@property (nonatomic, copy) NSArray<FlightModel *>  *dataArray;

@end
