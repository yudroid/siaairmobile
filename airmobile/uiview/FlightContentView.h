//
//  FlightContentView.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundProgressView.h"
#import "PNPieChart.h"

@protocol FlightContentViewDelegate <NSObject>

@optional

/**
 展示航班进出港小时分布视、即将出港的航班列表
 */
-(void) showFlightHourView;


/**
 展示航班异常原因分类、各地区平均延误时间图
 */
-(void) showFlightAbnnormalView;

@end

@interface FlightContentView : UIView<UIScrollViewDelegate>
{
    UIPageControl *pageControl;
    NSMutableArray *arrShapeArray;
    NSMutableArray *depShapeArray;
}

@end
