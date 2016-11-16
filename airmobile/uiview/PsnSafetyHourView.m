//
//  PsnSafetyHourView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/27.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PsnSafetyHourView.h"
#import "PNLineChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"
#import "FlightHourModel.h"
#import "FlightHourTableViewCell.h"

@implementation PsnSafetyHourView
{
    PNLineChart *lineChart;
    NSMutableArray<FlightHourModel *> *hourArray;
}

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){

        [self initData];
        
        CGFloat topBgViewWidth = kScreenWidth-2*px2(22);
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, topBgViewWidth, topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(topBgView), viewHeight(topBgView))];
        topBgBackgroundImageView.image = [UIImage imageNamed:@"PsnSafetyHourTopBackground"];
        [topBgView addSubview:topBgBackgroundImageView];

        UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, viewWidth(topBgView)-100, 11)];
        passengerTtitle.text = @"隔离区内旅客小时分布";
        passengerTtitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:27/2];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];

        UILabel *ratioNum = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width-100, 10, 80, 18) text:@"3233" font:20 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
        ratioNum.font = [UIFont fontWithName:@"PingFang SC" size:px2(48)];
        [topBgView addSubview:ratioNum];

        UIImageView *planImageView = [[UIImageView alloc]initWithFrame:CGRectMake(17, viewBotton(passengerTtitle)+ 8, 11, 11)];
        planImageView.image = [UIImage imageNamed:@"PsnSafetyHourChartTag1"];
        [topBgView addSubview:planImageView];
        UILabel *planLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(planImageView)+2, viewY(planImageView), 100, 11) text:@"人数" font:27/2 textAlignment:NSTextAlignmentLeft colorFromHex:0xB5FFFFFF];
        [topBgView addSubview:planLabel];


        UIImageView *upImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px2(34), viewBotton(planLabel)+px2(8), viewWidth(topBgView)-2*px2(34), px2(2))];
        upImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:upImageView];

        UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(20, viewBotton(upImageView)+px2(8), topBgView.frame.size.width-40, 12) text:@"10000" font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF];
        [topBgView addSubview:maxLabel];
        
        // 计划的折线图
        lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 5+23+15+2, topBgView.frame.size.width-40, topBgView.frame.size.height-(5+23+15+2)-5)];
        lineChart.backgroundColor = [UIColor clearColor];
        lineChart.skipXPoints = 1;
        [lineChart setXLabels:[self getFlightHourXLabels]];
        lineChart.showCoordinateAxis = NO;
        lineChart.showGenYLabels=NO;
        lineChart.yFixedValueMax = 100;
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
        [topBgView addSubview:lineChart];
        
        UILabel *zoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth(topBgView)-6-px2(31), topBgView.frame.size.height-(10+15+12+2), topBgView.frame.size.width-40, 10)];
        zoreLabel.text = @"0";
        zoreLabel.font = [UIFont fontWithName:@"PingFang SC" size:px2(22)];
        zoreLabel.textColor = [CommonFunction colorFromHex:0X75ffffff];
        [topBgView addSubview:zoreLabel];

        UIImageView *lowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px2(31), topBgView.frame.size.height-10-15-2, viewWidth(topBgView)-2*px2(31), px2(2))];
        lowImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:lowImageView];
        
        //小时分布表格
        UITableView *flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, viewBotton(topBgView)+5, kScreenWidth, kScreenHeight-65-viewBotton(topBgView)-5-37)];
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
    return 54;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [hourArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlightHourModel *flightHour = hourArray[indexPath.row];
    FlightHourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flightHour.hour];
    
    if (!cell) {
        cell = [[FlightHourTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:flightHour.hour flightHour:flightHour];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSArray *) getFlightHourXLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(FlightHourModel *model in hourArray){
        [arr addObject:[model.hour componentsSeparatedByString:@":"][0]];
    }
    return arr;
}

-(NSArray *) getFlightHourYLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(FlightHourModel *model in hourArray){
        [arr addObject:@((int)(model.count))];
    }
    return arr;
}

-(NSArray *) getPlanYLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(FlightHourModel *model in hourArray){
        [arr addObject:@((int)(model.planCount))];
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
    
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"1:00" count:25 planCount:25]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"2:00" count:35 planCount:35]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"3:00" count:15 planCount:15]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"4:00" count:10 planCount:10]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"5:00" count:25 planCount:25]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"6:00" count:35 planCount:35]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"7:00" count:45 planCount:50]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"8:00" count:55 planCount:65]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"9:00" count:50 planCount:50]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"10:00" count:48 planCount:48]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"11:00" count:50 planCount:62]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"12:00" count:45 planCount:45]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"13:00" count:55 planCount:55]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"14:00" count:60 planCount:60]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"15:00" count:50 planCount:50]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"16:00" count:60 planCount:60]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"17:00" count:45 planCount:45]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"18:00" count:35 planCount:35]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"19:00" count:45 planCount:45]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"20:00" count:25 planCount:25]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"21:00" count:20 planCount:20]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"22:00" count:25 planCount:25]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"23:00" count:30 planCount:30]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"00:00" count:15 planCount:15]];
}

@end
