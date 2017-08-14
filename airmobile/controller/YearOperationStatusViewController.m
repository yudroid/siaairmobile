//
//  YearOperationStatusViewController.m
//  airmobile
//
//  Created by xuesong on 2017/7/19.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "UIViewController+Reminder.h"
#import "YearOperationStatusViewController.h"
#import "PNBarChart.h"
#import "ZFChart.h"
#import "HttpsUtils+Business.h"
#import "YearOperationStatusTableViewCell.h"
#import "YearOperationStatusModel.h"
#import "PNMixLineChart.h"
#import "PNLineChartData.h"


static NSString *cellIdentifier = @"CELLIDENTIFIER";

@interface YearOperationStatusViewController ()<ZFGenericChartDataSource, ZFHorizontalBarChartDelegate>

@property (nonatomic, strong) PNBarChart *outFlightTImeBarChart;
@property (nonatomic, strong) ZFHorizontalBarChart *delayTimeBarChart;
@property (nonatomic, strong) PNMixLineChart *lineChart;

@property (nonatomic, copy) NSArray *yearAbnormalFlightArray;//放行不正常航班
@property (nonatomic, copy) NSArray *morningFlightArray;//早出港放行不正常航班
@property (nonatomic, copy) NSArray *yearAbnormalAirportArray;//放行不正常航空公司
@property (nonatomic, copy) NSArray *morningAirportArray;//早出港放行不正常航空公司

@property (nonatomic, copy) NSArray *yearDFltHourCounts; //出港航班分时统计
@property (nonatomic, copy) NSArray *yearAbnormalReleaseRatioDelayTimes;//放行不正常延误时间统计

@end

@implementation YearOperationStatusViewController

-(void)awakeFromNib{
    [super awakeFromNib];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];
    [self initViewStyle];
    [self initTimeBarChar];
    [self initDelayBarChart];
    [self initLineChart];

    [self loadData];
}

//初始化标题
-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"年度运行情况"];
    [self titleViewAddBackBtn];
}

//页面样式
- (void)initViewStyle
{
    _airlineRankView.layer.cornerRadius = 10.0;
    _airlineRankView.layer.borderWidth  = 2;
    _airlineRankView.layer.borderColor  = [CommonFunction colorFromHex:0xFF000000].CGColor;

    _airportRankView.layer.cornerRadius = 10.0;
    _airportRankView.layer.borderWidth  = 2;
    _airportRankView.layer.borderColor  = [CommonFunction colorFromHex:0xFF000000].CGColor;

    _yearAbnormalAirportTableView.tableFooterView   = [[UIView alloc]init];
    _yearAbnormalFlightTableView.tableFooterView    = [[UIView alloc]init];
    _morningAirportTableView.tableFooterView        = [[UIView alloc]init];
    _morningFlightTableView.tableFooterView         = [[UIView alloc]init];
}
//初始化出港航班分时统计图表
-(void)initTimeBarChar
{

    _yearAbnormalFlightArray    = @[];
    _morningFlightArray         = @[];
    _yearAbnormalAirportArray   = @[];
    _morningAirportArray        = @[];
    _yearDFltHourCounts         = @[];
    _yearAbnormalReleaseRatioDelayTimes = @[];


    //柱状图
    _outFlightTImeBarChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            kScreenWidth-32,
                                                            _outFlightChartView.frame.size.height)];

    _outFlightTImeBarChart.yMaxValue          = 100;
    _outFlightTImeBarChart.yMinValue          = 0;
    _outFlightTImeBarChart.showXLabel         = YES;
    _outFlightTImeBarChart.showYLabel         = NO;
    _outFlightTImeBarChart.backgroundColor    = [UIColor clearColor];

    _outFlightTImeBarChart.yChartLabelWidth   = 20.0;
    _outFlightTImeBarChart.labelTextColor     = [CommonFunction colorFromHex:0xFFFFFFFF];


    _outFlightTImeBarChart.labelMarginTop     = 5.0;
    _outFlightTImeBarChart.showChartBorder    = NO;
    _outFlightTImeBarChart.barRadius          = 2.0f;
    _outFlightTImeBarChart.chartMarginBottom  = 5.0f;
    [_outFlightTImeBarChart setXLabels:[self getFlightHourXLabels]];
    [_outFlightTImeBarChart setYValues:[self getPlanYLabels]];

