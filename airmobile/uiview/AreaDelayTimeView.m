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
#import "PNLineChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"

@implementation AreaDelayTimeView

{
    PNLineChart *lineChart;
    NSMutableArray<RegionDlyTimeModel *> *hourArray;
    PNBarChart *barChart;
}

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        [self initData];
        
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, kScreenWidth-40, 200)];
        [self addSubview:topBgView];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = topBgView.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[CommonFunction colorFromHex:0XFF3AB2F7] CGColor], (id)[[CommonFunction colorFromHex:0XFF936DF7] CGColor], nil];
        [topBgView.layer insertSublayer:gradient atIndex:0];
        [topBgView.layer setCornerRadius:8.0];// 将图层的边框设置为圆脚
        [topBgView.layer setMasksToBounds:YES];// 隐藏边界
        
        UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, topBgView.frame.size.width-100, 23)];

        passengerTtitle.text = @"出港航班小时分布";

        passengerTtitle.font = [UIFont systemFontOfSize:18];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];
        
        UILabel *planLabel = [CommonFunction addLabelFrame:CGRectMake(20, 5+23 , 100, 15) text:@"平均延误时间" font:15 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:planLabel];
        
        UILabel *realLabel = [CommonFunction addLabelFrame:CGRectMake(20+100, 5+23 , 100, 15) text:@"延误架次" font:15 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:realLabel];
        
        
        [topBgView addSubview:[CommonFunction addLine:CGRectMake(20, 5+23+15, topBgView.frame.size.width-40, 1) color:[CommonFunction colorFromHex:0XFF3FDFB7]]];
        
        UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(20, 5+23+15+2, topBgView.frame.size.width-40, 12) text:@"100" font:12 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:maxLabel];
        
        
        // 计划的折线图
        lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 5+23+15+2, topBgView.frame.size.width-40, topBgView.frame.size.height-(5+23+15+2)-5)];
        lineChart.backgroundColor = [UIColor clearColor];
        lineChart.skipXPoints = 0;
        [lineChart setXLabels:[self getFlightHourXLabels]];
        lineChart.showCoordinateAxis = NO;
        lineChart.showGenYLabels=NO;
        lineChart.yFixedValueMax = 70;
        lineChart.yFixedValueMin = 0;
        
        // added an examle to show how yGridLines can be enabled
        // the color is set to clearColor so that the demo remains the same
        lineChart.yGridLinesColor = [UIColor yellowColor];
        
        
        // Line Chart #2
        NSArray * dataArray = [self getFlightHourYLabels];
        PNLineChartData *data = [PNLineChartData new];
        data.dataTitle = @"航班";
        data.color = [UIColor whiteColor];
        data.alpha = 0.5f;
        data.inflexionPointWidth = 2.0f;
        data.itemCount = dataArray.count;
        data.inflexionPointStyle = PNLineChartPointStyleCircle;
        data.getData = ^(NSUInteger index) {
            CGFloat yValue = [dataArray[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        lineChart.chartData = @[data];
        
        [lineChart strokeChart];
        
        
        
        barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(20, 5+23+15+2, topBgView.frame.size.width-40, topBgView.frame.size.height-(5+23+15+2)-5)];//折线图
        
        barChart.yMaxValue = 70;
        barChart.yMinValue = 0;
        barChart.showXLabel = NO;
        barChart.showYLabel = NO;
        barChart.barWidth = 12;
        barChart.backgroundColor = [UIColor clearColor];
        
        barChart.yChartLabelWidth = 20.0;
        barChart.labelTextColor = [CommonFunction colorFromHex:0xFFFFFFFF];
        
        barChart.labelMarginTop = 5.0;
        barChart.showChartBorder = NO;
        barChart.barRadius = 6.0f;
        barChart.chartMarginBottom = 5.0f;
        [barChart setXLabels:[self getFlightHourXLabels]];
        [barChart setYValues:[self getPlanYLabels]];
        
        barChart.isGradientShow = YES;
        barChart.isShowNumbers = NO;
        barChart.barBackgroundColor = [UIColor clearColor];
        
        [barChart strokeChart];
        
        [topBgView addSubview:barChart];
        [topBgView addSubview:lineChart];
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, topBgView.frame.size.height-(10+15+12), topBgView.frame.size.width-40, 12) text:@"0" font:12 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLine:CGRectMake(20, topBgView.frame.size.height-10-15, topBgView.frame.size.width-40, 1) color:[CommonFunction colorFromHex:0XFF3FDFB7]]];
        
        //小时分布表格
        UITableView *flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 20+200+20, kScreenWidth-40, kScreenHeight-10-(65+20+200+20+40))];
        flightHourTableView.delegate = self;
        flightHourTableView.dataSource = self;
        flightHourTableView.showsVerticalScrollIndicator = NO;
        flightHourTableView.backgroundColor = [UIColor whiteColor];
        flightHourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:flightHourTableView];
        
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [hourArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegionDlyTimeModel *delayTime = hourArray[indexPath.row];
    DelayTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:delayTime.region];
    
    if (!cell) {
        cell = [[DelayTimeTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:delayTime.region delayTime:delayTime];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSArray *) getFlightHourXLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(RegionDlyTimeModel *model in hourArray){
        [arr addObject:model.region];
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

-(void) initData
{
    if(hourArray == nil){
        hourArray = [[NSMutableArray alloc] init];
    }else{
        [hourArray removeAllObjects];
    }
    
    [hourArray addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"华东" count:25 time:45]];
    [hourArray addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"华北" count:15 time:60]];
    [hourArray addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"华中" count:35 time:70]];
    [hourArray addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"华南" count:25 time:35]];
    [hourArray addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"西南" count:15 time:55]];
    [hourArray addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"西北" count:60 time:10]];
    [hourArray addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"东北" count:70 time:12]];
    [hourArray addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"地区" count:21 time:45]];
    [hourArray addObject:[[RegionDlyTimeModel alloc] initWithRegion:@"国际" count:25 time:16]];
}

@end
