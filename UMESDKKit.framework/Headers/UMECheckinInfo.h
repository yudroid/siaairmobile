//
//  UMECheckinInfo.h
//  UMESDKDevelop
//
//  Created by 张博 on 15/10/8.
//  Copyright © 2015年 张博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMECheckinInfo : NSObject

@property (nonatomic, strong) NSString *tktNo;
@property (nonatomic, strong) NSString *flightNo;
@property (nonatomic, strong) NSString *flightDate;
@property (nonatomic, strong) NSString *deptCode;
@property (nonatomic, strong) NSString *destCode;
@property (nonatomic, strong) NSString *tktStatus;
@property (nonatomic, strong) NSString *passengerName;
@property (nonatomic, strong) NSString *coupon;
@property (nonatomic, strong) NSString *airline;

@end