//    _outFlightTImeBarChart.isGradientShow     = YES;
    _outFlightTImeBarChart.isShowNumbers      = YES;
    _outFlightTImeBarChart.barBackgroundColor = [UIColor clearColor];

    [_outFlightTImeBarChart strokeChart];

    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(16,
                                                               viewHeight(_outFlightChartView)-20,
                                                               kScreenWidth-32-32,
                                                               1)];
    lineView.backgroundColor = [CommonFunction colorFromHex:0xaaFFFFFF];
    [_outFlightChartView addSubview:lineView];

    [_outFlightChartView addSubview:_outFlightTImeBarChart];

}
//初始化不正常延误时间图表
-(void)initDelayBarChart
{
    _delayTimeBarChart = [[ZFHorizontalBarChart alloc] initWithFrame:CGRectMake(0, -35, kScreenWidth-32, viewHeight(_delayTimeChartView)+70)];
    _delayTimeBarChart.dataSource           = self;
    _delayTimeBarChart.delegate             = self;
    _delayTimeBarChart.isShowAxisLineValue  = YES;
    _delayTimeBarChart.axisLineNameColor    = [UIColor whiteColor];
    _delayTimeBarChart.axisLineValueColor   = [UIColor whiteColor];
    _delayTimeBarChart.backgroundColor      = [UIColor clearColor];
    _delayTimeBarChart.xAxisColor           = [UIColor clearColor];
    _delayTimeBarChart.yAxisColor           = [UIColor whiteColor];
    _delayTimeBarChart.shadowColor          = [UIColor clearColor];
    _delayTimeBarChart.opacity              = 0.7;
    [_delayTimeChartView addSubview:_delayTimeBarChart];
    [_delayTimeBarChart strokePath];
}
-(void)initLineChart
{
    _lineChart = [[PNMixLineChart alloc] initWithFrame:CGRectMake(0,
                                                                  0,
                                                                  kScreenWidth-32,
                                                                  _outFlightChartView.frame.size.height)];
    _lineChart.backgroundColor = [UIColor clearColor];
    [_lineChart setXLabels:[self getFlightHourXLabels]];
    _lineChart.showCoordinateAxis = NO;
    _lineChart.showGenYLabels=NO;
    _lineChart.xLabelColor = [UIColor clearColor];
//    _lineChart.showLabel = NO;
//    _lineChart.chartMarginRight = 16;
    // added an examle to show how yGridLines can be enabled
    // the color is set to clearColor so that the demo remains the same
    _lineChart.yGridLinesColor = [UIColor clearColor];

    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    _lineChart.yFixedValueMax = (int)(2);
    _lineChart.yFixedValueMin = 0;


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

    _lineChart.changeNum = NSIntegerMax;
    _lineChart.chartData = @[data];
    [_outFlightChartView addSubview:_lineChart];
    [_lineChart strokeChart];


}

-(NSArray *) getFlightHourYLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in _yearDFltHourCounts) {
        [arr addObject:[dic objectForKey:@"ratio"]?:@(0)];
    }
    return [arr copy];
}

-(NSArray *) getFlightHourXLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in _yearDFltHourCounts) {
        [arr addObject:[dic objectForKey:@"hour"]];
    }
    return [arr copy];
}

