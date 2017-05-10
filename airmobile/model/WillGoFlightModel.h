//
//  WillGoFlightModel.h
//  airmobile
//
//  Created by xuesong on 2017/4/18.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface WillGoFlightModel : RootModel


@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *schedule;
@property (nonatomic, strong) NSString *craftSeat;
@property (nonatomic, strong) NSString *flyno;
@property (nonatomic, strong) NSString *flightNumber;
@property (nonatomic, strong) NSString *delayTime;
@property (nonatomic, strong) NSString *flyTime;
@property (nonatomic, strong) NSString *flagAD;
@end
