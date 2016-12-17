//
//  AnnualTargetView.h
//  KaiYa
//
//  Created by WangShiran on 16/2/29.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductionProgressRound.h"

@interface AnnualTargetView : UIView
{
    UILabel *titleLabel;
    UILabel *proportionLabel;
    UILabel *annualPlanNumLabel;
    UILabel *planFinishNumLabel;
    UILabel *finishedNumLabel;
    UILabel *unitLabel;
    
    ProductionProgressRound *progressRound;
}

@property (nonatomic,strong)NSString *titleText;
@property (nonatomic,strong)NSString *unitLabelText;
@property (nonatomic,assign)CGFloat annualPlanProportion;
@property (nonatomic,assign)CGFloat planFinishProportion;
@property (nonatomic,assign)CGFloat annualPlanNum;
@property (nonatomic,assign)CGFloat planFinishNum;
@property (nonatomic,assign)CGFloat finishedNum;
@property (nonatomic,assign)BOOL isUp;
@property (nonatomic,assign)CGFloat progressRoundPlanNum;
@property (nonatomic) int labelFlag;

@end
