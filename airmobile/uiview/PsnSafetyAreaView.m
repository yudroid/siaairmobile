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
    NSArray<PassengerAreaModel *>           *farArray;
    NSArray<PassengerAreaModel *>           *nearArray;
    PNBarChart                              *barChart;
    UITableView                             *flightHourTableView;
    UILabel                                 *maxLabel ;

}

-(instancetype) initWithFrame:(CGRect)    frame
                    nearArray:(NSArray *) _nearArray
                     farArray:(NSArray *) _farArray
{
    self = [super initWithFrame:frame];
    if(self){
        nearArray = [_nearArray copy];
        farArray = [_farArray copy];
        CGFloat topBgViewWidth = kScreenWidth-2*px2(22);
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(10,
                                                                     0,
                                                                     topBgViewWidth,
                                                                     topBgViewWidth *391/709)];
        [self addSubview:topBgView];

        UIImageView *topBgBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                             0,
                                                                                             viewWidth(topBgView),
                                                                                             viewHeight(topBgView))];
        topBgBackgroundImageView.image = [UIImage imageNamed:@"FlightHourChartBlackground"];
        [topBgView addSubview:topBgBackgroundImageView];


        UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(16,
                                                                             8,
                                                                             viewWidth(topBgView)-100,
                                                                             13)];
        passengerTtitle.text = @"隔离区旅客区域分布";
        passengerTtitle.font = [UIFont fontWithName:@"PingFangSC-Regular"
                                               size:27/2];
        passengerTtitle.textColor = [UIColor whiteColor];
        [topBgView addSubview:passengerTtitle];


        UIImageView *planImageView = [[UIImageView alloc]initWithFrame:CGRectMake(17,
                                                                                  viewBotton(passengerTtitle)+ 8,
                                                                                  11,
                                                                                  11)];
        planImageView.image = [UIImage imageNamed:@"PsnSafetyHourChartTag1"];
        [topBgView addSubview:planImageView];
        UILabel *planLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(planImageView)+9,
                                                                      viewY(planImageView), 100, 11)
                                                      text:@"近机位"
                                                      font:27/2
                                             textAlignment:NSTextAlignmentLeft
                                              colorFromHex:0xB5FFFFFF];
        [topBgView addSubview:planLabel];

        UIImageView *realImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(planLabel)+50,
                                                                                  viewY(planLabel),
                                                                                  11,
                                                                                  11)];
        realImageView.image = [UIImage imageNamed:@"PsnSafetyHourChartTag2"];
        [topBgView addSubview:realImageView];

        UILabel *realLabel = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(realImageView)+5,
                                                                      viewY(planImageView),
                                                                      50,
                                                                      11)
                                                      text:@"远机位"
                                                      font:27/2
                                             textAlignment:NSTextAlignmentLeft
                                              colorFromHex:0xB5FFFFFF];
        [topBgView addSubview:realLabel];

//        UILabel *realLabel = [CommonFunction addLabelFrame:CGRectMake(20+100, 5+23 , 100, 15) text:@"远机位" font:15 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF];
//        [topBgView addSubview:realLabel];

        UIImageView *upImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px2(34),
                                                                                viewBotton(planLabel)+px2(7),
                                                                                viewWidth(topBgView)-2*px2(34),
                                                                                px2(2))];
        upImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:upImageView];

