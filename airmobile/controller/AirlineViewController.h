//
//  AirlineViewController.h
//  airmobile
//
//  Created by xuesong on 17/3/27.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@class AirlineModel;

@interface AirlineViewController : RootViewController

@property (nonatomic,retain)NSString *titleStr;
@property (nonatomic,copy) void (^ resetCity)(AirlineModel *airport);

@end
