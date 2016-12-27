//
//  FlightHourView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightHourView.h"
#import "PNMixLineChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"

@implementation FlightHourView
{
    PNMixLineChart *lineChart;
    NSArray<FlightHourModel *> *hourArray;
    FlightHourType _flightHourType;
    PNBarChart *barChart;
}

-(instancetype) initWithFrame:(CGRect)frame
                    DataArray:(NSArray<FlightHourModel *> *)dataArray
               flightHourType:(FlightHourType) type
{
    self = [super initWithFrame:frame];
    if(self){
        
        _flightHourType         = type;
        hourArray               = dataArray;

        CGFloat topBgViewWidth  = kScreenWidth-2*px2(22);
        UIView *topBgView       = [[UIView alloc] initWithFrame:CGRectMake(10,
                                                                     0,
                                                                     topBgViewWidth,
                                                                     topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                             0,
                                                                                             viewWidth(topBgView),
                                                                                             viewHeight(topBgView))];
        topBgBackgroundImageView.image      = [UIImage imageNamed:@"FlightHourChartBlackground"];
        [topBgView addSubview:topBgBackgroundImageView];
        
        UILabel *passengerTtitle    = [[UILabel alloc] initWithFrame:CGRectMake(px_px_2_3(32, 73),
                                                                             px_px_2_3(10, 24) ,
                                                                             viewWidth(topBgView)-100,
                                                                             13)];
        passengerTtitle.font        = [UIFont fontWithName:@"PingFangSC-Regular"
                                               size:27/2];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];
        if(type == ArrFlightHour){
            passengerTtitle.text = @"进港航班小时分布";
        }else{
            passengerTtitle.text = @"出港航班小时分布";
        }

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
                                                      text:@"实际航班数"
                                                      font:13
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
                                                      text:@"计划航班数"
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
        
        UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(20,
                                                                     viewBotton(lineImageView)+4,
                                                                     topBgView.frame.size.width-40, 12)
                                                     text:[NSString stringWithFormat:@"%d",(int)([self maxValue]*1.2)]
                                                     font:11
                                            textAlignment:NSTextAlignmentRight
                                             colorFromHex:0x75FFFFFF];
        [topBgView addSubview:maxLabel];
        
        
        // 计划的折线图
        lineChart = [[PNMixLineChart alloc] initWithFrame:CGRectMake(20+1.5,
                                                                  5+23+15+2,
                                                                  topBgView.frame.size.width-40,
                                                                  topBgView.frame.size.height-(5+23+15+2)-5)];
        lineChart.backgroundColor   = [UIColor clearColor];
        lineChart.skipXPoints       = 1;
        [lineChart setXLabels:[self getFlightHourXLabels]];
        lineChart.showCoordinateAxis= NO;
        lineChart.showGenYLabels    =NO;
        lineChart.yFixedValueMax    = [self maxValue]*1.2;
        lineChart.yFixedValueMin    = -[self maxValue]*0.1;



        lineChart.changeNum = [CommonFunction currentHour]-1;
        
        // added an examle to show how yGridLines can be enabled
        // the color is set to clearColor so that the demo remains the same
        lineChart.yGridLinesColor = [UIColor yellowColor];
        
        
        // Line Chart #2
        NSArray * dataArray     = [self getFlightHourYLabels];
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
        barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(20,
                                                                5+23+15+2,
                                                                topBgView.frame.size.width-40,
                                                                topBgView.frame.size.height-(5+23+15+2)-5)];
        
        barChart.yMaxValue          = [self maxValue]*1.2;
        barChart.yMinValue          = 0;
        barChart.showXLabel         = NO;
        barChart.showYLabel         = NO;
        barChart.backgroundColor    = [UIColor clearColor];

        barChart.yChartLabelWidth   = 20.0;
        barChart.labelTextColor     = [CommonFunction colorFromHex:0xFFFFFFFF];


        barChart.labelMarginTop     = 5.0;
        barChart.showChartBorder    = NO;
        barChart.barRadius          = 2.0f;
        barChart.chartMarginBottom  = 5.0f;
        [barChart setXLabels:[self getFlightHourXLabels]];
        [barChart setYValues:[self getPlanYLabels]];
        
        barChart.isGradientShow     = YES;
        barChart.isShowNumbers      = NO;
        barChart.barBackgroundColor = [UIColor clearColor];
