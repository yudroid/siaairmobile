//
//  YearOperationStatusViewController.h
//  airmobile
//
//  Created by xuesong on 2017/7/19.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "RootViewController.h"

@interface YearOperationStatusViewController : RootViewController
@property (weak, nonatomic) IBOutlet UIView *airlineRankView;
@property (weak, nonatomic) IBOutlet UIView *airportRankView;
@property (weak, nonatomic) IBOutlet UIView *outFlightChartView;
@property (weak, nonatomic) IBOutlet UIView *delayTimeChartView;
@property (weak, nonatomic) IBOutlet UITableView *yearAbnormalFlightTableView;
@property (weak, nonatomic) IBOutlet UITableView *morningFlightTableView;
@property (weak, nonatomic) IBOutlet UITableView *yearAbnormalAirportTableView;
@property (weak, nonatomic) IBOutlet UITableView *morningAirportTableView;
@property (weak, nonatomic) IBOutlet UILabel *yearReleaseRatioLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearMornReleaseRatioLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *delayTimeViewHeight;
@end
