//
//  ReleasedRatioViewController.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootViewController.h"
#import "TenDayRatioView.h"
#import "EightMonthRatioView.h"
@class ReleasedRatioModel;
@class WeekRatioView;

@interface ReleasedRatioViewController : RootViewController
{
    UIView *tenDayImageView;
    UIView *eightMonthImageView;
    TenDayRatioView *tenDayRatioView;
    EightMonthRatioView *eightMonthRatioView;
    WeekRatioView *weekRatioView;
}

@end
