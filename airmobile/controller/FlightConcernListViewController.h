//
//  FlightConcernLIstViewController.h
//  airmobile
//
//  Created by xuesong on 17/1/21.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "RootViewController.h"

typedef NS_ENUM(NSUInteger, UMEFlightStatusSearchType) {

    UMEFlightStatusSearchTypeFlightNo,
    UMEFlightStatusSearchTypeFlightCity
    
};


@interface FlightConcernListViewController : RootViewController

@property (nonatomic, assign) UMEFlightStatusSearchType type;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *flightNo;
@property (nonatomic, copy) NSString *starCityCode;
@property (nonatomic, copy) NSString *endCityCode;

@end
