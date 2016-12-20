//
//  WeatherAirportController.h
//  KaiYa
//
//  Created by chunminglu on 16/4/6.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface WeatherAirportController : RootViewController

/**
 *  功能id
 information:机场信息
 weather:机场天气
 route:周边航线
 */
@property (strong,nonatomic) NSString* functionId;

/**
 *  机场三字码
 */
@property (strong,nonatomic) NSString* airportCode;

@end
