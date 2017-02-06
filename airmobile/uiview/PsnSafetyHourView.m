//
//  PsnSafetyHourView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/27.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PsnSafetyHourView.h"
#import "PNMixLineChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"
#import "FlightHourModel.h"
#import "FlightHourTableViewCell.h"
#import "HomePageService.h"

@interface PsnSafetyHourView ()



@end

@implementation PsnSafetyHourView
{
    PNMixLineChart *lineChart;
    NSArray<FlightHourModel *> *hourArray;
    UITableView *flightHourTableView;
    UILabel *maxLabel;
    UILabel *ratioNum;
}

-(instancetype) initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if(self){

        hourArray = [HomePageService sharedHomePageService].psnModel.psnHours ;

        CGFloat topBgViewWidth = kScreenWidth-2*px2(22);
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(10,
                                                                     0,
                                                                     topBgViewWidth,
                                                                     topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView   = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                             0,
                                                                                             viewWidth(topBgView),
                                                                                             viewHeight(topBgView))];
        topBgBackgroundImageView.image          = [UIImage imageNamed:@"PsnSafetyHourTopBackground"];
        [topBgView addSubview:topBgBackgroundImageView];

        UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(15,
                                                                             7,
                                                                             viewWidth(topBgView)-100,
                                                                             13)];
        passengerTtitle.text        = @"隔离区内旅客时间分布";
        passengerTtitle.font        = [UIFont fontWithName:@"PingFangSC-Regular" size:27/2];
        passengerTtitle.textColor   = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];

        int index = (int)[CommonFunction currentHour];
         FlightHourModel *flightHourModel =[[FlightHourModel alloc]init];
        if (hourArray.count-1>=index) {
            flightHourModel =hourArray[index];

        }
        ratioNum = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width-150,
                                                                     10,
                                                                     130,
                                                                     18)
                                                     text:[NSString stringWithFormat:@"%ld预测",flightHourModel.planDepCount+flightHourModel.planArrCount]
                                                     font:20
                                            textAlignment:NSTextAlignmentRight colorFromHex:0xFFFFFFFF];
        ratioNum.font = [UIFont fontWithName:@"PingFang SC"
                                        size:px2(48)];

        NSMutableAttributedString *valueAttributedString = [[NSMutableAttributedString alloc]initWithString:ratioNum.text];
        [valueAttributedString addAttribute:NSFontAttributeName
                                      value:[UIFont fontWithName:@"PingFangSC-Regular" size:13]
                                      range:[ratioNum.text rangeOfString:@"预测"]];


        //        valueLable1.backgroundColor = [UIColor redColor];
        ratioNum.attributedText = valueAttributedString;

        [topBgView addSubview:ratioNum];

        UIImageView *planImageView = [[UIImageView alloc]initWithFrame:CGRectMake(17,
                                                                                  viewBotton(passengerTtitle)+ 8,
                                                                                  11,
                                                                                  11)];
        planImageView.image = [UIImage imageNamed:@"PsnSafetyHourChartTag1"];
        [topBgView addSubview:planImageView];
        UILabel *planLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(planImageView)+2,
                                                                      viewY(planImageView),
                                                                      100,
                                                                      11)
                                                      text:@"人数"
                                                      font:27/2
                                             textAlignment:NSTextAlignmentLeft
                                              colorFromHex:0xB5FFFFFF];
        [topBgView addSubview:planLabel];


        UIImageView *upImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px2(34),
                                                                                viewBotton(planLabel)+px2(8),
                                                                                viewWidth(topBgView)-2*px2(34),
                                                                                px2(2))];
        upImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:upImageView];

        maxLabel = [CommonFunction addLabelFrame:CGRectMake(20,
                                                                     viewBotton(upImageView)+px2(8),
                                                                     topBgView.frame.size.width-40, 12)
                                                     text:@([self chartMaxValue]).stringValue
                                                     font:11
                                            textAlignment:NSTextAlignmentRight
                                             colorFromHex:0x75FFFFFF];
        [topBgView addSubview:maxLabel];
        
        // 计划的折线图
        lineChart = [[PNMixLineChart alloc] initWithFrame:CGRectMake(20,
                                                                  5+23+15+2,
                                                                  topBgView.frame.size.width-40,
                                                                  topBgView.frame.size.height-(5+23+15+2)-5)];
        lineChart.backgroundColor   = [UIColor clearColor];
        lineChart.skipXPoints       = 1;
        lineChart.showCoordinateAxis= NO;
        lineChart.showGenYLabels    = NO;
        lineChart.yFixedValueMax    = [self chartMaxValue];
        lineChart.yFixedValueMin    = -([self chartMaxValue]*0.05);
        [lineChart setXLabels:[self getFlightHourXLabels]];
        lineChart.changeNum = [CommonFunction currentHour];
        // added an examle to show how yGridLines can be enabled
        // the color is set to clearColor so that the demo remains the same
        lineChart.yGridLinesColor   = [UIColor yellowColor];
        // Line Chart #2
        NSArray * dataArray         = [self getFlightHourYLabels];
        PNLineChartData *data       = [PNLineChartData new];
        data.dataTitle              = @"航班";
        data.color                  = [UIColor whiteColor];
        data.alpha                  = 0.5f;
