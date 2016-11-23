//
//  PassengerHourViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PassengerHourViewController.h"
#import "PNLineChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"
#import "FlightHourModel.h"
#import "PsnHourTableViewCell.h"

@interface PassengerHourViewController ()

@end

@implementation PassengerHourViewController

{
    PNLineChart *arrLineChart;
    NSMutableArray<FlightHourModel *> *hourArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initTitle];
    
    [self initData];
    
    CGFloat topBgViewWidth = kScreenWidth-2*px2(22);
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 65+px_px_2_3(24, 50), topBgViewWidth, topBgViewWidth *391/709)];
    [self.view addSubview:topBgView];

    UIImageView *topBgBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(topBgView), viewHeight(topBgView))];
    topBgBackgroundImageView.image = [UIImage imageNamed:@"PsnGeneralChartBackground"];
    [topBgView addSubview:topBgBackgroundImageView];

    UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, viewWidth(topBgView)-100, 11)];
    passengerTtitle.text = @"旅客小时分布";
    passengerTtitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:27/2];
    passengerTtitle.textColor = [UIColor whiteColor];
    [topBgView addSubview:passengerTtitle];

    UIView *prTitleView = [[UIView alloc] initWithFrame:CGRectMake(16, viewBotton(passengerTtitle)+px_px_2_3(12, 18), 120, 12)];
    [topBgView addSubview:prTitleView];

    UIImageView *planImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, 10, 10)];
    planImageView.image = [UIImage imageNamed:@"PsnGeneralChartTag_1"];
    [prTitleView addSubview:planImageView];
    [prTitleView addSubview:[CommonFunction addLabelFrame:CGRectMake(viewTrailing(planImageView)+2, 0, 40, 12) text:@"计划" font:27/2 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF]];

    UIImageView *realImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(planImageView)+2+40+16, 2, 10, 10)];
    realImageView.image = [UIImage imageNamed:@"PsnGeneralChartTag_2"];
    [prTitleView addSubview:realImageView];
    [prTitleView addSubview:[CommonFunction addLabelFrame:CGRectMake(viewTrailing(realImageView)+2, 0, 40, 12) text:@"实际" font:27/2 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF]];

    UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle), viewBotton(prTitleView)+4, viewWidth(topBgView)-viewX(passengerTtitle)*2, 0.5)];
    lineImageView.image = [UIImage imageNamed:@"hiddenLine"];
    [topBgView addSubview:lineImageView];

    UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(viewWidth(topBgView)-18-50,viewBotton(lineImageView)+4, 50, 12) text:@"350" font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF];
    [topBgView addSubview:maxLabel];

    arrLineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(viewX(passengerTtitle), viewBotton(maxLabel), viewWidth(topBgView)-viewX(passengerTtitle)-18, viewHeight(topBgView)-viewBotton(maxLabel))];
    arrLineChart.backgroundColor = [UIColor clearColor];
    arrLineChart.skipXPoints = 1;
    [arrLineChart setXLabels:[self getFlightHourXLabels]];
    arrLineChart.showCoordinateAxis = NO;
    arrLineChart.showGenYLabels=NO;
    
    // added an examle to show how yGridLines can be enabled
    // the color is set to clearColor so that the demo remains the same
    arrLineChart.yGridLinesColor = [UIColor clearColor];
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    arrLineChart.yFixedValueMax = 400;
    arrLineChart.yFixedValueMin = 0;
    
    
    // Line Chart #1
    NSArray * arrArray = [self getFlightHourYLabels];
    PNLineChartData *data = [PNLineChartData new];
    data.dataTitle = @"航班";
    data.color = [UIColor greenColor];
    data.alpha = 0.5f;
    data.itemCount = arrArray.count;
    data.inflexionPointStyle = PNLineChartPointStyleCircle;
    data.getData = ^(NSUInteger index) {
        CGFloat yValue = [arrArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // Line Chart #2
    NSArray * depArray = [self getFlightHourLabels];
    PNLineChartData *data2 = [PNLineChartData new];
    data2.dataTitle = @"航班";
    data2.color = [UIColor yellowColor];
    data2.alpha = 0.5f;
    data2.itemCount = depArray.count;
    data2.inflexionPointStyle = PNLineChartPointStyleCircle;
    data2.getData = ^(NSUInteger index) {
        CGFloat yValue = [depArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    arrLineChart.chartData = @[data,data2];
    [arrLineChart strokeChart];
    [topBgView addSubview:arrLineChart];
    
    UIImageView *downlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle), topBgView.frame.size.height-10-15, viewWidth(topBgView)-viewX(passengerTtitle)-18, 0.5)];
    downlineImageView.image = [UIImage imageNamed:@"hiddenLine"];
    [topBgView addSubview:downlineImageView];

    [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, viewY(downlineImageView)-13-4, topBgView.frame.size.width-40, 13) text:@"0" font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF]];

    //小时分布表格
    UITableView *flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, viewBotton(topBgView)+8, kScreenWidth, kScreenHeight-viewBotton(topBgView)-10)];
    flightHourTableView.delegate = self;
    flightHourTableView.dataSource = self;
    flightHourTableView.showsVerticalScrollIndicator = NO;
    flightHourTableView.backgroundColor = [UIColor whiteColor];
    flightHourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:flightHourTableView];
    
}

-(void)initTitle
{
    [self titleViewInitWithHight:65];
    [self titleViewAddTitleText:@"旅客小时分布"];
    
    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 65)];
    self.titleView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];
    
    [self titleViewAddBackBtn];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 41;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [hourArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlightHourModel *flightHour = hourArray[indexPath.row];
    PsnHourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flightHour.hour];
    
    if (!cell) {
        cell = [[PsnHourTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:flightHour.hour flightHour:flightHour];
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
        [arr addObject:@((int)(model.arrCount))];
    }
    return arr;
}

-(NSArray *) getFlightHourLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(FlightHourModel *model in hourArray){
        [arr addObject:@((int)(model.depCount))];
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
    
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"1:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"2:00" count:0 planCount:0 arrCount:260 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"3:00" count:0 planCount:0 arrCount:241 planArrCount:250 depCount:210 planDepCount:210 before:YES]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"4:00" count:0 planCount:0 arrCount:264 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"5:00" count:0 planCount:0 arrCount:281 planArrCount:250 depCount:260 planDepCount:178 before:YES]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"6:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"7:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"8:00" count:0 planCount:0 arrCount:231 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"9:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:230 before:YES]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"10:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"11:00" count:0 planCount:0 arrCount:150 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"12:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:YES]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"13:00" count:0 planCount:0 arrCount:170 planArrCount:250 depCount:220 planDepCount:220 before:YES]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"14:00" count:0 planCount:0 arrCount:270 planArrCount:250 depCount:280 planDepCount:240 before:NO]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"15:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:NO]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"16:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:350 before:NO]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"17:00" count:0 planCount:0 arrCount:260 planArrCount:250 depCount:350 planDepCount:350 before:NO]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"18:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:350 planDepCount:260 before:NO]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"19:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:213 before:NO]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"20:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:245 before:NO]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"21:00" count:0 planCount:0 arrCount:230 planArrCount:254 depCount:260 planDepCount:260 before:NO]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"22:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:NO]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"23:00" count:0 planCount:0 arrCount:280 planArrCount:250 depCount:260 planDepCount:206 before:NO]];
    [hourArray addObject:[[FlightHourModel alloc] initWithHour:@"00:00" count:0 planCount:0 arrCount:250 planArrCount:250 depCount:260 planDepCount:260 before:NO]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
