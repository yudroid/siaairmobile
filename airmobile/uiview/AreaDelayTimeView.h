//
//  AreaDelayTimeView.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNBarChart.h"
#import "PNLineChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"
#import "DelayTimeTableViewCell.h"

@interface AreaDelayTimeView : UIView<UITableViewDataSource,UITableViewDelegate>

-(instancetype) initWithFrame:(CGRect)frame;

@end
