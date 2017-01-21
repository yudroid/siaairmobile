//
//  HomePageViewController.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootViewController.h"
#import "OverViewContentView.h"
#import "FlightContentView.h"
#import "PassengerContentView.h"
#import "ResourceContentView.h"
#import "HasTabbarRootViewController.h"
@class ResourceOverview;

typedef enum
{
    HomePageTypeOverview,//全部
    HomePageTypeFlight,//航班
    HomePageTypePassenger,//旅客
    HomePageTypeResource,//资源
    
}HomePageType;

@interface HomePageViewController : HasTabbarRootViewController<TabBarViewDelegate,OverviewContentViewDelegate,FlightContentViewDelegate,PassengerContentViewDelegate,ResourceContentViewDelegate>
{
    UIImageView *selectedLine;
    
    UILabel *overviewLabel;// 总览
    UILabel *flightLabel;// 航班
    UILabel *passengerLabel;// 旅客
    UILabel *resourceLabel;// 资源
    
    UIImageView *overviewIcon; // 总览
    UIImageView *flightIcon; // 航班
    UIImageView *passengerIcon; // 旅客
    UIImageView *resourcesIcon; // 资源
    UIImageView *iconBg;
    
    UIDatePicker *datePicker;
    
    OverViewContentView  *overviewContentView; // 总览
    FlightContentView    *flightContentView; // 航班
    PassengerContentView *passengerContentView; // 旅客
    ResourceOverview  *resourceContentView; // 资源
    
    HomePageType homePageType;
}

@end
