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
#import "FlightHourView.h"
@class FlightStusModel;

@protocol FlightContentViewDelegate <NSObject>

@optional

/**
 展示航班进出港小时分布视、即将出港的航班列表
 */
-(void) showFlightHourView:(FlightHourType) type;


/**
 展示航班异常原因分类、各地区平均延误时间图
 */
-(void) showFlightAbnnormalView;

@end

@interface FlightContentView : UIView<UIScrollViewDelegate>


@property (nonatomic, weak) id<FlightContentViewDelegate> delegate;


-(instancetype)initWithFrame:(CGRect)                       frame
                    delegate:(id<FlightContentViewDelegate>)delegate;

@end
