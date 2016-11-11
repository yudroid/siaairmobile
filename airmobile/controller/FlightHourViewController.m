//
//  FlightHourViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightHourViewController.h"
#import "PNLineChart.h"
#import "FlightHourModel.h"
#import "FlightHourTableViewCell.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"

@interface FlightHourViewController ()

@end

@implementation FlightHourViewController
{
    PNLineChart *lineChart;
    NSMutableArray<FlightHourModel *> *eightMonthArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initTitle];
    
    [self initData];

    CGFloat y = 64+px2(33);
    
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(px2(22), y, kScreenWidth-2*px2(22), 200)];
    [self.view addSubview:topBgView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = topBgView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[CommonFunction colorFromHex:0XFF17B9E8] CGColor], (id)[[CommonFunction colorFromHex:0XFF5684FB] CGColor], nil];
    [topBgView.layer insertSublayer:gradient atIndex:0];
    [topBgView.layer setCornerRadius:8.0];// 将图层的边框设置为圆脚
    [topBgView.layer setMasksToBounds:YES];// 隐藏边界
    
    UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(px2(33), 5, topBgView.frame.size.width-100, 23)];
    passengerTtitle.text = @"航班小时分布图";
    passengerTtitle.font = [UIFont fontWithName:@"PingFang SC" size:px2(27)];
    passengerTtitle.textColor = [UIColor whiteColor];
    [topBgView addSubview:passengerTtitle];
    
    UILabel *ratioNum = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width-100, 5, 80, 23+20) text:@"800" font:20 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
    ratioNum.font = [UIFont fontWithName:@"PingFang SC" size:px2(48)];

    [topBgView addSubview:ratioNum];


    
    UILabel *todayLabel = [CommonFunction addLabelFrame:CGRectMake(px2(33), 5+20 , 200, 20) text:@"航班数" font:14 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF];
    todayLabel.font = [UIFont fontWithName:@"PingFang SC" size:px2(27)];
    [topBgView addSubview:todayLabel];
    

    UIImageView *upImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px2(33), viewY(todayLabel)+viewHeight(todayLabel)+px2(5), viewWidth(topBgView)-2*px2(33), px2(2))];
    upImageView.image = [UIImage imageNamed:@"upLine"];
    [topBgView addSubview:upImageView];
    
    UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(20, 5+23+23+2, topBgView.frame.size.width-40, 12) text:@"100" font:12 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
    [topBgView addSubview:maxLabel];
    
    
    
    lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 5+23+23+2, topBgView.frame.size.width-40, topBgView.frame.size.height-(5+23+23+2)-5)];
    lineChart.backgroundColor = [UIColor clearColor];
    lineChart.skipXPoints = 1;
    [lineChart setXLabels:[self getFlightHourXLabels]];
    lineChart.showCoordinateAxis = NO;
    lineChart.showGenYLabels=NO;
    
    // added an examle to show how yGridLines can be enabled
    // the color is set to clearColor so that the demo remains the same
    lineChart.yGridLinesColor = [UIColor clearColor];
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    lineChart.yFixedValueMax = 100;
    lineChart.yFixedValueMin = 0;
    
    
    // Line Chart #2
    NSArray * dataArray = [self getFlightHourYLabels];
    PNLineChartData *data = [PNLineChartData new];
    data.dataTitle = @"航班";
    data.color = [UIColor whiteColor];
    data.alpha = 0.5f;
    data.itemCount = dataArray.count;
    data.inflexionPointStyle = PNLineChartPointStyleCircle;
    data.getData = ^(NSUInteger index) {
        CGFloat yValue = [dataArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data];
    [lineChart strokeChart];
    [topBgView addSubview:lineChart];


    UILabel *zoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth(topBgView)-6-px2(31), topBgView.frame.size.height-(10+15+12), topBgView.frame.size.width-40, 10)];
    zoreLabel.text = @"0";
    zoreLabel.font = [UIFont fontWithName:@"PingFang SC" size:px2(22)];
    zoreLabel.textColor = [CommonFunction colorFromHex:0X75ffffff];
    [topBgView addSubview:zoreLabel];



    UIImageView *lowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px2(31), topBgView.frame.size.height-10-15, viewWidth(topBgView)-2*px2(31), px2(2))];
    lowImageView.image = [UIImage imageNamed:@"upLine"];
    [topBgView addSubview:lowImageView];

    y =viewHeight(topBgView)+viewY(topBgView)+px2(10);
    //小时分布表格
    UITableView *flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, kScreenHeight-y)];
    flightHourTableView.delegate = self;
    flightHourTableView.dataSource = self;
    flightHourTableView.showsVerticalScrollIndicator = NO;
    flightHourTableView.backgroundColor = [UIColor whiteColor];
    flightHourTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:flightHourTableView];

}

-(void)initTitle
{
    [self titleViewInitWithHight:64];
    [self titleViewAddTitleText:@"航班小时分布图"];
    
    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 65)];
    self.titleView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];
    
    [self titleViewAddBackBtn];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return px2(108);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [eightMonthArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlightHourModel *flightHour = eightMonthArray[indexPath.row];
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
    for(FlightHourModel *model in eightMonthArray){
        [arr addObject:[model.hour componentsSeparatedByString:@":"][0]];
    }
    return arr;
}

-(NSArray *) getFlightHourYLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(FlightHourModel *model in eightMonthArray){
        [arr addObject:@((int)(model.count))];
    }
    return arr;
}

-(void) initData
{
    if(eightMonthArray == nil){
        eightMonthArray = [[NSMutableArray alloc] init];
    }else{
        [eightMonthArray removeAllObjects];
    }
    
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"1:00" count:25]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"2:00" count:35]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"3:00" count:15]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"4:00" count:10]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"5:00" count:25]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"6:00" count:35]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"7:00" count:45]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"8:00" count:65]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"9:00" count:70]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"10:00" count:48]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"11:00" count:62]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"12:00" count:45]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"13:00" count:55]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"14:00" count:60]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"15:00" count:75]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"16:00" count:60]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"17:00" count:45]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"18:00" count:35]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"19:00" count:45]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"20:00" count:25]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"21:00" count:20]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"22:00" count:25]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"23:00" count:30]];
    [eightMonthArray addObject:[[FlightHourModel alloc] initWithHour:@"00:00" count:15]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
