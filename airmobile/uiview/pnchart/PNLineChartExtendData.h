//
//  PNLineChartExtendData.h
//  airmobile
//
//  Created by xuesong on 17/3/22.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PNLineChartPointStyle) {
    PNLineChartPointStyleNone = 0,
    PNLineChartPointStyleCircle = 1,
    PNLineChartPointStyleSquare = 3,
    PNLineChartPointStyleTriangle = 4
};

@class PNLineChartExtendDataItem;

typedef PNLineChartExtendDataItem *(^LCLineChartDataGetter)(NSUInteger item);

@interface PNLineChartExtendData : NSObject


@property (strong) UIColor *color;
@property (nonatomic) CGFloat alpha;
@property NSUInteger itemCount;
@property (copy) LCLineChartDataGetter getData;
@property (strong, nonatomic) NSString *dataTitle;

@property (nonatomic) BOOL showPointLabel;
@property (nonatomic) UIColor *pointLabelColor;
@property (nonatomic) UIFont *pointLabelFont;
@property (nonatomic) NSString *pointLabelFormat;

@property (nonatomic, assign) PNLineChartPointStyle inflexionPointStyle;
@property (nonatomic) UIColor *inflexionPointColor;

/**
 * If PNLineChartPointStyle is circle, this returns the circle's diameter.
 * If PNLineChartPointStyle is square, each point is a square with each side equal in length to this value.
 */
@property (nonatomic, assign) CGFloat inflexionPointWidth;

@property (nonatomic, assign) CGFloat lineWidth;


@end
