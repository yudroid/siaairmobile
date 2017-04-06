//
//  AirportFuctionWebViewController.h
//  UMESDKDevelop
//
//  Created by 张博 on 16/3/30.
//  Copyright © 2016年 张博. All rights reserved.
//

#import "UMEWebViewController.h"


@interface AirportFuctionWebViewController : UMEWebViewController
/*
    information:机场信息
    weather:机场天气
    route:机场雷霆
*/
@property (nonatomic, strong) NSString *functionID;
@property (nonatomic, strong) NSString *airportCode;


@end
