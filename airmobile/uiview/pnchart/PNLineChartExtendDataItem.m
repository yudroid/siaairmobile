//
//  PNLineChartExtend DataItem.m
//  airmobile
//
//  Created by xuesong on 17/3/22.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "PNLineChartExtendDataItem.h"

@interface PNLineChartExtendDataItem()

- (id)initWithY:(CGFloat)y andRawY:(CGFloat)rawY andExtendValue:(CGFloat)extendValue;

@property (readwrite) CGFloat y;    // should be within the y range
@property (readwrite) CGFloat rawY; // this is the raw value, used for point label.
@property (readwrite) CGFloat extendValue;

@end

@implementation PNLineChartExtendDataItem


+ (instancetype)dataItemWithY:(CGFloat)y
{
    return [[PNLineChartExtendDataItem alloc] initWithY:y andRawY:y andExtendValue:y];
}

+ (instancetype )dataItemWithY:(CGFloat)y andRawY:(CGFloat)rawY {
    return [[PNLineChartExtendDataItem alloc] initWithY:y andRawY:rawY andExtendValue:y];
}

+(instancetype)dataItemWithY:(CGFloat)y andRawY:(CGFloat)rawY andExtendValue:(CGFloat)extendValue
{
    return [[PNLineChartExtendDataItem alloc] initWithY:y andRawY:rawY andExtendValue:extendValue];
}
- (id)initWithY:(CGFloat)y andRawY:(CGFloat)rawY andExtendValue:(CGFloat)extendValue
{
    if ((self = [super init])) {
        self.y = y;
        self.rawY = rawY;
        self.extendValue = extendValue;
    }

    return self;
}
@end