-(NSArray *) getPlanYLabels
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in _yearDFltHourCounts) {
        [arr addObject:[dic objectForKey:@"count"]?:@(0)];
    }
    return [arr copy];
}
-(CGFloat)maxValueTimeBarChart
{
    CGFloat maxValue = 0;
    for (NSDictionary *dic in _yearDFltHourCounts) {
        NSNumber *number = [dic objectForKey:@"count"];
        if (maxValue<number.floatValue) {
            maxValue = number.floatValue;
        }
    }
    return maxValue;
}
//更新柱状图
-(void)updateTimeBarChart
{
    _outFlightTImeBarChart.yMaxValue  = [self maxValueTimeBarChart] ;
    [_outFlightTImeBarChart setXLabels:[self getFlightHourXLabels]];
    [_outFlightTImeBarChart setYValues:[self getPlanYLabels]];
    [_outFlightTImeBarChart strokeChart];


//    _delayTimeViewHeight.constant = _yearDFltHourCounts.count *
    [_delayTimeBarChart strokePath];



    // Line Chart #2

    [_lineChart setXLabels:[self getFlightHourXLabels]];
    PNLineChartData *data = [PNLineChartData new];
    _lineChart.yFixedValueMax = (int)(1);
    data.color = [UIColor whiteColor];
    data.alpha = 0.5f;
    data.inflexionPointStyle = PNLineChartPointStyleCircle;

    NSArray * dataArray = [self getFlightHourYLabels];
    data.itemCount = dataArray.count;
    data.getData = ^(NSUInteger index) {
        CGFloat yValue = [dataArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    _lineChart.chartData = @[data];
    [_lineChart strokeChart];
}

#pragma mark - 网络请求
-(void)loadData{

    [self starNetWorking];
    [HttpsUtils queryYearOperationSituationWithSuccess:^(id responseObj) {
        NSLog(@"%@",responseObj);

        [self stopNetWorking];

        YearOperationStatusModel *model = [[YearOperationStatusModel alloc]initWithDictionary:responseObj];

        _morningFlightArray             = model.YearMornFltReleaseRatio;
        _yearReleaseRatioLabel.text     = model.YearReleaseRatio;
        _yearMornReleaseRatioLabel.text = model.YearMornReleaseRatio;
        _morningFlightArray             = model.YearMornFltReleaseRatio;
        _morningAirportArray            = model.YearMornALReleaseRatio;
        _yearAbnormalFlightArray        = model.YearFltReleaseRatio;
        _yearAbnormalAirportArray       = model.YearALReleaseRatio;

        _yearDFltHourCounts             = model.YearDFltHourCount;

        _yearAbnormalReleaseRatioDelayTimes = model.YearAbnormalReleaseRatioDelayTime;

        [_morningFlightTableView        reloadData];
        [_morningAirportTableView       reloadData];
        [_yearAbnormalFlightTableView   reloadData];
        [_yearAbnormalAirportTableView  reloadData];

        [self updateTimeBarChart];

        NSLog(@"%@",model);
    } failure:^(NSError *error) {
        [self stopNetWorking];
        [self showAnimationTitle:@"请求失败"];
    }];
}

#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in _yearAbnormalReleaseRatioDelayTimes) {
        [mutableArray addObject:((NSNumber *)[dic objectForKey:@"count"]).stringValue];
    }
    return [mutableArray copy];
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in _yearAbnormalReleaseRatioDelayTimes) {
        [mutableArray addObject:[dic objectForKey:@"delayTimeType"]];
    }
    return [mutableArray copy];
}
//- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
//    return @[ZFMagenta];
//}
- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
    return 10.0;
}
//- (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart{
//    return 50;
//}
//- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
//    return 10;
//}
#pragma mark - ZFHorizontalBarChartDelegate
//- (CGFloat)barHeightInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
//    return 25.f;
//}
//- (CGFloat)paddingForGroupsInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
//    return 20.f;
//}
//- (CGFloat)paddingForBarInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
//    return 5.f;
//}
//- (id)valueTextColorArrayInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
//    return [UIColor whiteColor];
//}
//
//- (NSArray<ZFGradientAttribute *> *)gradientColorArrayInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
//    ZFGradientAttribute * gradientAttribute = [[ZFGradientAttribute alloc] init];
//    gradientAttribute.colors = @[(id)[UIColor whiteColor].CGColor];
//
//    return [NSArray arrayWithObjects:gradientAttribute, nil];
//}
//
//
-(NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart
{
    return @[[CommonFunction colorFromHex:0xFFFFFFFF]];
}
#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _yearAbnormalFlightTableView) {
        return _yearAbnormalFlightArray.count;
    } else if(tableView == _yearAbnormalAirportTableView){
        return _yearAbnormalAirportArray.count;
    }else if (tableView == _morningFlightTableView){
        return _morningFlightArray.count;
    }else if (tableView == _morningAirportTableView){
        return _morningAirportArray.count;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YearOperationStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"YearOperationStatusTableViewCell" owner:nil options:nil][0];
    }
    NSDictionary *dic ;
    if (tableView == _yearAbnormalFlightTableView) {
        dic = [_yearAbnormalFlightArray objectAtIndex:indexPath.row];
        cell.valueLabel.text = [dic objectForKey:@"ratio"];
    } else if(tableView == _yearAbnormalAirportTableView){
        dic = [_yearAbnormalAirportArray objectAtIndex:indexPath.row];
        cell.valueLabel.text = [dic objectForKey:@"ratio"];
    }else if (tableView == _morningFlightTableView){
        dic = [_morningFlightArray objectAtIndex:indexPath.row];
        cell.valueLabel.text = [dic objectForKey:@"mornRatio"];
    }else if (tableView == _morningAirportTableView){
        dic = [_morningAirportArray objectAtIndex:indexPath.row];
        cell.valueLabel.text = [dic objectForKey:@"mornRatio"];
    }else{
        dic = @{};
    }
    cell.nameLabel.text  = [dic objectForKey:@"hour"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
