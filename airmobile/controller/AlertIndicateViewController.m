//
//  AlertIndicateViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AlertIndicateViewController.h"
#import "RoundProgressView.h"
#import "PNLineChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"
#import "FlightHourModel.h"
#import "FlightLargeDelayModel.h"

@interface AlertIndicateViewController ()

@property (nonatomic ,strong) FlightLargeDelayModel *flightLargeDelayModel;

@end

@implementation AlertIndicateViewController
{
    CGFloat normalProportion;
    CGFloat abnormalProportion;
    CGFloat cancleProportion;


    PNLineChart *lineChart;
    UILabel     *ratioNum;
    UILabel     *peopleLabel;
    UILabel     *todayLabel;
    UILabel     *arrRatioLabel;
    UILabel     *addTimeLabel;


}

-(instancetype)initWithDalayTagart:(FlightLargeDelayModel *)flightLargeDelayModel
{
    self = [super init];
    if (self) {
        _flightLargeDelayModel = flightLargeDelayModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitle];

//    [self initData];

    CGFloat topBgViewWidth = kScreenWidth-2*px2(22);
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(10,
                                                                 65+px_px_2_3(24, 116),
                                                                 topBgViewWidth,
                                                                 topBgViewWidth *391/709)];
    [self.view addSubview:topBgView];

    UIImageView *topBgBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                         0,
                                                                                         viewWidth(topBgView),
                                                                                         viewHeight(topBgView))];
    topBgBackgroundImageView.image = [UIImage imageNamed:@"TenDayRatioChartBackground"];
    [topBgView addSubview:topBgBackgroundImageView];
    [topBgView.layer setMasksToBounds:YES];// 隐藏边界

    UILabel *passengerTtitle = [[UILabel alloc] initWithFrame:CGRectMake(16,
                                                                         8,
                                                                         viewWidth(topBgView)-100,
                                                                         11)];
    passengerTtitle.text = @"放行率";
    passengerTtitle.font = [UIFont fontWithName:@"PingFangSC-Regular"
                                           size:27/2];
    passengerTtitle.textColor = [UIColor whiteColor];
    [topBgView addSubview:passengerTtitle];

//    ratioNum = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width-100,
//                                                                 7.5,
//                                                                 80,
//                                                                 20)
//                                                 text:@(_flightLargeDelayModel.delayOneHourRatio).stringValue
//                                                 font:24
//                                        textAlignment:NSTextAlignmentRight
//                                         colorFromHex:0xFFFFFFFF];
//    [topBgView addSubview:ratioNum];



//    todayLabel = [CommonFunction addLabelFrame:CGRectMake(topBgView.frame.size.width-140,
//                                                                   viewBotton(ratioNum)+4 ,
//                                                                   120,
//                                                                   9)
//                                                   text:[NSString stringWithFormat:@"当前 %@",[CommonFunction dateFormat:nil format:@"hh:mi"]]
//                                                   font:11
//                                          textAlignment:NSTextAlignmentRight
//                                           colorFromHex:0x75FFFFFF];
//    [topBgView addSubview:todayLabel];

