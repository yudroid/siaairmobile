//
//  PassengerHourViewController.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootViewController.h"
@class FlightHourModel;

@interface PassengerHourViewController : RootViewController<UITableViewDelegate,UITableViewDataSource>

-(instancetype)initWithDataArray:(NSArray<FlightHourModel *> *)dataArray;

@end