//        data.inflexionPointWidth    = 2.0f;
        data.itemCount              = dataArray.count;
        data.inflexionPointStyle    = PNLineChartPointStyleCircle;
        data.getData = ^(NSUInteger index) {
            CGFloat yValue = [dataArray[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        lineChart.chartData = @[data];
        
        [lineChart strokeChart];
        [topBgView addSubview:lineChart];
        
        UILabel *zoreLabel  = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth(topBgView)-6-px2(31),
                                                                      topBgView.frame.size.height-(10+13+12+2)-5,
                                                                      topBgView.frame.size.width-40,
                                                                      10)];
        zoreLabel.text      = @"0";
        zoreLabel.font      = [UIFont fontWithName:@"PingFang SC" size:px2(22)];
        zoreLabel.textColor = [CommonFunction colorFromHex:0X75ffffff];
        [topBgView addSubview:zoreLabel];

        UIImageView *lowImageView   = [[UIImageView alloc]initWithFrame:CGRectMake(px2(31),
                                                                                   topBgView.frame.size.height-10-13-7,
                                                                                   viewWidth(topBgView)-2*px2(31),
                                                                                   px2(2))];
        lowImageView.image          = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:lowImageView];
        
        //小时分布表格
        flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                                        viewBotton(topBgView)+5,
                                                                                        kScreenWidth,
                                                                                        kScreenHeight-65-viewBotton(topBgView)-5-37)];
        flightHourTableView.delegate        = self;
        flightHourTableView.dataSource      = self;
        flightHourTableView.backgroundColor = [UIColor whiteColor];
        flightHourTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        flightHourTableView.showsVerticalScrollIndicator = NO;
        [self addSubview:flightHourTableView];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadData:)
                                                     name:@"SafetyPsnHours"
                                                   object:nil];
        
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"SafetyPsnHours"
                                                  object:nil];
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
        cell = [[FlightHourTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault)
                                             reuseIdentifier:flightHour.hour flightHour:flightHour];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSArray *) getFlightHourXLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(FlightHourModel *model in hourArray){
        if (model.hour) {
            [arr addObject:[model.hour componentsSeparatedByString:@":"][0]];
        }else{
            [arr addObject:@""];
        }

    }
    return arr;
}

-(NSArray *) getFlightHourYLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(FlightHourModel *model in hourArray){
        [arr addObject:@((int)(model.planDepCount+model.planArrCount))];
    }
    return arr;
}

-(NSArray *) getPlanYLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(FlightHourModel *model in hourArray){
        [arr addObject:@((int)(model.planDepCount+model.planArrCount))];
    }
    return arr;
}
-(NSInteger)sum
{
    NSInteger s = 0;
    for (FlightHourModel *model in hourArray) {
        s +=model.planDepCount;
    }
    return s;
}

-(NSInteger)maxValue
{
    NSInteger max = 0;
    for (FlightHourModel *model in hourArray) {
        if ( model.planDepCount+model.planArrCount>max) {
            max = model.planDepCount+model.planArrCount;
        }
    }
    return max;
}
-(NSInteger)chartMaxValue
{
    NSInteger max = [self maxValue]*1.2;
    return  max/10*10;
}

-(void)loadData:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[NSArray class]]) {
        hourArray = [HomePageService sharedHomePageService].psnModel.psnHours ;

        [flightHourTableView reloadData];

        [lineChart setXLabels:[self getFlightHourXLabels]];

        // Line Chart #2
        NSArray * dataArray         = [self getFlightHourYLabels];
        PNLineChartData *data       = [PNLineChartData new];
        data.dataTitle              = @"航班";
        data.color                  = [UIColor whiteColor];
        data.alpha                  = 0.5f;
        data.inflexionPointWidth    = 2.0f;
        data.itemCount              = dataArray.count;
        data.inflexionPointStyle    = PNLineChartPointStyleCircle;
        data.getData = ^(NSUInteger index) {
            CGFloat yValue = [dataArray[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };

        lineChart.chartData = @[data];

        [lineChart strokeChart];
        maxLabel.text = @([self chartMaxValue]).stringValue;

        int index = (int)[CommonFunction currentHour];
        FlightHourModel *flightHourModel =[[FlightHourModel alloc]init];
        if (hourArray.count-1>=index) {
            flightHourModel =hourArray[index];

        }
        ratioNum.text = [NSString stringWithFormat:@"%ld预测",flightHourModel.planDepCount+flightHourModel.planArrCount];
    }

}



@end
