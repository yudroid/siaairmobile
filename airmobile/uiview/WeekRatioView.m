//
//  WeekRatioView.m
//  airmobile
//
//  Created by xuesong on 2017/4/17.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "WeekRatioView.h"
#import "PNBarChart.h"
#import "ReleasedRatioModel.h"
#import "RatioTableViewCell.h"
#import "HomePageService.h"

@implementation WeekRatioView
{
    PNBarChart                              *barChart;
    NSArray<ReleasedRatioModel *>    *weekArray;
    UITableView                             *tenDayTableView;
    UILabel                                 *ratioNum;
    UILabel                                 *todayLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if(self){

        weekArray             = [[HomePageService sharedHomePageService].summaryModel.weekReleased copy];
        CGFloat topBgViewWidth  = kScreenWidth-2*px2(22);
        UIView *topBgView       = [[UIView alloc] initWithFrame:CGRectMake(10,
                                                                           0,
                                                                           topBgViewWidth,
                                                                           topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView   = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                               0,
                                                                                               viewWidth(topBgView),
                                                                                               viewHeight(topBgView))];
        topBgBackgroundImageView.image          = [UIImage imageNamed:@"TenDayRatioChartBackground"];
        [topBgView addSubview:topBgBackgroundImageView];


        UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(16,
                                                                             8,
                                                                             viewWidth(topBgView)-100,
                                                                             13)];
        passengerTtitle.text = @"本周放行率";
        passengerTtitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:27/2];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];

        ratioNum = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width-100,
                                                            7.5,
                                                            80,
                                                            20)
                                            text:@""
                                            font:24
                                   textAlignment:NSTextAlignmentRight
                                    colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:ratioNum];



        todayLabel = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width-140,
                                                              viewHeight(ratioNum)+viewY(ratioNum) ,
                                                              120,
                                                              20)
                                              text:@""
                                              font:11
                                     textAlignment:NSTextAlignmentRight
                                      colorFromHex:0x75FFFFFF];
        [topBgView addSubview:todayLabel];

        UILabel *circleLabel= [CommonFunction addLabelFrame:CGRectMake(viewX(passengerTtitle),
                                                                       viewY(todayLabel),
                                                                       20,
                                                                       20)
                                                       text:@"●"
                                                       font:11
                                              textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF];
        [topBgView addSubview:circleLabel];

        UILabel *ratioChar = [CommonFunction addLabelFrame:CGRectMake(viewX(passengerTtitle)+20,
                                                                      viewY(todayLabel),
                                                                      80,
                                                                      20)
                                                      text:@"放行率"
                                                      font:11
                                             textAlignment:NSTextAlignmentLeft
                                              colorFromHex:0x75FFFFFF];
        [topBgView addSubview:ratioChar];


        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle),
                                                                                  viewY(circleLabel)+viewHeight(circleLabel)+4,
                                                                                  viewWidth(topBgView)-viewX(passengerTtitle)-18,
                                                                                  0.5)];
        lineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:lineImageView];


        UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(viewWidth(topBgView)-18-50,
                                                                     viewBotton(lineImageView)+4,
                                                                     50,
                                                                     12)
                                                     text:@"100"
                                                     font:11
                                            textAlignment:NSTextAlignmentRight
                                             colorFromHex:0x75FFFFFF];
        [topBgView addSubview:maxLabel];

        barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(viewX(passengerTtitle),
                                                                viewBotton(lineImageView),
                                                                viewWidth(topBgView)-viewX(passengerTtitle)-18,
                                                                viewHeight(topBgView)-viewBotton(lineImageView)-5)];

        barChart.showXLabel = YES;
        barChart.showYLabel = NO;

        barChart.backgroundColor = [UIColor clearColor];

        barChart.yMaxValue = 100;
        barChart.yMinValue = 00;
        barChart.yChartLabelWidth = 20.0;
        barChart.chartMarginTop = 5.0;
        barChart.chartMarginBottom = 10.0;
        barChart.labelTextColor = [CommonFunction colorFromHex:0xFFFFFFFF];
//        barChart.xLabelSkip = 2;

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

        UIImageView *thresholdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(barChart), 2)];

        thresholdImageView.center = CGPointMake(barChart.center.x,
                                                viewBotton(barChart)-25 - [HomePageService sharedHomePageService].summaryModel.releaseRatioThreshold*100/barChart.yMaxValue*(viewHeight(barChart)-30));
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
                                                 viewBotton(barChart)-25 - [HomePageService sharedHomePageService].summaryModel.releaseRatioThreshold2*100/barChart.yMaxValue*(viewHeight(barChart)-30));
        thresholdImageView1.image = [UIImage imageNamed:@"thresholdLine"];

        [topBgView addSubview:thresholdImageView1];

        UILabel *thresholdLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(viewX(thresholdImageView1), viewBotton(thresholdImageView1),100, 10)];
        thresholdLabel1.text = [NSString stringWithFormat:@"%.0f%%",[HomePageService sharedHomePageService].summaryModel.releaseRatioThreshold2*100];
        thresholdLabel1.textColor = [UIColor redColor];
        thresholdLabel1.font = [UIFont systemFontOfSize:10];
        thresholdLabel1.textAlignment = NSTextAlignmentLeft;
        [topBgView addSubview:thresholdLabel1];

        UIImageView *downlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle),
                                                                                      viewBotton(barChart)-25,
                                                                                      viewWidth(topBgView)-viewX(passengerTtitle)-18,
                                                                                      0.5)];
        downlineImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:downlineImageView];

        [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, viewY(downlineImageView)-13-4, topBgView.frame.size.width-40, 13) text:@"0" font:11 textAlignment:NSTextAlignmentRight colorFromHex:0x75FFFFFF]];

        //小时分布表格
        tenDayTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, viewBotton(topBgView)+8, kScreenWidth, viewHeight(self)-viewBotton(topBgView)-8-10)];
        tenDayTableView.delegate = self;
        tenDayTableView.dataSource = self;
        tenDayTableView.showsVerticalScrollIndicator = NO;
        tenDayTableView.backgroundColor = [UIColor whiteColor];
        tenDayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tenDayTableView];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadData:)
                                                     name:@"FltFWR"
                                                   object:nil];
    }

    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"FltFWR"
                                                  object:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [weekArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReleasedRatioModel *ratio = weekArray[indexPath.row];
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
    for(ReleasedRatioModel *model in weekArray){
        [arr addObject:model.hour];
    }
    return arr;
}

-(NSArray *) getYLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(ReleasedRatioModel *model in weekArray){
        [arr addObject:@((int)(model.ratio*100))];
    }
    return arr;
}

-(CGFloat)sum
{
    CGFloat s = 0.0;
    for (ReleasedRatioModel *model in weekArray) {
        s +=model.ratio;
    }
    s = s/weekArray.count;
    return s;
}


-(void)loadData:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[NSArray class]]) {
        weekArray     = notification.object;
        [barChart setXLabels:[self getXLabels]];
        [barChart setYValues:[self getYLabels]];
        [barChart strokeChart];

        [tenDayTableView reloadData];
    }
    
    
}

@end

