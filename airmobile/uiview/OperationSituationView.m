//
//  OperationSituationView.m
//  airmobile
//
//  Created by xuesong on 17/3/21.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "OperationSituationView.h"
#import "PNMixTagLineChart.h"
#import "PNLineChartData.h"
#import "PNLineChartExtendDataItem.h"
#import "UIViewController+Reminder.h"
#import "HttpsUtils+Business.h"
#import "FlightHourModel.h"

@interface OperationSituationView ()

@property (nonatomic, strong ) PNMixTagLineChart *lineChart;
@property (nonatomic, strong) NSArray *lineArray;

@end

@implementation OperationSituationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{

    [super awakeFromNib];


//    self.frame = CGRectMake(0, 0, kScreenWidth, 128);

    _contentView.frame = CGRectMake(0, 0, 2000, 128);
    _lineChart = [[PNMixTagLineChart alloc] initWithFrame:CGRectMake(0, 0, 2000, 128)];
    _lineChart.backgroundColor = [UIColor clearColor];
    _lineChart.skipXPoints = 0;
    [_lineChart setXLabels:[self getFlightHourXLabels]];
    _lineChart.showCoordinateAxis = NO;
    _lineChart.showGenYLabels=NO;

    // added an examle to show how yGridLines can be enabled
    // the color is set to clearColor so that the demo remains the same
    _lineChart.yGridLinesColor = [UIColor clearColor];

    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    _lineChart.yFixedValueMax = (int)(1);
    _lineChart.yFixedValueMin = 0;

    _lineChart.xLabelColor = [UIColor blackColor];




    // Line Chart #1
    NSArray * arrArray = [self getFlightHourPlanYLabels];
    PNLineChartData *data = [PNLineChartData new];
    data.dataTitle = @"进港航班";
    data.showPointLabel = YES;
    data.pointLabelColor = [UIColor blueColor];
    data.pointLabelFont = [UIFont systemFontOfSize:15];
    data.color = [CommonFunction colorFromHex:0xFFD7CDE9];
    data.itemCount = arrArray.count;
    data.inflexionPointStyle = PNLineChartPointStyleCircle;
    data.getData = ^(NSUInteger index) {
        CGFloat yValue = [arrArray[index] floatValue];
        return [PNLineChartExtendDataItem dataItemWithY:yValue ];
    };

    // Line Chart #2
    NSArray * depArray = [self getFlightHourRealYLabels];
    PNLineChartData *data2 = [PNLineChartData new];
    data2.dataTitle = @"航班";
    data2.showPointLabel = YES;
    data2.pointLabelColor = [UIColor blueColor];
    data2.pointLabelFont = [UIFont systemFontOfSize:15];
    data2.color = [CommonFunction colorFromHex:0xFFAFD4F0];
    data2.alpha = 0.5f;
    data2.itemCount = depArray.count;
    data2.inflexionPointStyle = PNLineChartPointStyleCircle;
    data2.getData = ^(NSUInteger index) {
        CGFloat yValue = [depArray[index] floatValue];
        return [PNLineChartExtendDataItem dataItemWithY:yValue];
    };
    
    _lineChart.changeNum = [CommonFunction currentHour]-1;
    _lineChart.chartData = @[data,data2];

    [_contentView addSubview:_lineChart];

    [_lineChart strokeChart];
}



-(NSArray *) getFlightHourXLabels
{
    if(_lineArray.count <2)
        return @[];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(FlightHourModel *model in _lineArray[0]){
            [arr addObject:(model.hour)];
    }
    return arr;
}

-(NSArray *) getFlightHourPlanYLabels
{
    if(_lineArray.count <2)
        return @[];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(FlightHourModel *model in _lineArray[0]){
        [arr addObject:@((int)(model.count))];
    }
    return arr;
}
-(NSArray *) getFlightHourRealYLabels
{
    if(_lineArray.count <2)
        return @[];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(FlightHourModel *model in _lineArray[1]){
        [arr addObject:@((int)(model.count))];
    }
    return arr;
}

-(void)reDraw:(NSArray *)array
{

    if (array == nil||![array isKindOfClass:[NSArray class]]) {
        return;
    }
    _lineArray = array;

    [_lineChart setXLabels:[self getFlightHourXLabels]];

    _lineChart.yFixedValueMax = (int)([self maxValue]);

    NSArray * arrArray = [self getFlightHourPlanYLabels];
    PNLineChartData *data = [PNLineChartData new];
    data.dataTitle = @"航班";
    data.showPointLabel = YES;
    data.pointLabelColor = [UIColor blueColor];
    data.pointLabelFont = [UIFont systemFontOfSize:8];
    data.pointLabelFormat = @"计划:%1.f实际%1.f";
    data.color = [CommonFunction colorFromHex:0xFFD7CDE9];
    data.alpha = 0.5f;
    data.itemCount = arrArray.count;
    data.inflexionPointStyle = PNLineChartPointStyleCircle;
    data.getData = ^(NSUInteger index) {
        CGFloat yValue = [arrArray[index] floatValue];
        CGFloat extend = 0;
        NSArray *real =[self getFlightHourRealYLabels];
        if (real.count>index) {
            extend = ((NSNumber *)real[index]).floatValue;
        }
        return  [PNLineChartExtendDataItem dataItemWithY:yValue andRawY:yValue andExtendValue:extend];
    };

    // Line Chart #2
    NSArray * depArray = [self getFlightHourRealYLabels];
    PNLineChartData *data2 = [PNLineChartData new];
    data2.dataTitle = @"航班";
  
    data2.color = [CommonFunction colorFromHex:0xffAFD4F0];
    data2.alpha = 0.5f;
    data2.itemCount = depArray.count;
    data2.inflexionPointStyle = PNLineChartPointStyleCircle;
    data2.getData = ^(NSUInteger index) {
        CGFloat yValue = [depArray[index] floatValue];
        return [PNLineChartExtendDataItem dataItemWithY:yValue];
    };
    _lineChart.changeNum = [CommonFunction currentHour]-1;
    _lineChart.chartData = @[data,data2];
    [_lineChart strokeChart];

    NSNumber *planNum = [arrArray objectAtIndex:[CommonFunction currentHour]-1];
    _planLabel.text = [NSString stringWithFormat:@"%ld架",planNum.integerValue];
    NSNumber *realNum = [depArray objectAtIndex:[CommonFunction currentHour]-1];
    _realLabel.text = [NSString stringWithFormat:@"%ld架",realNum.integerValue];
}

-(NSInteger)maxValue
{
    NSInteger max = 0;

    if(_lineArray.count>=2){
        for (FlightHourModel *model in _lineArray[0]) {
            if (model.count>max) {
                max = model.count;
            }

        }
        for (FlightHourModel *model in _lineArray[1]) {
            if (model.count>max) {
                max = model.count;
            }

        }
    }
    return max==0?1:max;
}

@end
