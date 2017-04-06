//
//  AreaDelayTimeView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AreaDelayTimeView.h"
#import "RegionDlyTimeModel.h"
#import "DelayTimeTableViewCell.h"
#import "PNBarChart.h"
#import "PNMixLineChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"
#import "HomePageService.h"

@implementation AreaDelayTimeView

{
    PNMixLineChart *lineChart;
    NSArray<RegionDlyTimeModel *> *hourArray;
    PNBarChart *barChart;
    UITableView *flightHourTableView;
    UILabel *maxLabel;
}

-(instancetype) initWithFrame:(CGRect)                          frame
{
    self = [super initWithFrame:frame];
    if(self){

        hourArray               = [HomePageService sharedHomePageService].flightModel.regionDlyTimes;

        CGFloat topBgViewWidth  = kScreenWidth-2*px2(22);
        UIView *topBgView       = [[UIView alloc] initWithFrame:CGRectMake(10, 0, topBgViewWidth, topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView   = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(topBgView), viewHeight(topBgView))];
        topBgBackgroundImageView.image          = [UIImage imageNamed:@"TenDayRatioChartBackground"];
        [topBgView addSubview:topBgBackgroundImageView];

        UILabel *passengerTtitle    = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, viewWidth(topBgView)-100, 13)];
        passengerTtitle.font        = [UIFont fontWithName:@"PingFangSC-Regular" size:27/2];
        passengerTtitle.textColor   = [UIColor whiteColor];
        passengerTtitle.text        = @"区域平均延误时间";
        [topBgView addSubview:passengerTtitle];


        UIImageView *planImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(16, viewBotton(passengerTtitle)+ 8, 10, 10)];
        planImageView.image         = [UIImage imageNamed:@"AreaDelayTimeChartTag1"];
        [topBgView addSubview:planImageView];
        UILabel *planLabel          = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(planImageView)+2, viewY(planImageView)-1, 120, 11)
                                                               text:@"区域平均延误时间"
                                                               font:13
                                                      textAlignment:NSTextAlignmentLeft
                                                       colorFromHex:0xB5FEFEFE];
        [topBgView addSubview:planLabel];


        UIImageView *realImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(planLabel),
                                                                                  viewY(planImageView),
                                                                                  10,
                                                                                  10)];
        realImageView.image         = [UIImage imageNamed:@"AreaDelayTimeChartTag2"];
        [topBgView addSubview:realImageView];
        UILabel *realLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(realImageView)+2,
                                                                      viewY(realImageView)-1 ,
                                                                      100,
                                                                      11)
                                                      text:@"出港航班数"
                                                      font:13
                                             textAlignment:NSTextAlignmentLeft
                                              colorFromHex:0xB5FEFEFE];
        [topBgView addSubview:realLabel];

        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(planImageView),
                                                                                  viewBotton(planLabel)+8,
                                                                                  viewWidth(topBgView)-32,
                                                                                  0.5)];
        lineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:lineImageView];

//        UILabel *timeLabel = [CommonFunction addLabelFrame:CGRectMake(viewX(passengerTtitle),
//                                                                      viewBotton(lineImageView)+4,
//                                                                      topBgView.frame.size.width/2-20,
//                                                                      12)
//                                                      text:@"120 min"
//                                                      font:11
//                                             textAlignment:NSTextAlignmentLeft
//                                              colorFromHex:0x75FFFFFF];
//        [topBgView addSubview:timeLabel];

        maxLabel = [CommonFunction addLabelFrame:CGRectMake(viewWidth(topBgView)/2,
                                                                     viewBotton(lineImageView)+4,
                                                                     topBgView.frame.size.width/2-20,
                                                                     12)
                                                     text:[NSString stringWithFormat:@"%d",(int)([self maxValue
                                                                                            ]*1.2)]
                                                     font:11
                                            textAlignment:NSTextAlignmentRight
                                             colorFromHex:0x75FFFFFF];
        [topBgView addSubview:maxLabel];


        
        // 计划的折线图
        lineChart = [[PNMixLineChart alloc] initWithFrame:CGRectMake(20,
                                                                  viewBotton(maxLabel),
                                                                  topBgView.frame.size.width-40,
                                                                  topBgView.frame.size.height-(viewBotton(maxLabel))-5)];
        lineChart.backgroundColor   = [UIColor clearColor];
        lineChart.skipXPoints       = 0;
        [lineChart setXLabels:[self getFlightHourXLabels]];
        lineChart.showCoordinateAxis    = NO;
        lineChart.showGenYLabels        =NO;
        lineChart.yFixedValueMax        = [self maxValue]*1.2;
        lineChart.yFixedValueMin        = -([self maxValue]*0.1);
        
        // added an examle to show how yGridLines can be enabled
        // the color is set to clearColor so that the demo remains the same
        lineChart.yGridLinesColor = [UIColor yellowColor];
        
        lineChart.changeNum = INTMAX_MAX;
        // Line Chart #2
        NSArray * dataArray         = [self getFlightHourYLabels];
        PNLineChartData *data       = [PNLineChartData new];
        data.dataTitle              = @"航班";
        data.color                  = [CommonFunction colorFromHex:0xFFF2F925];
        data.alpha                  = 0.5f;
