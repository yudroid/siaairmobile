//
//  OverContentView.h
//  airmobile
//
//  Created by xuesong on 2017/4/21.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDProgressView;

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

//即将放行航班
-(void) showQueueView;

//年度运行情况
-(void)showOperationStatusView;
@end

@interface OverContentView : UIView
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *chartView;
//@property (weak, nonatomic) IBOutlet LDProgressView *tadayRatioView;
//@property (weak, nonatomic) IBOutlet LDProgressView *monthRatioView;
@property (weak, nonatomic) IBOutlet UIButton *normalRatioButton;
@property (weak, nonatomic) IBOutlet UIButton *queueQueryButton;

@property (weak, nonatomic) IBOutlet UILabel *leaderUserNameLabel;//值班领导
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;//总监
@property (weak, nonatomic) IBOutlet UILabel *arrSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *planNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *depSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionalStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayRatioLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthRatioLabel;
@property (weak, nonatomic) IBOutlet UITextView *noticeTextView;
@property (weak, nonatomic) IBOutlet UILabel *yesterdayReleaseRatioLabel;

@property (nonatomic, weak) id<OverviewContentViewDelegate> delegate;

@end
