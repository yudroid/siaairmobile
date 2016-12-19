//
//  FlightDetailViewController.h
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "FlightModel.h"

@interface FlightDetailViewController : RootViewController

@property (nonatomic, assign) int flightId;
@property (nonatomic, assign) BOOL isSpecial;//是否特殊航班
@end
