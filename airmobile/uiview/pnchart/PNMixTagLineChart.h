//
//  PNMixTagLineChart.h
//  airmobile
//
//  Created by xuesong on 17/3/22.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "PNGenericChart.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PNChartDelegate.h"
#import "PNGenericChart.h"

@interface PNMixTagLineChart : PNGenericChart
/**
 * Draws the chart in an animated fashion.
 */
- (void)strokeChart;

@property (nonatomic, weak) id<PNChartDelegate> delegate;

@property (nonatomic) NSArray *xLabels;
@property (nonatomic) NSArray *yLabels;

/**
 * Array of `LineChartData` objects, one for each line.
 */
@property (nonatomic) NSArray *chartData;

@property (nonatomic) NSMutableArray *pathPoints;
@property (nonatomic) NSMutableArray *xChartLabels;
@property (nonatomic) NSMutableArray *yChartLabels;

@property (nonatomic) CGFloat xLabelWidth;
@property (nonatomic) UIFont *xLabelFont;
@property (nonatomic) UIColor *xLabelColor;
@property (nonatomic) CGFloat yValueMax;
@property (nonatomic) CGFloat yFixedValueMax;
@property (nonatomic) CGFloat yFixedValueMin;
@property (nonatomic) CGFloat yValueMin;
@property (nonatomic) NSInteger yLabelNum;
@property (nonatomic) CGFloat yLabelHeight;
@property (nonatomic) UIFont *yLabelFont;
@property (nonatomic) UIColor *yLabelColor;
@property (nonatomic) CGFloat chartCavanHeight;
@property (nonatomic) CGFloat chartCavanWidth;
@property (nonatomic) CGFloat xLabelMarginTop;
@property (nonatomic) BOOL showLabel;
@property (nonatomic) int skipXPoints;
@property (nonatomic) BOOL showGenYLabels;
@property (nonatomic) BOOL showYGridLines;
@property (nonatomic) UIColor *yGridLinesColor;
@property (nonatomic) BOOL thousandsSeparator;

@property (nonatomic) CGFloat chartMarginLeft;
@property (nonatomic) CGFloat chartMarginRight;
@property (nonatomic) CGFloat chartMarginTop;
@property (nonatomic) CGFloat chartMarginBottom;

@property (nonatomic, assign) NSInteger changeNum;//虚线和实线拐点

/**
 * Controls whether to show the coordinate axis. Default is NO.
 */
@property (nonatomic, getter = isShowCoordinateAxis) BOOL showCoordinateAxis;
@property (nonatomic) UIColor *axisColor;
@property (nonatomic) CGFloat axisWidth;

@property (nonatomic, strong) NSString *xUnit;
@property (nonatomic, strong) NSString *yUnit;

/**
 * String formatter for float values in y-axis labels. If not set, defaults to @"%1.f"
 */
@property (nonatomic, strong) NSString *yLabelFormat;

/**
 * Block formatter for custom string in y-axis labels. If not set, defaults to yLabelFormat
 */
@property (nonatomic, copy) NSString* (^yLabelBlockFormatter)(CGFloat);


/**
 * Controls whether to curve the line chart or not
 */
@property (nonatomic) BOOL showSmoothLines;

- (void)setXLabels:(NSArray *)xLabels withWidth:(CGFloat)width;

/**
 * Update Chart Value
 */

- (void)updateChartData:(NSArray *)data;


/**
 *  returns the Legend View, or nil if no chart data is present.
 *  The origin of the legend frame is 0,0 but you can set it with setFrame:(CGRect)
 *
 *  @param mWidth Maximum width of legend. Height will depend on this and font size
 *
 *  @return UIView of Legend
 */
- (UIView*) getLegendWithMaxWidth:(CGFloat)mWidth;


+ (CGSize)sizeOfString:(NSString *)text withWidth:(float)width font:(UIFont *)font;

+ (CGPoint)midPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2;
+ (CGPoint)controlPointBetweenPoint1:(CGPoint)point1 andPoint2:(CGPoint)point2;

@end