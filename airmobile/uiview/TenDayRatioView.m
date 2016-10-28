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
        
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth-40, 200)];
        [self addSubview:topBgView];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = topBgView.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[CommonFunction colorFromHex:0XFF17B9E8] CGColor], (id)[[CommonFunction colorFromHex:0XFF5684FB] CGColor], nil];
        [topBgView.layer insertSublayer:gradient atIndex:0];
        [topBgView.layer setCornerRadius:8.0];// 将图层的边框设置为圆脚
        [topBgView.layer setMasksToBounds:YES];// 隐藏边界
        
        UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, topBgView.frame.size.width-100, 20)];
        passengerTtitle.text = @"平均放行正常率";
        passengerTtitle.font = [UIFont systemFontOfSize:17];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];
        
        UILabel *ratioNum = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width-100, 5, 80, 23) text:@"86%" font:20 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:ratioNum];
        
        UILabel *todayLabel = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width-120, 5+ 23 , 100, 23) text:[NSString stringWithFormat:@"今日 %@",[CommonFunction dateFormat:nil format:@"mm月dd日"]] font:14 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:todayLabel];

        
        [topBgView addSubview:[CommonFunction addLine:CGRectMake(20, 5+23+23, topBgView.frame.size.width-40, 1) color:[CommonFunction colorFromHex:0XFF3FDFB7]]];
        
        UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(20, 5+23+23+2, topBgView.frame.size.width-40, 12) text:@"100" font:12 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:maxLabel];
        
        barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(20, 5+23+23+2, topBgView.frame.size.width-40, topBgView.frame.size.height-(5+23+23+2)-5)];//折线图
      
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

        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, topBgView.frame.size.height-(10+15+12), topBgView.frame.size.width-40, 12) text:@"0" font:12 textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF]];
        
        [topBgView addSubview:[CommonFunction addLine:CGRectMake(20, topBgView.frame.size.height-10-15, topBgView.frame.size.width-40, 1) color:[CommonFunction colorFromHex:0XFF3FDFB7]]];
        
        //小时分布表格
        UITableView *tenDayTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 10+200+20, kScreenWidth-40, kScreenHeight-10-200-20)];
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
    return 30;
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
