//
//  ProductionTargetViewController.h
//  KaiYa
//
//  Created by WangShiran on 16/2/26.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "RootViewController.h"
#import "AnnualTargetView.h"
#import "MonthlyTargetView.h"
#import "FunctionService.h"
#import "ProductionKpi.h"

@interface ProductionTargetViewController : RootViewController <UIScrollViewDelegate>
{
    UIImageView *overviewIcon;
    UIImageView *guaranteeIcon;
    UIImageView *resourcesIcon;
    UIImageView *iconBg;
    
    UIScrollView *scrollView;
    UIPageControl *pageDot;
    
    AnnualTargetView *annualTargetView;
    MonthlyTargetView *monthlyTargetView;
    
    ProductionKpi *kpi;
}

@end
