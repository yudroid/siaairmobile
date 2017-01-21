//
//  UMEFlightStatusSubscribeKeyResponse.h
//  UMESDKDemo
//
//  Created by zhangbo on 14-4-25.
//  Copyright (c) 2014年 zhangbo. All rights reserved.
//

#import "UMEBaseResponse.h"

@interface UMEFlightStatusSubscribeKeyResponse : UMEBaseResponse

@property (nonatomic, copy) NSString *startCityCode;
@property (nonatomic, copy) NSString *endCityCode;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *flightNo;
@property (nonatomic, copy) NSString *airlineName;


@end
