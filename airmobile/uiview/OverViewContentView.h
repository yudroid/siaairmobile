//
//  OverViewContentView.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OverviewContentViewDelegate <NSObject>

@optional
/**
 展示放行正常率视图
 */
-(void) showReleasedRatioView;
/**
 展示航班小时分布视图
 */
-(void) showFlightHourView;
/**
 展示航延4个指标视图
 */
-(void) showWorningIndicatorView;

@end

@interface OverViewContentView : UIView

@end
