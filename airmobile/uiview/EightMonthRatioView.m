//
//  EightMonthRatioView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "EightMonthRatioView.h"
#import "PNBarChart.h"
#import "ReleasedRatioModel.h"
#import "RatioTableViewCell.h"
#import "HomePageService.h"
#import "PNMixLineChart.h"
#import "PNLineChartData.h"

@implementation EightMonthRatioView

{
    PNBarChart                              *barChart;
    UILabel                                 *todayLabel;
    UILabel                                 *ratioNum;
    UITableView                             *tenDayTableView;
    NSArray<ReleasedRatioModel *>           *thisYearArray;
    NSArray<ReleasedRatioModel *>           *lastYearArray;
    PNMixLineChart                          *lineChart;
}

-(instancetype)initWithFrame:(CGRect)   frame
{
    self = [super initWithFrame:frame];

    if(self){

        thisYearArray = [[HomePageService sharedHomePageService].summaryModel.yearReleased copy];
        lastYearArray = [[HomePageService sharedHomePageService].summaryModel.lastYearReleased copy];

        CGFloat topBgViewWidth = kScreenWidth-2*px2(22);
        UIView  *topBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, topBgViewWidth, topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView   = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(topBgView), viewHeight(topBgView))];
        topBgBackgroundImageView.image          = [UIImage imageNamed:@"TenDayRatioChartBackground"];
        [topBgView addSubview:topBgBackgroundImageView];

        [topBgView.layer setMasksToBounds:YES];// 隐藏边界

        UILabel *passengerTtitle    = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, viewWidth(topBgView)-100, 13)];
        passengerTtitle.text        = @"平均放行正常率";
        passengerTtitle.font        = [UIFont fontWithName:@"PingFangSC-Regular" size:27/2];
        passengerTtitle.textColor   = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];

        ratioNum = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width-100, 7.5, 80, 20)
                                                     text:@""
                                                     font:24
                                            textAlignment:NSTextAlignmentRight
                                             colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:ratioNum];



        todayLabel = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width-140, viewHeight(ratioNum)+viewY(ratioNum) , 120, 20)
                                                       text:@""
                                                       font:11
                                              textAlignment:NSTextAlignmentRight
                                               colorFromHex:0x75FFFFFF];
        [topBgView addSubview:todayLabel];

        UIImageView *planImageView = [[UIImageView alloc]initWithFrame:CGRectMake(16,
                                                                                  viewBotton(passengerTtitle)+ px_px_2_3(16, 28),
                                                                                  10,
                                                                                  10)];
        planImageView.image = [UIImage imageNamed:@"FlightHourChartTag"];
        [topBgView addSubview:planImageView];
        UIImageView *inPlanImageView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"FlightHourChartTag3"]];
        inPlanImageView.center      = planImageView.center;
        [topBgView addSubview:inPlanImageView];

        UILabel *planLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(planImageView)+2,
                                                                      viewY(planImageView)-1,
                                                                      100,
                                                                      11)
                                                      text:@"前一年同期"
                                                      font:12
                                             textAlignment:NSTextAlignmentLeft
                                              colorFromHex:0xB5FEFEFE];
        [topBgView addSubview:planLabel];


        UIImageView *realImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(planLabel),
                                                                                  viewY(planImageView)-3,
                                                                                  5,
                                                                                  14)];
        realImageView.image = [UIImage imageNamed:@"FlightHourChartTag2"];
        [topBgView addSubview:realImageView];
        UILabel *realLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(realImageView)+2,
                                                                      viewY(planLabel) , 100, 11)
                                                      text:@"最近12月"
                                                      font:12
                                             textAlignment:NSTextAlignmentLeft
                                              colorFromHex:0xB5FEFEFE];
        [topBgView addSubview:realLabel];


        UIImageView *lineImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle),
                                                                                  viewY(realLabel)+viewHeight(realLabel)+4,
                                                                                  viewWidth(topBgView)-viewX(passengerTtitle)-18,
                                                                                  0.5)];
        lineImageView.image         = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:lineImageView];


        UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(viewWidth(topBgView)-18-50,viewBotton(lineImageView)+4, 50, 12)
                                                     text:@"100"
                                                     font:11
                                            textAlignment:NSTextAlignmentRight
                                             colorFromHex:0x75FFFFFF];
        [topBgView addSubview:maxLabel];

