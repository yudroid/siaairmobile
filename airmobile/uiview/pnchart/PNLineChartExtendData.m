//
//  PNLineChartExtendData.m
//  airmobile
//
//  Created by xuesong on 17/3/22.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "PNLineChartExtendData.h"

@implementation PNLineChartExtendData



- (id)init
{
    self = [super init];
    if (self) {
        [self setupDefaultValues];
    }

    return self;
}

- (void)setupDefaultValues
{
    _inflexionPointStyle = PNLineChartPointStyleNone;
    _inflexionPointWidth = 4.f;
    _lineWidth = 2.f;
    _alpha = 1.f;
    _showPointLabel = NO;
    _pointLabelColor = [UIColor blackColor];
    _pointLabelFormat = @"%1.f";
}

@end
