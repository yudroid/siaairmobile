//
//  FlightService.h
//  airmobile
//
//  Created by xuesong on 16/11/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "BaseService.h"
@class FlightModel;
@class FlightDetailModel;
@class SafeguardModel;
@class AbnormalModel;

@interface FlightService : BaseService

singleton_interface(FlightService);

-(void)startService;

-(NSArray<FlightModel *> *)getFlightArray;

-(FlightDetailModel *)getFlightDetailModel;

-(NSArray<SafeguardModel *>* )getSafeguardArray;

-(AbnormalModel *)getAbnormalModel;

@end