//        barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(viewX(passengerTtitle),
//                                                                viewBotton(lineImageView),
//                                                                viewWidth(topBgView)-viewX(passengerTtitle)-18,
//                                                                viewHeight(topBgView)-viewBotton(lineImageView)-5)];
//
//        barChart.showXLabel         = YES;
//        barChart.showYLabel         = NO;
//        barChart.backgroundColor    = [UIColor clearColor];
//
//        barChart.yMaxValue          = 100;
//        barChart.yMinValue          = 30;
//        barChart.yChartLabelWidth   = 20.0;
//        barChart.chartMarginTop     = 5.0;
//        barChart.chartMarginBottom  = 10.0;
//        barChart.labelTextColor     = [CommonFunction colorFromHex:0xFFFFFFFF];
//
//
//        barChart.labelMarginTop     = 5.0;
//        barChart.showChartBorder    = NO;
//        barChart.barRadius          = 6.0f;
//        [barChart setXLabels:[self getXLabels]];
//        [barChart setYValues:[self getYLabels]];
//
//        barChart.isGradientShow     = YES;
//        barChart.isShowNumbers      = NO;
//        barChart.barBackgroundColor = [UIColor clearColor];
//
//        [barChart strokeChart];
//        [topBgView addSubview:barChart];
//        // 计划的折线图
//        lineChart = [[PNMixLineChart alloc] initWithFrame:barChart.frame];
//        lineChart.backgroundColor   = [UIColor clearColor];
//        [lineChart setXLabels:[self getXLabels]];
//        lineChart.showCoordinateAxis= NO;
//        lineChart.showGenYLabels    =NO;
//        lineChart.yFixedValueMax    = 100;
//        lineChart.yFixedValueMin    = 30;
//        lineChart.chartMarginTop     = 5.0;
//        lineChart.chartMarginBottom  = 10.0;
//
//        lineChart.changeNum = [CommonFunction currentHour]-1;
//
//        // added an examle to show how yGridLines can be enabled
//        // the color is set to clearColor so that the demo remains the same
//        lineChart.yGridLinesColor = [UIColor yellowColor];
//
//
//        // Line Chart #2
//        NSArray * dataArray     = [self getYLabels];
//        PNLineChartData *data   = [PNLineChartData new];
//        data.dataTitle          = @"航班";
//        data.color              = [UIColor whiteColor];
//        data.alpha              = 0.5f;
//        //        data.inflexionPointWidth= 2.0f;
//        data.itemCount          = dataArray.count;
//        data.inflexionPointStyle= PNLineChartPointStyleCircle;
//        data.getData = ^(NSUInteger index) {
//            CGFloat yValue = [dataArray[index] floatValue];
//            return [PNLineChartDataItem dataItemWithY:yValue];
//        };
//
//        lineChart.chartData = @[data];
//        
//        [lineChart strokeChart];
//        [topBgView addSubview:lineChart];
        // 计划的折线图
        lineChart = [[PNMixLineChart alloc] initWithFrame:CGRectMake(viewX(passengerTtitle),
                                                                     viewBotton(lineImageView),
                                                                     viewWidth(topBgView)-viewX(passengerTtitle)-18,
                                                                     viewHeight(topBgView)-viewBotton(lineImageView)-5)];
        lineChart.backgroundColor   = [UIColor clearColor];

        lineChart.xLabelColor = [UIColor clearColor];
        [lineChart setXLabels:[self getLineXLabels]];
        lineChart.showCoordinateAxis= NO;
        lineChart.showGenYLabels    =NO;
        lineChart.yFixedValueMax    = 100;
        lineChart.yFixedValueMin    = 0;
        lineChart.chartMarginBottom = 0.0;
        lineChart.chartMarginTop = 20;

        lineChart.changeNum = NSIntegerMax;

        // added an examle to show how yGridLines can be enabled
        // the color is set to clearColor so that the demo remains the same
