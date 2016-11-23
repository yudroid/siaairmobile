//
//  ArrDepFlightHourViewController.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootViewController.h"
#import "FlightHourView.h"
@class FlightHourModel;

@interface ArrDepFlightHourViewController : RootViewController<UIScrollViewDelegate>

@property (nonatomic,assign)FlightHourType hourType;

-(instancetype)initWithDataArray:(NSArray<FlightHourModel *>*)dataArray;

@end
