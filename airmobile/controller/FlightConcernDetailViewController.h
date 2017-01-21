//
//  FlightConcernDetailViewController.h
//  airmobile
//
//  Created by xuesong on 17/1/13.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "RootViewController.h"


@interface FlightConcernDetailViewController : RootViewController

@property (nonatomic, copy) NSString *startCityCode;
@property (nonatomic, copy) NSString *endCityCode;
//航班日期（yyyy-MM-dd）
@property (nonatomic, copy) NSString *date;
//航班号（需全部大写）
@property (nonatomic, copy) NSString *flightNo;

@end