//        lineChart.yGridLinesColor = [UIColor yellowColor];


        // Line Chart #2
        NSArray * dataArray     = [self getLineYLabels];
        PNLineChartData *data   = [PNLineChartData new];
        data.dataTitle          = @"航班";
        data.color              = [UIColor whiteColor];
        data.alpha              = 0.5f;
        //        data.inflexionPointWidth= 2.0f;
        data.itemCount          = dataArray.count;
        data.inflexionPointStyle= PNLineChartPointStyleCircle;
        data.getData = ^(NSUInteger index) {
            CGFloat yValue = [dataArray[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };

        lineChart.chartData = @[data];

        [lineChart strokeChart];


        //柱状图
        barChart = [[PNBarChart alloc] initWithFrame:lineChart.frame];


        barChart.yMaxValue          = 100;
        barChart.yMinValue          = 0;
//        barChart.showXLabel         = NO;
        barChart.showYLabel         = NO;
        barChart.backgroundColor    = [UIColor clearColor];
        barChart.barBackgroundColor = [UIColor clearColor];

//        barChart.yChartLabelWidth   = 20.0;
        barChart.labelTextColor     = [CommonFunction colorFromHex:0xFFFFFFFF];


        barChart.labelMarginTop     = 5.0;
        barChart.showChartBorder    = NO;
        barChart.barRadius          = 2.0f;
        barChart.chartMarginBottom  = 5.0f;
        [barChart setXLabels:[self getXLabels]];
        [barChart setYValues:[self getYLabels]];

        barChart.isGradientShow     = YES;
        barChart.isShowNumbers      = NO;
        //        barChart.strokeColor = [CommonFunction colorFromHex:0xff6AF9DF];
        NSMutableArray *colors = [NSMutableArray array];
        NSInteger num = [self getXLabels].count;
        for (NSInteger i = 0; i<num; i++) {
            if (i<NSIntegerMax) {
                [colors addObject:[CommonFunction colorFromHex:0xff6AF9DF]];
            }else{
                [colors addObject:[CommonFunction colorFromHex:0xffB0C4DE]];
            }
        }
        barChart.strokeColors = [colors copy];
        [barChart strokeChart];


        [topBgView addSubview:barChart];
        [topBgView addSubview:lineChart];




        UIImageView *downlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle),
                                                                                      viewBotton(barChart)-25,
                                                                                      viewWidth(topBgView)-viewX(passengerTtitle)-18,
                                                                                      0.5)];
        downlineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:downlineImageView];

        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, viewY(downlineImageView)-13-4, topBgView.frame.size.width-40, 13)
                                                       text:@"0"
                                                       font:11
                                              textAlignment:NSTextAlignmentRight
                                               colorFromHex:0x75FFFFFF]];

        UIImageView *thresholdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(barChart), 2)];

        thresholdImageView.center = CGPointMake(barChart.center.x,
                                                viewBotton(barChart)-25 - [HomePageService sharedHomePageService].summaryModel.releaseRatioThreshold*100/barChart.yMaxValue*(viewHeight(barChart)-50));
        thresholdImageView.image = [UIImage imageNamed:@"thresholdLine"];

        [topBgView addSubview:thresholdImageView];

        UILabel *thresholdLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewTrailing(thresholdImageView)-100, viewBotton(thresholdImageView),100, 10)];
        thresholdLabel.text = [NSString stringWithFormat:@"%.0f%%",[HomePageService sharedHomePageService].summaryModel.releaseRatioThreshold*100];
        thresholdLabel.textColor = [UIColor redColor];
        thresholdLabel.font = [UIFont systemFontOfSize:10];
        thresholdLabel.textAlignment = NSTextAlignmentRight;
        [topBgView addSubview:thresholdLabel];


        //阈值线2
        UIImageView *thresholdImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(barChart), 2)];

        thresholdImageView1.center = CGPointMake(barChart.center.x,
                                                 viewBotton(barChart)-25 - [HomePageService sharedHomePageService].summaryModel.releaseRatioThreshold2*100/barChart.yMaxValue*(viewHeight(barChart)-50));
        thresholdImageView1.image = [UIImage imageNamed:@"thresholdLine"];

        [topBgView addSubview:thresholdImageView1];

        UILabel *thresholdLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(viewX(thresholdImageView1), viewBotton(thresholdImageView1),100, 10)];
        thresholdLabel1.text = [NSString stringWithFormat:@"%.0f%%",[HomePageService sharedHomePageService].summaryModel.releaseRatioThreshold2*100];
        thresholdLabel1.textColor = [UIColor redColor];
        thresholdLabel1.font = [UIFont systemFontOfSize:10];
        thresholdLabel1.textAlignment = NSTextAlignmentLeft;
        [topBgView addSubview:thresholdLabel1];




        //小时分布表格
        tenDayTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                                     viewBotton(topBgView)+8,
                                                                                     kScreenWidth,
                                                                                     viewHeight(self)-viewBotton(topBgView)-8-10)];
        tenDayTableView.delegate                        = self;
        tenDayTableView.dataSource                      = self;
        tenDayTableView.showsVerticalScrollIndicator    = NO;
        tenDayTableView.backgroundColor                 = [UIColor whiteColor];
        tenDayTableView.separatorStyle                  = UITableViewCellSeparatorStyleNone;
        [self addSubview:tenDayTableView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadThisYearData:)
                                                     name:@"FlightYearRatio"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadLastYearData:)
                                                     name:@"lastYearFltFMR"
                                                   object:nil];
    }

    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"FlightYearRatio"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"lastYearFltFMR"
                                                  object:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [thisYearArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReleasedRatioModel *ratio1 = thisYearArray[thisYearArray.count-1- indexPath.row];
    ReleasedRatioModel *ratio2;
    if (indexPath.row<lastYearArray.count) {
        ratio2 = lastYearArray[lastYearArray.count-1-indexPath.row];
    }
    RatioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ratio1.time];
    
    if (!cell) {
        cell = [[RatioTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault)
                                        reuseIdentifier:ratio1.time thisRatio:ratio1
                                          lastthisRatio:ratio2];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


////柱状图 x y值
-(NSArray *) getXLabels
{
    NSMutableArray *arr     = [[NSMutableArray alloc] init];
    for(ReleasedRatioModel *model in thisYearArray){
        [arr addObject:model.time];
    }
    return arr;
}

-(NSArray *) getYLabels
{
    NSMutableArray *arr     = [[NSMutableArray alloc] init];
    for(ReleasedRatioModel *model in thisYearArray){
        [arr addObject:@((int)(model.ratio*100))];
    }
    return arr;
}

//折线图 x y值
-(NSArray *) getLineXLabels
{
    NSMutableArray *arr     = [[NSMutableArray alloc] init];
    for(ReleasedRatioModel *model in lastYearArray){
        [arr addObject:model.time?:@""];
    }
    return arr;
}

-(NSArray *) getLineYLabels
{
    NSMutableArray *arr     = [[NSMutableArray alloc] init];
    for(ReleasedRatioModel *model in lastYearArray){
        [arr addObject:@((int)(model.ratio*100))];
    }
    return arr;
}


-(CGFloat)sum
{
    CGFloat s = 0.0;
    for (ReleasedRatioModel *model in thisYearArray) {
        s +=model.ratio;
    }
    s = s/thisYearArray.count;
    return s;
}

-(void)loadThisYearData:(NSNotification *)notification
{
    thisYearArray = [[HomePageService sharedHomePageService].summaryModel.yearReleased copy];;
    [barChart setXLabels:[self getXLabels]];
    [barChart setYValues:[self getYLabels]];
    [barChart strokeChart];
    [tenDayTableView reloadData];
}

-(void)loadLastYearData:(NSNotification *)notification
{
    lastYearArray = [[HomePageService sharedHomePageService].summaryModel.lastYearReleased copy];
    [lineChart setXLabels:[self getLineXLabels]];
    // Line Chart #2
    NSArray * dataArray     = [self getLineYLabels];
    PNLineChartData *data   = [PNLineChartData new];
    data.dataTitle          = @"航班";
    data.color              = [UIColor whiteColor];
    data.alpha              = 0.5f;
    //        data.inflexionPointWidth= 2.0f;
    data.itemCount          = dataArray.count;
    data.inflexionPointStyle= PNLineChartPointStyleCircle;
    data.getData = ^(NSUInteger index) {
        CGFloat yValue = [dataArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    lineChart.chartData = @[data];
    [lineChart strokeChart];
    [tenDayTableView reloadData];

}


@end
