//
//  PNGenericChart.h
//  PNChartDemo
//
//  Created by Andi Palo on 26/02/15.
//  Copyright (c) 2015 kevinzhow. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PNLegendPosition) {
    PNLegendPositionTop = 0,
    PNLegendPositionBottom = 1,
    PNLegendPositionLeft = 2,
    PNLegendPositionRight = 3
};

typedef NS_ENUM(NSUInteger, PNLegendItemStyle) {
    PNLegendItemStyleStacked = 0,
    PNLegendItemStyleSerial = 1
};

@interface PNGenericChart : UIView

@property (assign, nonatomic) BOOL hasLegend; //图例
@property (assign, nonatomic) PNLegendPosition legendPosition;//图例位置
@property (assign, nonatomic) PNLegendItemStyle legendStyle;//图例风格

@property (assign, nonatomic) UIFont *legendFont; //图例字体
@property (copy, nonatomic) UIColor *legendFontColor;//图例字体颜色
@property (assign, nonatomic) NSUInteger labelRowsInSerialMode;//label 的行数

/** Display the chart with or without animation. Default is YES. **/
@property (nonatomic) BOOL displayAnimated; //展示动画

/**
 *  returns the Legend View, or nil if no chart data is present.
 *  The origin of the legend frame is 0,0 but you can set it with setFrame:(CGRect)
 *
 *  @param mWidth Maximum width of legend. Height will depend on this and font size
 *
 *  @return UIView of Legend
 */

//返回一个图例视图，设置一个最大的宽度
- (UIView*) getLegendWithMaxWidth:(CGFloat)mWidth;


- (void) setupDefaultValues;
@end
