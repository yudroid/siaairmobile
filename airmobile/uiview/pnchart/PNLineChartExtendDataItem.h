//
//  PNLineChartExtend DataItem.h
//  airmobile
//
//  Created by xuesong on 17/3/22.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "PNLineChartDataItem.h"

@interface PNLineChartExtendDataItem : NSObject


+ (PNLineChartDataItem *)dataItemWithY:(CGFloat)y;
+ (PNLineChartDataItem *)dataItemWithY:(CGFloat)y andRawY:(CGFloat)rawY;
+ (PNLineChartDataItem *)dataItemWithY:(CGFloat)y andRawY:(CGFloat)rawY andExtendValue:(CGFloat)extendValue;
@property (readonly) CGFloat y; // should be within the y range
@property (readonly) CGFloat rawY; // this is the raw value, used for point label.
@property (readonly) CGFloat extendValue;



@end
