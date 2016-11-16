//
//  FlightHourView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightHourView.h"

@implementation FlightHourView
{
    PNLineChart *lineChart;
    NSMutableArray<FlightHourModel *> *hourArray;
    FlightHourType _flightHourType;
    PNBarChart *barChart;
}

-(instancetype) initWithFrame:(CGRect)frame flightHourType:(FlightHourType) type
{
    self = [super initWithFrame:frame];
    if(self){
        
        _flightHourType = type;
        [self initData];
        
        CGFloat topBgViewWidth = kScreenWidth-2*px2(22);
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, topBgViewWidth, topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(topBgView), viewHeight(topBgView))];
        topBgBackgroundImageView.image = [UIImage imageNamed:@"FlightHourChartBlackground"];
        [topBgView addSubview:topBgBackgroundImageView];
        
        UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(px_px_2_3(32, 73),px_px_2_3(10, 24) , viewWidth(topBgView)-100, 11)];
        passengerTtitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:27/2];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];
        if(type == ArrFlightHour){
            passengerTtitle.text = @"进港航班小时分布";
        }else{
            passengerTtitle.text = @"出港航班小时分布";
        }


        UIImageView *planImageView = [[UIImageView alloc]initWithFrame:CGRectMake(16, viewBotton(passengerTtitle)+ px_px_2_3(16, 28), 10, 10)];
        planImageView.image = [UIImage imageNamed:@"FlightHourChartTag"];
        [topBgView addSubview:planImageView];
        UIImageView *inPlanImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"FlightHourChartTag3"]];
        inPlanImageView.center = planImageView.center;
        [topBgView addSubview:inPlanImageView];

        UILabel *planLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(planImageView)+2, viewY(planImageView)-1, 100, 11) text:@"实际航班数" font:13 textAlignment:NSTextAlignmentLeft colorFromHex:0xB5FEFEFE];
        [topBgView addSubview:planLabel];


        UIImageView *realImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(planLabel), viewY(planImageView)-3, 5, 14)];
        realImageView.image = [UIImage imageNamed:@"FlightHourChartTag2"];
        [topBgView addSubview:realImageView];
        UILabel *realLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(realImageView)+2, viewY(planLabel) , 100, 11) text:@"计划航班数" font:13 textAlignment:NSTextAlignmentLeft colorFromHex:0xB5FEFEFE];
        [topBgView addSubview:realLabel];
        
        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(planImageView),viewBotton(planLabel)+8, viewWidth(topBgView)-32, 0.5)];
        lineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:lineImageView];
        
        UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(20, viewBotton(lineImageView)+4, topBgView.frame.size.width-40, 12) text:@"100" font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF];
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
        
        
        
        barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(20, 5+23+15+2, topBgView.frame.size.width-40, topBgView.frame.size.height-(5+23+15+2)-5)];//折线图
        
        barChart.yMaxValue = 100;
        barChart.yMinValue = 0;
        barChart.showXLabel = NO;
        barChart.showYLabel = NO;
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

        
        if(type==DepFlightHour){

            UIImageView *redLine = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(planImageView), viewY(barChart)+viewHeight(barChart)/2, viewWidth(lineImageView), 15)];
            redLine.image = [UIImage imageNamed:@"HourRedLine"];
            [topBgView addSubview:redLine];
        }
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, topBgView.frame.size.height-(10+15+12), topBgView.frame.size.width-40, 12) text:@"0" font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF]];

        UIImageView *downLineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(planImageView),viewHeight(topBgView)-10-15, viewWidth(topBgView)-32, 0.5)];
        downLineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:downLineImageView];

        
        //小时分布表格
        UITableView *flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, viewBotton(topBgView), kScreenWidth, kScreenHeight-10-(65+viewBotton(topBgView)+40+5))];
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
    return px2(108);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [hourArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlightHourModel *flightHour = hourArray[indexPath.row];
    FlightHourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flightHour.hour];
    
    if (!cell) {
        cell = [[FlightHourTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:flightHour.hour flightHour:flightHour type:_flightHourType];
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
