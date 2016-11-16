//
//  TenDayRatioView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "TenDayRatioView.h"
#import "PNBarChart.h"
#import "ReleasedRatioModel.h"
#import "RatioTableViewCell.h"

@implementation TenDayRatioView
{
    PNBarChart *barChart;
    NSMutableArray<ReleasedRatioModel *> *tenDayArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self){
        //        backgroundColor = [UIColor lightGrayColor];
        
        [self initData];

        CGFloat topBgViewWidth = kScreenWidth-2*px2(22);
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, topBgViewWidth, topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(topBgView), viewHeight(topBgView))];
        topBgBackgroundImageView.image = [UIImage imageNamed:@"TenDayRatioChartBackground"];
        [topBgView addSubview:topBgBackgroundImageView];
        
//        CAGradientLayer *gradient = [CAGradientLayer layer];
//        gradient.frame = topBgView.bounds;
//        gradient.colors = [NSArray arrayWithObjects:(id)[[CommonFunction colorFromHex:0XFF17B9E8] CGColor], (id)[[CommonFunction colorFromHex:0XFF5684FB] CGColor], nil];
//        [topBgView.layer insertSublayer:gradient atIndex:0];
//        [topBgView.layer setCornerRadius:8.0];// 将图层的边框设置为圆脚
        [topBgView.layer setMasksToBounds:YES];// 隐藏边界
        
        UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, viewWidth(topBgView)-100, 11)];
        passengerTtitle.text = @"平均放行正常率";
        passengerTtitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:27/2];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];
        
        UILabel *ratioNum = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width-100, 7.5, 80, 20) text:@"86%" font:24 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:ratioNum];


        
        UILabel *todayLabel = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width-140, viewHeight(ratioNum)+viewY(ratioNum) , 120, 20) text:[NSString stringWithFormat:@"今日 %@",[CommonFunction dateFormat:nil format:@"mm月dd日"]] font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF];
        [topBgView addSubview:todayLabel];

        UILabel *circleLabel= [CommonFunction addLabelFrame:CGRectMake(viewX(passengerTtitle), viewY(todayLabel), 20, 20) text:@"●" font:11 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:circleLabel];

        UILabel *ratioChar = [CommonFunction addLabelFrame:CGRectMake(viewX(passengerTtitle)+20, viewY(todayLabel), 80, 20) text:@"放行率" font:11 textAlignment:NSTextAlignmentLeft colorFromHex:0x75FFFFFF];
        [topBgView addSubview:ratioChar];


        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle), viewY(circleLabel)+viewHeight(circleLabel)+4, viewWidth(topBgView)-viewX(passengerTtitle)-18, 0.5)];
        lineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:lineImageView];


        UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(viewWidth(topBgView)-18-50,viewBotton(lineImageView)+4, 50, 12) text:@"100" font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF];
        [topBgView addSubview:maxLabel];
        
        barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(viewX(passengerTtitle), viewBotton(maxLabel), viewWidth(topBgView)-viewX(passengerTtitle)-18, viewHeight(topBgView)-viewBotton(maxLabel))];//折线图
      
        barChart.showXLabel = YES;
        barChart.showYLabel = NO;
        barChart.backgroundColor = [UIColor clearColor];

        barChart.yMaxValue = 100;
        barChart.yMinValue = 30;
        barChart.yChartLabelWidth = 20.0;
        barChart.chartMarginTop = 5.0;
        barChart.chartMarginBottom = 10.0;
        barChart.labelTextColor = [CommonFunction colorFromHex:0xFFFFFFFF];
        
        
        barChart.labelMarginTop = 5.0;
        barChart.showChartBorder = NO;
        barChart.barRadius = 6.0f;
        [barChart setXLabels:[self getXLabels]];
        [barChart setYValues:[self getYLabels]];
        
        barChart.isGradientShow = YES;
        barChart.isShowNumbers = NO;
        barChart.barBackgroundColor = [UIColor clearColor];
 
        [barChart strokeChart];
        [topBgView addSubview:barChart];


        UIImageView *downlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle), topBgView.frame.size.height-10-15, viewWidth(topBgView)-viewX(passengerTtitle)-18, 0.5)];
        downlineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:downlineImageView];

        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, viewY(downlineImageView)-13-4, topBgView.frame.size.width-40, 13) text:@"0" font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF]];

        //小时分布表格
        UITableView *tenDayTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, viewBotton(topBgView)+8, kScreenWidth, viewHeight(self)-viewBotton(topBgView)-8-10)];
        tenDayTableView.delegate = self;
        tenDayTableView.dataSource = self;
        tenDayTableView.showsVerticalScrollIndicator = NO;
        tenDayTableView.backgroundColor = [UIColor whiteColor];
        tenDayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tenDayTableView];
    }
    
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tenDayArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReleasedRatioModel *ratio = tenDayArray[indexPath.row];
    RatioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ratio.time];
    if (!cell) {
        cell = [[RatioTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ratio.time ratio:ratio];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSArray *) getXLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(ReleasedRatioModel *model in tenDayArray){
        [arr addObject:[model.time componentsSeparatedByString:@"-"][1]];
    }
    return arr;
}

-(NSArray *) getYLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(ReleasedRatioModel *model in tenDayArray){
        [arr addObject:@((int)(model.ratio*100))];
    }
    return arr;
}

-(void) initData
{
    if(tenDayArray == nil){
        tenDayArray = [[NSMutableArray alloc] init];
    }else{
        [tenDayArray removeAllObjects];
    }
        
    [tenDayArray addObject:[[ReleasedRatioModel alloc] initWithTime:@"08-11" ratio:0.75f]];
    [tenDayArray addObject:[[ReleasedRatioModel alloc] initWithTime:@"08-12" ratio:0.85f]];
    [tenDayArray addObject:[[ReleasedRatioModel alloc] initWithTime:@"08-13" ratio:0.75f]];
    [tenDayArray addObject:[[ReleasedRatioModel alloc] initWithTime:@"08-14" ratio:0.75f]];
    [tenDayArray addObject:[[ReleasedRatioModel alloc] initWithTime:@"08-15" ratio:0.72f]];
    [tenDayArray addObject:[[ReleasedRatioModel alloc] initWithTime:@"08-16" ratio:0.75f]];
    [tenDayArray addObject:[[ReleasedRatioModel alloc] initWithTime:@"08-17" ratio:0.75f]];
    [tenDayArray addObject:[[ReleasedRatioModel alloc] initWithTime:@"08-18" ratio:0.80f]];
    [tenDayArray addObject:[[ReleasedRatioModel alloc] initWithTime:@"08-19" ratio:0.75f]];
    [tenDayArray addObject:[[ReleasedRatioModel alloc] initWithTime:@"08-20" ratio:0.75f]];
}

@end
