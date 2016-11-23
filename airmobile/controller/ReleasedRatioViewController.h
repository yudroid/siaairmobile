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


@interface ReleasedRatioViewController : RootViewController
{
    UIView *tenDayImageView;
    UIView *eightMonthImageView;
    TenDayRatioView *tenDayRatioView;
    EightMonthRatioView *eightMonthRatioView;
    
}

-(instancetype)initWithTenDayDataArray:(NSArray<ReleasedRatioModel *> *)tenDayDataArray
                         yearDataArray:(NSArray<ReleasedRatioModel *> *)yearDataArray;

@end