//        data.inflexionPointWidth    = 2.0f;
        data.itemCount              = dataArray.count;
        data.inflexionPointStyle    = PNLineChartPointStyleCircle;
        data.getData = ^(NSUInteger index) {
            CGFloat yValue = [dataArray[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        lineChart.chartData = @[data];
        
        [lineChart strokeChart];
        
        
        
        barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(20,
                                                                 viewBotton(maxLabel),
                                                                 topBgView.frame.size.width-40,
                                                                 topBgView.frame.size.height-(viewBotton(maxLabel))-5)];//折线图
        
        barChart.yMaxValue      = [self maxTimeValue]*1.2;
        barChart.yMinValue      = 0;
        barChart.showXLabel     = NO;
        barChart.showYLabel     = NO;
        barChart.barWidth       = 12;
        barChart.backgroundColor= [UIColor clearColor];
        
        barChart.yChartLabelWidth   = 20.0;
        barChart.labelTextColor     = [CommonFunction colorFromHex:0xFFFFFFFF];
        
        barChart.labelMarginTop     = 5.0;
        barChart.showChartBorder    = NO;
        barChart.barRadius          = 6.0f;
        barChart.chartMarginBottom  = 5.0f;
        [barChart setXLabels:[self getFlightHourXLabels]];
        [barChart setYValues:[self getPlanYLabels]];
        
        barChart.isGradientShow     = YES;
        barChart.isShowNumbers      = NO;
        barChart.barBackgroundColor = [UIColor clearColor];
        
        [barChart strokeChart];
        
        [topBgView addSubview:barChart];
        [topBgView addSubview:lineChart];

        
        UIImageView *downLineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(planImageView),
                                                                                      viewHeight(topBgView)-10-15-5,
                                                                                      viewWidth(topBgView)-32,
                                                                                      0.5)];
        downLineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:downLineImageView];

        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(viewTrailing(downLineImageView)-10 ,
                                                                       viewY(downLineImageView)-14, 10, 12)
                                                       text:@"0"
                                                       font:12
                                              textAlignment:NSTextAlignmentRight
                                               colorFromHex:0x75FFFFFF]];
        
        //小时分布表格
        flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                                        viewBotton(topBgView)+20,
                                                                                        kScreenWidth,
                                                                                        viewHeight(self)-25-viewBotton(topBgView))];
        flightHourTableView.delegate        = self;
        flightHourTableView.dataSource      = self;
        flightHourTableView.backgroundColor = [UIColor whiteColor];
        flightHourTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        flightHourTableView.showsVerticalScrollIndicator = NO;
        [self addSubview:flightHourTableView];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadData:)
                                                     name:@"RegionDlyTime"
                                                   object:nil];
        
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RegionDlyTime" object:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 41;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [hourArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegionDlyTimeModel *delayTime   = hourArray[indexPath.row];
    DelayTimeTableViewCell *cell    = [tableView dequeueReusableCellWithIdentifier:delayTime.region];
    
    if (!cell) {
        cell = [[DelayTimeTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault)
                                            reuseIdentifier:delayTime.region
                                                  delayTime:delayTime];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSArray *) getFlightHourXLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(RegionDlyTimeModel *model in hourArray){
        if(model.region){
            [arr addObject:model.region];
        }else{
            [arr addObject:@""];
        }
    }
    return arr;
}

-(NSArray *) getFlightHourYLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(RegionDlyTimeModel *model in hourArray){
        [arr addObject:@((int)(model.count))];
    }
    return arr;
}

-(NSArray *) getPlanYLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(RegionDlyTimeModel *model in hourArray){
        [arr addObject:@((int)(model.time))];
    }
    return arr;
}

-(void)loadData:(NSNotification *)notification
{
    hourArray = [HomePageService sharedHomePageService].flightModel.regionDlyTimes;
    [flightHourTableView reloadData];


    maxLabel.text = [NSString stringWithFormat:@"%d",(int)([self maxValue ]*1.2)];
    lineChart.yFixedValueMax        = [self maxValue]*1.2;
    lineChart.yFixedValueMin        = -([self maxValue]*0.1);
    [lineChart setXLabels:[self getFlightHourXLabels]];
    NSArray * dataArray         = [self getFlightHourYLabels];
    PNLineChartData *data       = [PNLineChartData new];
    data.dataTitle              = @"航班";
    data.color                  = [CommonFunction colorFromHex:0xFFF2F925];
    data.alpha                  = 0.5f;
    //        data.inflexionPointWidth    = 2.0f;
    data.itemCount              = dataArray.count;
    data.inflexionPointStyle    = PNLineChartPointStyleCircle;
    data.getData = ^(NSUInteger index) {
        CGFloat yValue = [dataArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };

    lineChart.chartData = @[data];
    [lineChart strokeChart];

    barChart.yMaxValue      = [self maxTimeValue]*1.2;
    [barChart setXLabels:[self getFlightHourXLabels]];
    [barChart setYValues:[self getPlanYLabels]];
    [barChart strokeChart];

}

-(int)maxValue
{
    int maxValue = 0;
    for(RegionDlyTimeModel *model in hourArray){
        if (model.count > maxValue) {
            maxValue = model.count;
        }
    }
    return maxValue==0?1:maxValue;
}

-(int)maxTimeValue
{
    int max = 0;
    for(RegionDlyTimeModel *model in hourArray){
        if (model.time>max) {
            max = model.time;
        }
    }

    return max;
}


@end
