//
//  UMEFlightStatusSubscribeResponse.h
//  UMESDKDemo
//
//  Created by zhangbo on 14-3-26.
//  Copyright (c) 2014年 Livindesign. All rights reserved.
//

#import "UMEBaseResponse.h"

@interface UMEFlightStatusSubscribeResponse : UMEBaseResponse

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *flightNo;
@property (nonatomic, copy) NSString *startCityCode;
@property (nonatomic, copy) NSString *endCityCode;
@property (nonatomic, copy) NSString *subId;
@property (nonatomic, copy) NSString *subKey;


@end
