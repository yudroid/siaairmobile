//
//  MonthlyTargetView.h
//  KaiYa
//
//  Created by WangShiran on 16/3/1.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthlyProgressRound.h"


@interface MonthlyTargetView : UIView
{
    UILabel *titleLabel;
    /**
     *  二级指标
     */
    UILabel *secondTitleLabel;
    UILabel *monthlyPlanNumLabel;
    UILabel *finishedNumLabel;
    UILabel *unitLabel;
    
    MonthlyProgressRound *progressRound;
}

@property (nonatomic,strong)NSString *titleText;
@property (nonatomic,strong)NSString *secondTitleText;
@property (nonatomic,strong)NSString *unitLabelText;
@property (nonatomic,assign)CGFloat monthlyPlanNum;
@property (nonatomic,assign)CGFloat finishedNum;
@property (nonatomic,assign)CGFloat proportion;
@property (nonatomic) int labelFlag;

@end