//        [topBgView addSubview:[CommonFunction addLine:CGRectMake(20, 5+23+15, topBgView.frame.size.width-40, 1) color:[CommonFunction colorFromHex:0XFF3FDFB7]]];
        
        maxLabel = [CommonFunction addLabelFrame:CGRectMake(20,
                                                                     viewBotton(upImageView)+px2(7),
                                                                     topBgView.frame.size.width-40, 12)
                                                     text:[NSString stringWithFormat:@"%ld",(long)([self maxValue]*1.2)]
                                                     font:11
                                            textAlignment:NSTextAlignmentRight
                                             colorFromHex:0x75FFFFFF];
        [topBgView addSubview:maxLabel];
        
        barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(20,
                                                                5+23+15+2,
                                                                topBgView.frame.size.width-40,
                                                                topBgView.frame.size.height-(5+23+15+2)-5)];//折线图
        
        barChart.yMaxValue = [self maxValue]*1.2;
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
        NSMutableArray *colors = [NSMutableArray array];
        for (int i = 0; i<farArray.count + nearArray.count; i++) {
            if (i<nearArray.count) {
                [colors addObject:[CommonFunction colorFromHex:0x99ffffff]];
            }else{
                [colors addObject:[CommonFunction colorFromHex:0xffBBE32E]];
            }
        }
        barChart.strokeColors = [colors copy];
        [barChart strokeChart];
        
        [topBgView addSubview:barChart];
        
        UILabel *zoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth(topBgView)-6-px2(31),
                                                                      topBgView.frame.size.height-(10+15+12),
                                                                      topBgView.frame.size.width-40,
                                                                      10)];
        zoreLabel.text = @"0";
        zoreLabel.font = [UIFont fontWithName:@"PingFang SC"
                                         size:px2(22)];
        zoreLabel.textColor = [CommonFunction colorFromHex:0X75ffffff];
        [topBgView addSubview:zoreLabel];

        UIImageView *lowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px2(31),
                                                                                 topBgView.frame.size.height-10-15,
                                                                                 viewWidth(topBgView)-2*px2(31),
                                                                                 px2(2))];
        lowImageView.image = [UIImage imageNamed:@"hiddenLine"];
        [topBgView addSubview:lowImageView];
        
        //小时分布表格
        flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(20,
                                                                                        viewBotton(topBgView)+20,
                                                                                        kScreenWidth-40,
                                                                                        viewHeight(self)-10-20-viewBotton(topBgView))];
        flightHourTableView.delegate = self;
        flightHourTableView.dataSource = self;
        flightHourTableView.showsVerticalScrollIndicator = NO;
        flightHourTableView.backgroundColor = [UIColor whiteColor];
        flightHourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:flightHourTableView];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadData:)
                                                     name:@"GlqNearPsn"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadData:)
                                                     name:@"GlqFarPsn"
                                                   object:nil];


    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GlqNearPsn" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GlqFarPsn" object:nil];
}

-(void)loadData:(NSNotification *)notification
{
    NSLog(@"%@",notification.name);
    if ([notification.object isKindOfClass:[NSArray class]]) {
        if ([notification.name isEqualToString:@"GlqFarPsn"]) {
            farArray = notification.object;
        }else{
            nearArray  =  notification.object;
        }

        maxLabel.text = [NSString stringWithFormat:@"%ld",(long)([self maxValue]*1.2)];
        barChart.yMaxValue = [self maxValue]*1.2;
        [barChart setXLabels:[self getFlightHourXLabels]];
        [barChart setYValues:[self getFlightHourYLabels]];
        NSMutableArray *colors = [NSMutableArray array];
        for (int i = 0; i<farArray.count + nearArray.count; i++) {
            if (i<nearArray.count) {
                [colors addObject:[CommonFunction colorFromHex:0x99ffffff]];
            }else{
                [colors addObject:[CommonFunction colorFromHex:0xffBBE32E]];
            }
        }
        barChart.strokeColors = [colors copy];

        [barChart strokeChart];
        
        [flightHourTableView reloadData];

    }

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section ==0)
        return [nearArray count];
    else if(section ==1)
        return [farArray count];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PassengerAreaModel *flightHour = nil;
    
    if(indexPath.section==0){
        flightHour = nearArray[indexPath.row];
    }else{
        flightHour = farArray[indexPath.row];
    }
    FlightHourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flightHour.region];
    
    if (!cell) {
        cell = [[FlightHourTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault)
                                                     psnArea:flightHour];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 40)];
    headerView.backgroundColor = [UIColor whiteColor];

    UIImageView *headerImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                               (viewHeight(headerView)-18)/2,
                                                                               18,
                                                                               18)];
    [headerView addSubview:headerImageView];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewTrailing(headerImageView)+4,
                                                                   0,
                                                                   viewWidth(headerView),
                                                                   viewHeight(headerView))];
    titleLabel.font     = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    [headerView addSubview:titleLabel];

    if (section == 0) {
        headerImageView.image   = [UIImage imageNamed:@"PsnSafetyAreaNear"];
        titleLabel.text         = @"近机位";
    }else{
        headerImageView.image   = [UIImage imageNamed:@"PsnSafetyAreaFar"];
        titleLabel.text         = @"远机位";
    }

    return headerView;
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

-(NSInteger)maxValue
{
    NSInteger max = 0;
    for(PassengerAreaModel *model in nearArray){
        if(model.count > max){
            max = model.count;
        }
    }
    for(PassengerAreaModel *model in farArray){
        if(model.count > max){
            max = model.count;
        }
    }
    return max==0?1:max;
}


@end
