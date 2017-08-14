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

typedef enum : NSUInteger {
    FlightSearchTypeFlightNo,   //航班号
    FlightSearchTypeCity,       //城市名
    FlightSearchTypePlaneNo,    //机号
    FlightSearchTypeSeat        //机位
} FlightSearchType;
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
@property (nonatomic, assign) FlightSearchType queryflag;

@end
