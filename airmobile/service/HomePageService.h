//
//  HomePageService.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/2.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"
#import "SummaryModel.h"
#import "FlightStusModel.h"
#import "PassengerModel.h"
#import "SeatStatusModel.h"

@interface HomePageService : BaseService

singleton_interface(HomePageService);


@property (nonatomic, strong) SummaryModel    *summaryModel;  // 首页概览数据
@property (nonatomic, strong) FlightStusModel *flightModel;   // 航班数据
@property (nonatomic, strong) PassengerModel  *psnModel;      // 旅客数据
@property (nonatomic, strong) SeatStatusModel *seatModel;     // 机位数据
-(void)startService;


@end