//    UILabel *circleLabel= [CommonFunction addLabelFrame:CGRectMake(viewX(passengerTtitle), viewY(todayLabel), 20, 20) text:@"●" font:11 textAlignment:NSTextAlignmentLeft colorFromHex:0xFFFFFFFF];
//    [topBgView addSubview:circleLabel];
//
//    UILabel *ratioChar = [CommonFunction addLabelFrame:CGRectMake(viewX(passengerTtitle)+20, viewY(todayLabel), 80, 20) text:@"放行率" font:11 textAlignment:NSTextAlignmentLeft colorFromHex:0x75FFFFFF];
//    [topBgView addSubview:ratioChar];


    UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle),
                                                                              viewBotton(todayLabel)+4,
                                                                              viewWidth(topBgView)-viewX(passengerTtitle)-18,
                                                                              0.5)];
    lineImageView.image = [UIImage imageNamed:@"hiddenLine"];
    [topBgView addSubview:lineImageView];


    UILabel *maxLabel = [CommonFunction addLabelFrame:CGRectMake(viewWidth(topBgView)-18-50,
                                                                 viewBotton(lineImageView)+4,
                                                                 50,
                                                                 9)
                                                 text:@"120"
                                                 font:11
                                        textAlignment:NSTextAlignmentRight
                                         colorFromHex:0x75FFFFFF];
    [topBgView addSubview:maxLabel];

    lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(20,
                                                              5+23+23+2,
                                                              topBgView.frame.size.width-40,
                                                              topBgView.frame.size.height-(5+23+23+2)-5)];
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
    lineChart.yFixedValueMax = 120;
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


    UIImageView *downlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(passengerTtitle),
                                                                                  topBgView.frame.size.height-10-15-2,
                                                                                  viewWidth(topBgView)-viewX(passengerTtitle)-18,
                                                                                  0.5)];
    downlineImageView.image = [UIImage imageNamed:@"hiddenLine"];
    [topBgView addSubview:downlineImageView];

    [topBgView addSubview:[CommonFunction addLabelFrame:CGRectMake(20,
                                                                   viewY(downlineImageView)-13-4,
                                                                   topBgView.frame.size.width-40,
                                                                   13)
                                                   text:@"0"
                                                   font:11
                                          textAlignment:NSTextAlignmentRight
                                           colorFromHex:0x75FFFFFF]];


    UIImageView *buildingImageView = [CommonFunction imageView:@"BedetainedPeople" frame:CGRectMake(45/2,
                                                                                                    viewBotton(topBgView)+px_px_2_3(60, 92),
                                                                                                    15,
                                                                                                    18)];
    [self.view addSubview:buildingImageView];
    
    [self.view addSubview:[CommonFunction addLabelFrame:CGRectMake(viewTrailing(buildingImageView)+16,
                                                                   viewY(buildingImageView),
                                                                   kScreenWidth-160,
                                                                   viewHeight(buildingImageView))
                                                   text:@"航站楼内滞留旅客"
                                                   font:px_px_2_2_3(25, 36, 48)
                                          textAlignment:(NSTextAlignmentLeft)
                                           colorFromHex:0xFF000000]];
    peopleLabel = [CommonFunction addLabelFrame:CGRectMake(kScreenWidth-80-22,
                                                                    viewY(buildingImageView),
                                                                    80,
                                                                    viewHeight(buildingImageView))
                                                    text:@(_flightLargeDelayModel.glqPassenCnt).stringValue
                                                    font:px_px_2_2_3(25, 36, 48)
                                           textAlignment:(NSTextAlignmentRight)
                                            colorFromHex:0xFF000000];
    
    [self.view addSubview:peopleLabel];

    UIImageView *lineImageView1= [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(buildingImageView)+px_px_2_3(42, 63),
                                                                              viewBotton(buildingImageView)+18,
                                                                              viewWidth(self.view)-(viewTrailing(buildingImageView)+16+43/2),
                                                                              1)];
    lineImageView1.image = [UIImage imageNamed:@"Line"];
    [self.view addSubview:lineImageView1];

    UIImageView *delayImageView = [CommonFunction imageView:@"BedetainedRatio"
                                                      frame:CGRectMake(viewX(buildingImageView),
                                                                       viewBotton(lineImageView1)+18,
                                                                       15,
                                                                       18)];
    [self.view addSubview:delayImageView];
    
    [self.view addSubview:[CommonFunction addLabelFrame:CGRectMake(viewTrailing(delayImageView)+16,
                                                                   viewY(delayImageView),
                                                                   kScreenWidth-160,
                                                                   viewHeight(delayImageView))
                                                   text:@"延误>1h航班出港率"
                                                   font:px_px_2_2_3(25, 36, 48)
                                          textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF000000]];

    arrRatioLabel = [CommonFunction addLabelFrame:CGRectMake(kScreenWidth-80-43/2,
                                                                       viewY(delayImageView),
                                                                       80,
                                                                       viewHeight(delayImageView))
                                                       text:[NSString stringWithFormat:@"%ld%%",(long)@(_flightLargeDelayModel.delayOneHourRatio*100.0).integerValue]
                                                       font:px_px_2_2_3(25, 36, 48)
                                              textAlignment:(NSTextAlignmentRight)
                                               colorFromHex:0xFF000000];
    [self.view addSubview:arrRatioLabel];

    UIImageView *lineImageView2= [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(buildingImageView)+px_px_2_3(42, 63),
                                                                              viewBotton(delayImageView)+18,
                                                                              viewWidth(self.view)-viewTrailing(buildingImageView)-16-43/2,
                                                                              1)];
    lineImageView2.image = [UIImage imageNamed:@"Line"];
    [self.view addSubview:lineImageView2];
    
    UIImageView *noFlightImageView = [CommonFunction imageView:@"BedetainedTime" frame:CGRectMake(viewX(buildingImageView),
                                                                                                  viewBotton(lineImageView2)+18,
                                                                                                  15,
                                                                                                  18)];
    [self.view addSubview:noFlightImageView];
    
    [self.view addSubview:[CommonFunction addLabelFrame:CGRectMake(viewTrailing(noFlightImageView)+16,
                                                                   viewBotton(lineImageView2)+px_px_2_3(42, 63),
                                                                   kScreenWidth-160,
                                                                   viewHeight(noFlightImageView))
                                                   text:@"无航班起降累积时间"
                                                   font:px_px_2_2_3(25, 36, 48)
                                          textAlignment:(NSTextAlignmentLeft)
                                           colorFromHex:0xFF000000]];

    addTimeLabel = [CommonFunction addLabelFrame:CGRectMake(kScreenWidth-80-43/2,
                                                                     viewY(noFlightImageView),
                                                                     80,
                                                                     viewHeight(noFlightImageView))
                                                     text:[NSString stringWithFormat:@"%d min",_flightLargeDelayModel.noTakeoffAndLanding]
                                                     font:px_px_2_2_3(25, 36, 48)
                                            textAlignment:(NSTextAlignmentRight)
                                             colorFromHex:0xFF000000];
    [self.view addSubview:addTimeLabel];

    UIImageView *lineImageView3= [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(buildingImageView)+px_px_2_3(42, 63),
                                                                              viewBotton(noFlightImageView)+16,
                                                                              viewWidth(self.view)-viewTrailing(buildingImageView)-16-43/2,
                                                                              1)];
    lineImageView3.image = [UIImage imageNamed:@"Line"];
    [self.view addSubview:lineImageView3];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadData:)
                                                 name:@"FlightDelayTarget"
                                               object:nil];

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"FlightDelayTarget"
                                                  object:nil];
}
-(void)initTitle
{
    [self titleViewInitWithHight:65];
    [self titleViewAddTitleText:@"延误指标"];
    
    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 65)];
    self.titleView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];
    
    [self titleViewAddBackBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *) getFlightHourXLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(FlightHourModel *model in _flightLargeDelayModel.hourExecuteRateList){
        if(model.hour){
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
    for(FlightHourModel *model in _flightLargeDelayModel.hourExecuteRateList){
        [arr addObject:@((int)(model.radio))];
    }
    return arr;
}


-(void)loadData:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[FlightLargeDelayModel class]]) {
        _flightLargeDelayModel  = notification.object;
//        ratioNum.text           = @(_flightLargeDelayModel.delayOneHourRatio).stringValue;
        peopleLabel.text        = @(_flightLargeDelayModel.glqPassenCnt).stringValue;
//        todayLabel.text         = [NSString stringWithFormat:@"当前 %@",[CommonFunction dateFormat:nil format:@"hh:mi"]];
        arrRatioLabel.text      = [NSString stringWithFormat:@"%ld%%",(long)@(_flightLargeDelayModel.delayOneHourRatio*100.0).integerValue];
        addTimeLabel.text       = [NSString stringWithFormat:@"%d min",_flightLargeDelayModel.noTakeoffAndLanding];

        [lineChart setXLabels:[self getFlightHourXLabels]];

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

    }
}

@end
