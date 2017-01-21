//
//  UMECheckinResponse.h
//  UMESDKDevelop
//
//  Created by 张博 on 15/10/9.
//  Copyright © 2015年 张博. All rights reserved.
//

#import "UMEBaseResponse.h"

@interface UMECheckinResponse : UMEBaseResponse
//航班日期
@property (nonatomic, copy) NSString *flightDate;
//航班号
@property (nonatomic, copy) NSString *flightNo;
//手机号
@property (nonatomic, copy) NSString *mobile;
//航空公司二字码
@property (nonatomic, copy) NSString *airlineCode;
//座位号
@property (nonatomic, copy) NSString *seatNo;
//电子客票号
@property (nonatomic, copy) NSString *tktNo;
//coupon号
@property (nonatomic, copy) NSString *coupon;
//起飞城市三字码
@property (nonatomic, copy) NSString *deptAirportCode;
//到达城市三字码
@property (nonatomic, copy) NSString *destAirportCode;

@end