//        barChart.strokeColor = [CommonFunction colorFromHex:0xff6AF9DF];
        NSMutableArray *colors = [NSMutableArray array];
        NSInteger num = [self getFlightHourXLabels].count;
        for (int i = 0; i<num; i++) {
            if (i<[CommonFunction currentHour]) {
                [colors addObject:[CommonFunction colorFromHex:0xff6AF9DF]];
            }else{
                [colors addObject:[CommonFunction colorFromHex:0xffB0C4DE]];
            }
        }
        barChart.strokeColors = [colors copy];
        [barChart strokeChart];

        
        [topBgView addSubview:barChart];
        [topBgView addSubview:lineChart];

        
//        if(type==DepFlightHour){
//
//            UIImageView *redLine = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(planImageView), viewY(barChart)+viewHeight(barChart)/2, viewWidth(lineImageView), 15)];
//            redLine.image = [UIImage imageNamed:@"HourRedLine"];
//            [topBgView addSubview:redLine];
//        }
        
        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20,
                                                                       topBgView.frame.size.height-(10+15+12)-5,
                                                                       topBgView.frame.size.width-40,
                                                                       12)
                                                       text:@"0"
                                                       font:11
                                              textAlignment:NSTextAlignmentRight
                                               colorFromHex:0x75FFFFFF]];

        UIImageView *downLineImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(planImageView),
                                                                                      viewHeight(topBgView)-10-15-5,
                                                                                      viewWidth(topBgView)-32,
                                                                                      0.5)];
        downLineImageView.image         = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:downLineImageView];

        
        //小时分布表格
        UITableView *flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                                        viewBotton(topBgView),
                                                                                        kScreenWidth,
                                                                                        kScreenHeight-10-(65+viewBotton(topBgView)+40+5))];
        flightHourTableView.delegate                        = self;
        flightHourTableView.dataSource                      = self;
        flightHourTableView.showsVerticalScrollIndicator    = NO;
        flightHourTableView.backgroundColor = [UIColor whiteColor];
        flightHourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:flightHourTableView];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadData:)
                                                     name:@"PlanArrHours"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadData:)
                                                     name:@"RealArrHours"
                                                   object:nil];
        
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"PlanArrHours" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"RealArrHours" object:nil];
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
        cell = [[FlightHourTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault)
                                             reuseIdentifier:flightHour.hour
                                                  flightHour:flightHour
                                                        type:_flightHourType];
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
        if (_flightHourType ==ArrFlightHour) {
            [arr addObject:@(model.arrCount)];
        }else if(_flightHourType ==DepFlightHour){
        [arr addObject:@((int)(model.depCount))];
        }
    }
    return arr;
}

-(NSArray *) getPlanYLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(FlightHourModel *model in hourArray){
        if (_flightHourType ==ArrFlightHour) {
            [arr addObject:@(model.planArrCount)];
        }else if(_flightHourType ==DepFlightHour){
            [arr addObject:@((int)(model.planDepCount))];
        }
//        [arr addObject:@((int)(model.planCount))];
    }
    return arr;
}

-(void)loadData:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[NSArray class]]) {
        if([notification.name isEqualToString:@"PlanArrHours"]){

        }else if ([notification.name isEqualToString:@"RealArrHours"]){

        }

    }

}

-(NSInteger)maxValue
{
    NSInteger max = 0;
    if (_flightHourType ==ArrFlightHour) {
        for (FlightHourModel *model in hourArray) {
            if (model.arrCount>max) {
                max = model.arrCount;
            }
            if (model.planArrCount>max) {
                max = model.planArrCount;
            }
        }

    }else if(_flightHourType ==DepFlightHour){
        for (FlightHourModel *model in hourArray) {
            if (model.depCount>max) {
                max = model.depCount;
            }
            if (model.planDepCount>max) {
                max = model.planDepCount;
            }
        }
    }
    return max==0?1:max;
}





@end
