//
//  FlightHourInfoModel.h
//  airmobile
//
//  Created by xuesong on 16/12/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface FlightHourInfoModel : RootModel

@property (nonatomic, strong) NSString *hour;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) float ratio;

@end
