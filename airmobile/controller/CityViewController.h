//
//  CityViewController.h
//  KaiYa
//
//  Created by VIPUI_CC on 16/2/17.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "RootViewController.h"
#import "Airport.h"

@interface CityViewController : RootViewController

@property (nonatomic,retain)NSString *titleStr;
@property (nonatomic,copy) void (^ resetCity)(Airport *airport);

@end
