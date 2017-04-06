//
//  FlightViewController.h
//  KaiYa
//
//  Created by VIPUI_CC on 16/2/16.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "RootViewController.h"
#import "HasTabbarRootViewController.h"
@class AirlineModel;

@interface FlightSearchViewController : HasTabbarRootViewController

@property (nonatomic, strong) UIButton      *seekButton;
@property (nonatomic, strong) UILabel       *dateLabel;
@property (nonatomic, strong) UITextField   *flightNumberTextF;
@property (nonatomic, strong) UIButton      *outCityButton;
@property (nonatomic, strong) UIButton      *arriveCityButton;
@property (nonatomic, strong) UILabel       *outCityLabel;
@property (nonatomic, strong) UILabel       *arriveCityLabel;
@property (nonatomic, strong) UIButton      *flightImg;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) Airport       *arriveCity;
@property (nonatomic, strong) Airport       *outCity;
@property (nonatomic, strong) AirlineModel *airlineModel;
//查询条件
@property (nonatomic, copy) NSString *fltDate;
@property (nonatomic, assign) BOOL queryflag;// YES 按照航班号查询 NO按照航站查询

@end
