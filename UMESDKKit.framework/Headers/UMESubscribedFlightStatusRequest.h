//
//  SubscribedFlightStatusRequest.h
//  UMESDKDemo
//
//  Created by zhangbo on 14-5-5.
//  Copyright (c) 2014年 zhangbo. All rights reserved.
//

#import "UMEBaseReq.h"

@interface UMESubscribedFlightStatusRequest : UMEBaseReq
@property (nonatomic, copy) NSString *depCityCode;
@property (nonatomic, copy) NSString *arrCityCode;
@property (nonatomic, copy) NSString *flightDate;
@property (nonatomic, copy) NSString *flightNo;
@property (nonatomic, copy) NSString *airlineCode;
@property (nonatomic, copy) NSString *subKey;

@end
