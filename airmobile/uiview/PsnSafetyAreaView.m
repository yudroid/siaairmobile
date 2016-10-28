//
//  PsnSafetyAreaView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/27.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PsnSafetyAreaView.h"
#import "PNBarChart.h"
#import "PassengerAreaModel.h"
#import "FlightHourTableViewCell.h"

@implementation PsnSafetyAreaView
{
    NSMutableArray<PassengerAreaModel *> *farArray;
    NSMutableArray<PassengerAreaModel *> *nearArray;
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
        passengerTtitle.text = @"隔离区旅客区域分布";

        passengerTtitle.font = [UIFont systemFontOfSize:18];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];
        
        UILabel *planLabel = [CommonFunction addLabelFrame:CGRectMake(20, 5+23 , 100, 15) text:@"近机位" font:15 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:planLabel];
        
        UILabel *realLabel = [CommonFunction addLabelFrame:CGRectMake(20+100, 5+23 , 100, 15) text:@"远机位" font:15 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:realLabel];
        
        
        [topBgView addSubview:[CommonFunction addLine:CGRectMake(20, 5+23+15, topBgView.frame.size.width-40, 1) color:[CommonFunction colorFromHex:0XFF3FDFB7]]];
        
        UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(20, 5+23+15+2, topBgView.frame.size.width-40, 12) text:@"100" font:12 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:maxLabel];
        
        barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(20, 5+23+15+2, topBgView.frame.size.width-40, topBgView.frame.size.height-(5+23+15+2)-5)];//折线图
        
        barChart.yMaxValue = 100;
        barChart.yMinValue = 0;
        barChart.showXLabel = YES;
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
        [barChart setYValues:[self getFlightHourYLabels]];
        
        barChart.isGradientShow = YES;
        barChart.isShowNumbers = NO;
        barChart.barBackgroundColor = [UIColor clearColor];
        
        [barChart strokeChart];
        
        [topBgView addSubview:barChart];
        
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section ==0)
        return [nearArray count];
    else if(section ==1)
        return [farArray count];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PassengerAreaModel *flightHour = nil;
    
    if(indexPath.section==0){
        flightHour = nearArray[indexPath.row];
    }else{
        flightHour = farArray[indexPath.row];
    }
    FlightHourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flightHour.region];
    
    if (!cell) {
        cell = [[FlightHourTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) psnArea:flightHour];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0)
        return @"近机位登机口";
    return @"远机位登机口";
}

-(NSArray *) getFlightHourXLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(PassengerAreaModel *model in nearArray){
        [arr addObject:model.region];
    }
    for(PassengerAreaModel *model in farArray){
        [arr addObject:model.region];
    }
    return arr;
}

-(NSArray *) getFlightHourYLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(PassengerAreaModel *model in nearArray){
        [arr addObject:@((int)(model.count))];
    }
    
    for(PassengerAreaModel *model in farArray){
        [arr addObject:@((int)(model.count))];
    }
    return arr;
}

-(void) initData
{
    if(farArray == nil){
        farArray = [[NSMutableArray alloc] init];
    }else{
        [farArray removeAllObjects];
    }
    [farArray addObject:[[PassengerAreaModel alloc] initWithRegion:@"北指廊" count:2512 isFar:NO]];
    [farArray addObject:[[PassengerAreaModel alloc] initWithRegion:@"东北"  count:2055 isFar:NO]];
    [farArray addObject:[[PassengerAreaModel alloc] initWithRegion:@"西北"  count:2315 isFar:NO]];
    [farArray addObject:[[PassengerAreaModel alloc] initWithRegion:@"东南"  count:1985 isFar:NO]];
    [farArray addObject:[[PassengerAreaModel alloc] initWithRegion:@"西南"  count:1205 isFar:NO]];
    
    if(nearArray == nil){
        nearArray = [[NSMutableArray alloc] init];
    }else{
        [nearArray removeAllObjects];
    }
    [nearArray addObject:[[PassengerAreaModel alloc] initWithRegion:@"国内远"  count:2503 isFar:YES]];
    [nearArray addObject:[[PassengerAreaModel alloc] initWithRegion:@"国际远"  count:1025 isFar:YES]];
}


@end
