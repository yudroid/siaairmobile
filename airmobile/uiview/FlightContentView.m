//
//  FlightContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightContentView.h"
#import "FlightStusModel.h"
#import "HomePageService.h"

@interface FlightContentView()

@property (nonatomic, strong) FlightStusModel *flightStusModel;


@end

@implementation FlightContentView
{
    UIView          *segmentedView;
    UIView          *depFlightView;
    UIImageView     *depFlightBackgroundImageView;
    UILabel         *depFlightLabel;
    UIView          *arrFlightView;
    UIImageView     *arrFlightBackgroundImageView;
    UILabel         *arrFlightLabel;

    UIButton        *depFlightButton ;
    UIButton        *arrFlightButton ;
    UIScrollView    *scrollView ;
    UILabel         *delay;
    UILabel         *cancel;

    UILabel         *arrInNum;
    UILabel         *depOutNum;
    UILabel         *totalNum;
    UILabel         *arrNum;
    PNPieChart      *arrRoundProgress;
    PNPieChart      *depRoundProgress;

    UIButton        *abnButton; //异常按钮
    UILabel         *abnLabel;  //异常按钮文字

    NSMutableArray *arrShapeArray;
    NSMutableArray *depShapeArray;

}

-(instancetype)initWithFrame:(CGRect)                       frame
                    delegate:(id<FlightContentViewDelegate>)delegate
{
    self = [super initWithFrame:frame];

    if(self){
        
        _delegate = delegate;
        
        _flightStusModel = [HomePageService sharedHomePageService].flightModel;


        
        arrShapeArray = [[NSMutableArray alloc] init];
        depShapeArray = [[NSMutableArray alloc] init];

        float y = 0;

        //进出港 切换视图
        segmentedView = [[UIView alloc]initWithFrame:CGRectMake(10,
                                                                y,
                                                                kScreenWidth-2*10,
                                                                34)];
        [self addSubview:segmentedView];
        UIImageView *segmentedBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                                 0,
                                                                                                 viewWidth(segmentedView),
                                                                                                 viewHeight(segmentedView))];
        segmentedBackgroundImageView.image = [UIImage imageNamed:@"segmentedBackground"];
        [segmentedView addSubview:segmentedBackgroundImageView];
        //出港view
        depFlightView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                 0,
                                                                 viewWidth(segmentedView)/2,
                                                                 viewHeight(segmentedView))];
        [segmentedView addSubview:depFlightView];

        depFlightBackgroundImageView        = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                            0,
                                                                                            viewWidth(depFlightView),
                                                                                            viewHeight(depFlightView))];
        depFlightBackgroundImageView.image  = [UIImage imageNamed:@"SegmentedLeft"];
        [depFlightView addSubview:depFlightBackgroundImageView];

        depFlightLabel = [CommonFunction addLabelFrame:CGRectMake(0,
                                                                  0,
                                                                  viewWidth(depFlightView) ,
                                                                  viewHeight(depFlightView))
                                                  text:@"出港航班"
                                                  font:33/2.0
                                         textAlignment:(NSTextAlignmentCenter)
                                          colorFromHex:0xFFFFFFFF];
        [depFlightView addSubview:depFlightLabel];

        depFlightButton     = [[UIButton alloc] initWithFrame:depFlightLabel.frame];
        [depFlightButton addTarget:self
                            action:@selector(buttonClickedWithSender:)
                  forControlEvents:(UIControlEventTouchUpInside)];
        depFlightButton.tag = 0;
        [depFlightView addSubview:depFlightButton];

        arrFlightView = [[UIView alloc ] initWithFrame:CGRectMake(viewWidth(depFlightView),
                                                                  0,
                                                                  viewWidth(depFlightView),
                                                                  viewHeight(depFlightView))];
        [segmentedView addSubview:arrFlightView];

         arrFlightBackgroundImageView       = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                            0,
                                                                                            viewWidth(arrFlightView),
                                                                                            viewHeight(arrFlightView))];
        arrFlightBackgroundImageView.image  = nil;
        [arrFlightView addSubview:arrFlightBackgroundImageView];

        arrFlightLabel = [CommonFunction addLabelFrame:CGRectMake(0,
                                                                  0,
                                                                  viewWidth(depFlightLabel),
                                                                  viewHeight(depFlightLabel))
                                                  text:@"进港航班"
                                                  font:33/2.0
                                         textAlignment:(NSTextAlignmentCenter)
                                          colorFromHex:0xFF17B9E8];
        [arrFlightView addSubview:arrFlightLabel];

        arrFlightButton = [[UIButton alloc] initWithFrame:arrFlightLabel.frame];
        [arrFlightButton addTarget:self
                            action:@selector(buttonClickedWithSender:)
                  forControlEvents:(UIControlEventTouchUpInside)];
        arrFlightButton.tag = 1;
        [arrFlightView addSubview:arrFlightButton];

//        UILabel *explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth(self)-90-15,
//                                                                         viewBotton(segmentedView)+px_px_2_2_3(35,43, 64),
//                                                                         90,
//                                                                         11)];
//        explainLabel.text       = @"即将出港航班";
//        explainLabel.font       = [UIFont fontWithName:@"PingFangSC-Regular"
//                                                  size:27/2];
//        explainLabel.textColor  = [CommonFunction colorFromHex:0xFFFFCD21];
//        [self addSubview:explainLabel];

//        UIImageView *explainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(explainLabel)-4-10,
//                                                                                     viewY(explainLabel)+0.5,
//                                                                                     10,
//                                                                                     10)];
//        explainImageView.image      = [UIImage imageNamed:@"Completed"];
//        [self addSubview:explainImageView];

        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                    viewBotton(segmentedView)+px_px_2_2_3(30, 40, 60),
                                                                    frame.size.width,
                                                                    px_px_2_2_3(400, 500, 750))];
        scrollView.delegate         = self;
        scrollView.contentSize      = CGSizeMake(frame.size.width*2, px_px_2_2_3(400, 500, 750));
        scrollView.backgroundColor  = [UIColor clearColor];
        scrollView.pagingEnabled    = YES;
        scrollView.showsHorizontalScrollIndicator   = NO;
        scrollView.showsVerticalScrollIndicator     = NO;
        [self addSubview:scrollView];


        [self updateShapeArray:depShapeArray];
        [self updateShapeArray:arrShapeArray];

        arrRoundProgress = [[PNPieChart alloc] initWithFrame:CGRectMake(0,
                                                                                    0,
                                                                                    px_px_2_2_3(341,400, 664),
                                                                                    px_px_2_2_3(341,400, 664))
                                                                   items:arrShapeArray];
        arrRoundProgress.center                     = CGPointMake(frame.size.width+frame.size.width/2, px_px_2_2_3(400, 500, 750)/2.0);
        arrRoundProgress.descriptionTextColor       = [UIColor clearColor];
        arrRoundProgress.descriptionTextFont        = [UIFont fontWithName:@"PingFangSC-Regular" size:29/2];
        arrRoundProgress.descriptionTextShadowColor = [UIColor clearColor];
        arrRoundProgress.showAbsoluteValues         = YES;
        arrRoundProgress.showOnlyValues             = YES;
        [arrRoundProgress strokeChart];
        arrRoundProgress.legendStyle                = PNLegendItemStyleStacked;
        arrRoundProgress.legendFont                 = [UIFont fontWithName:@"PingFangSC-Regular" size:9];
        arrRoundProgress.legendFontColor            = [CommonFunction colorFromHex:0xff595757];
        [scrollView addSubview:arrRoundProgress];


        
        UIView *arrLegend = [arrRoundProgress getLegendWithMaxWidth:200];
        [arrLegend setFrame:CGRectMake(2*viewWidth(scrollView)-arrLegend.frame.size.width-20,
                                    viewHeight(scrollView)-viewHeight(arrLegend),
                                    arrLegend.frame.size.width,
                                    arrLegend.frame.size.height)];
//        legend.backgroundColor = [UIColor redColor];
        [scrollView addSubview:arrLegend];
        
        arrInNum = [CommonFunction addLabelFrame:CGRectMake(0,
                                                                     (viewHeight(arrRoundProgress)-52)/2-px_px_2_2_3(20, 30, 50),
                                                                     viewWidth(arrRoundProgress),
                                                                     52)
                                                     text:@(_flightStusModel.arrCount).stringValue
                                                     font:px_px_2_2_3(95,120, 203)
                                            textAlignment:(NSTextAlignmentCenter)
                                             colorFromHex:0xFF0b0b0b];

        arrInNum.font = [UIFont fontWithName:@"PingFangSC-Semibold"
                                        size:px_px_2_2_3(102.4,120, 203)];
        [arrRoundProgress addSubview:arrInNum];

        UILabel *arrInLabel = [CommonFunction addLabelFrame:CGRectMake(0,
                                                                       viewBotton(arrInNum)+px_px_2_2_3(20,30, 60),
                                                                       viewWidth(arrRoundProgress),
                                                                       18)
                                                       text:@"进港航班"
                                                       font:18
                                              textAlignment:(NSTextAlignmentCenter)
                                               colorFromHex:0xFF00b0d8];
        [arrRoundProgress addSubview:arrInLabel];
        
        UIButton *arrButton = [[UIButton alloc] initWithFrame:arrRoundProgress.frame];
        [arrButton addTarget:self
                      action:@selector(showArrFlightHourView:)
            forControlEvents:(UIControlEventTouchUpInside)];

        arrButton.center = arrRoundProgress.center;
        [scrollView addSubview:arrButton];
        
        depRoundProgress = [[PNPieChart alloc] initWithFrame:CGRectMake(0,
                                                                                    0,
                                                                                    px_px_2_2_3(341,400, 664),
                                                                                    px_px_2_2_3(341,400, 664))
                                                                   items:depShapeArray];

        depRoundProgress.center                     = CGPointMake(frame.size.width/2,
                                                                  px_px_2_2_3(400, 500, 750)/2.0);
        depRoundProgress.descriptionTextColor       = [UIColor clearColor];
        depRoundProgress.descriptionTextFont        = [UIFont fontWithName:@"PingFangSC-Regular" size:29/2];
        depRoundProgress.descriptionTextShadowColor = [UIColor clearColor];
        depRoundProgress.showAbsoluteValues         = YES;
        depRoundProgress.showOnlyValues             = YES;
        [depRoundProgress strokeChart];
        depRoundProgress.legendStyle                = PNLegendItemStyleStacked;
        depRoundProgress.legendFont                 = [UIFont fontWithName:@"PingFangSC-Regular" size:9];
        [scrollView addSubview:depRoundProgress];


        UIView *depLegend = [depRoundProgress getLegendWithMaxWidth:200];
        [depLegend setFrame:CGRectMake(viewWidth(scrollView)-depLegend.frame.size.width-20,
                                       viewHeight(scrollView)-viewHeight(depLegend),
                                       depLegend.frame.size.width,
                                       depLegend.frame.size.height)];
        //        legend.backgroundColor = [UIColor redColor];
        [scrollView addSubview:depLegend];

        
        depOutNum = [CommonFunction addLabelFrame:CGRectMake(0,
                                                                      (viewHeight(arrRoundProgress)-52)/2-px_px_2_2_3(20, 30, 50),
                                                                      viewWidth(arrRoundProgress),
                                                                      52)
                                                      text:@(_flightStusModel.depCount).stringValue
                                                      font:px_px_2_2_3(95,120, 203)
                                             textAlignment:(NSTextAlignmentCenter)
                                              colorFromHex:0xFF0B0b0b];
        depOutNum.font = [UIFont fontWithName:@"PingFangSC-Semibold"
                                         size:px_px_2_2_3(95,120, 203)];
        [depRoundProgress addSubview:depOutNum];
        UILabel *depOutLabel = [CommonFunction addLabelFrame:CGRectMake(0,
                                                                        viewBotton(arrInNum)+px_px_2_2_3(20,30, 60),
                                                                        viewWidth(arrRoundProgress),
                                                                        15) text:@"出港航班"
                                                        font:18
                                               textAlignment:(NSTextAlignmentCenter)
                                                colorFromHex:0xFF00b0d8];

        [depRoundProgress addSubview:depOutLabel];

        UIButton *depButton = [[UIButton alloc] initWithFrame:depRoundProgress.frame];
        [depButton addTarget:self
                      action:@selector(showDepFlightHourView:)
            forControlEvents:(UIControlEventTouchUpInside)];
        depButton.center = depRoundProgress.center;
        [scrollView addSubview:depButton];


        UIImageView *unusualImageView = [[UIImageView alloc]initWithFrame:CGRectMake((viewWidth(self)-302)/2,
                                                                                     viewBotton(scrollView)+px_px_2_2_3(45,60, 195),
                                                                                     85,
                                                                                     26)];
        unusualImageView.image =  [UIImage imageNamed:@"unusualBackground"];
        [self addSubview:unusualImageView];
        abnLabel = [CommonFunction addLabelFrame:CGRectMake(viewX(unusualImageView),
                                                                     viewY(unusualImageView),
                                                                     viewWidth(unusualImageView),
                                                                     viewHeight(unusualImageView))
                                                     text:@"异常航班"
                                                     font:23
                                            textAlignment:NSTextAlignmentCenter
                                             colorFromHex:0xFFFFFFFF];

        abnLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold"
                                        size:35/2];
        [self addSubview:abnLabel];

        abnButton = [[UIButton alloc] initWithFrame:unusualImageView.frame];
        [abnButton addTarget:self
                      action:@selector(showAbnRsnAndDlyTime:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:abnButton];

        delay = [CommonFunction addLabelFrame:CGRectMake(viewX(unusualImageView)+101,
                                                                  viewY(unusualImageView),
                                                                  100,
                                                                  30)
                                                  text:@""
                                                  font:22
                                         textAlignment:NSTextAlignmentCenter
                                          colorFromHex:0xFF4D4D4D];
        NSMutableAttributedString *delayAttributeString = [[NSMutableAttributedString alloc ] initWithString:[NSString stringWithFormat:@"延误 %d",_flightStusModel.depDelay]];
        [delayAttributeString addAttribute:NSFontAttributeName
                                     value:[UIFont fontWithName:@"PingFangSC-Regular" size:13]
                                     range:NSMakeRange(0, 2)];
        delay.attributedText = delayAttributeString;
        [self addSubview:delay];

        cancel = [CommonFunction addLabelFrame:CGRectMake(viewX(unusualImageView)+202,
                                                                   viewY(unusualImageView),
                                                                   100,
                                                                   30)
                                                   text:@"取消"
                                                   font:22
                                          textAlignment:NSTextAlignmentCenter
                                           colorFromHex:0xFF4D4D4D];

        NSMutableAttributedString *cancelAttributeString = [[NSMutableAttributedString alloc ]
                                                            initWithString:[NSString stringWithFormat:@"取消 %d",_flightStusModel.depCancel]];
        [cancelAttributeString addAttribute:NSFontAttributeName
                                      value:[UIFont fontWithName:@"PingFangSC-Regular" size:13]
                                      range:NSMakeRange(0, 2)];
        cancel.attributedText = cancelAttributeString;
        [self addSubview:cancel];



        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                  viewBotton(unusualImageView)+px_px_2_2_3(35,50, 118),
                                                                                  kScreenWidth,
                                                                                  1.5)];
        lineImageView.image = [UIImage imageNamed:@"Line"];
        [self addSubview:lineImageView];
        UIView *uiview = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  viewBotton(lineImageView)+px_px_2_2_3(35,50, 92),
                                                                  viewWidth(self),
                                                                  48)];

        [self addSubview:uiview];

        totalNum = [CommonFunction addLabelFrame:CGRectMake((viewWidth(uiview)-302)/2,
                                                                     0,
                                                                     100,
                                                                     28)
                                                     text:@(_flightStusModel.flightCount).stringValue
                                                     font:30
                                            textAlignment:NSTextAlignmentCenter
                                             colorFromHex:0xFF525151];

        totalNum.font = [UIFont fontWithName:@"PingFangSC-Medium" size:65/2];
        [uiview addSubview:totalNum];

        UILabel *totalLabel = [CommonFunction addLabelFrame:CGRectMake(viewX(totalNum),
                                                                       viewBotton(totalNum)+6,
                                                                       100,
                                                                       12)
                                                       text:@"航班总数"
                                                       font:20
                                              textAlignment:NSTextAlignmentCenter
                                               colorFromHex:0xFF8B8C8C];

        totalLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:31/2];
        [uiview addSubview:totalLabel];

        UIImageView *verticalLineImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(totalNum),
                                                                                           0,
                                                                                           1,
                                                                                           viewHeight(uiview))];
        verticalLineImageView1.image = [UIImage imageNamed:@"VerticalLine"];
        [uiview addSubview:verticalLineImageView1];

        arrNum = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(verticalLineImageView1),
                                                                   0,
                                                                   100,
                                                                   28)
                                                   text:@(_flightStusModel.arrCount).stringValue
                                                   font:30
                                          textAlignment:NSTextAlignmentCenter
                                           colorFromHex:0xFF525151];

        arrNum.font = [UIFont fontWithName:@"PingFangSC-Medium"
                                      size:65/2];
        [uiview addSubview:arrNum];

        UILabel *arrLabel = [CommonFunction addLabelFrame:CGRectMake(viewX(arrNum),
                                                                     viewBotton(arrNum)+6,
                                                                     100,
                                                                     12)
                                                     text:@"进港航班"
                                                     font:20
                                            textAlignment:NSTextAlignmentCenter
                                             colorFromHex:0xFF8B8C8C];

        arrLabel.font = [UIFont fontWithName:@"PingFangSC-Light"
                                        size:31/2];
        [uiview addSubview:arrLabel];

        UIImageView *verticalLineImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(arrNum),
                                                                                           0,
                                                                                           1,
                                                                                           viewHeight(uiview))];
        verticalLineImageView2.image = [UIImage imageNamed:@"VerticalLine"];
        [uiview addSubview:verticalLineImageView2];

        UILabel *depNum = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(verticalLineImageView2),
                                                                   0,
                                                                   100,
                                                                   30)
                                                   text:@(_flightStusModel.depCount).stringValue
                                                   font:30
                                          textAlignment:NSTextAlignmentCenter
                                           colorFromHex:0xFF525151];

        depNum.font = [UIFont fontWithName:@"PingFangSC-Medium"
                                      size:65/2];
        [uiview addSubview:depNum];

        UILabel *depLabel = [CommonFunction addLabelFrame:CGRectMake(viewX(depNum),
                                                                     viewBotton(depNum)+ 6,
                                                                     100,
                                                                     12)
                                                     text:@"出港航班"
                                                     font:20
                                            textAlignment:NSTextAlignmentCenter
                                             colorFromHex:0xFF8B8C8C];
        depLabel.font = [UIFont fontWithName:@"PingFangSC-Light"
                                        size:31/2];
        [uiview addSubview:depLabel];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadData:)
                                                     name:@"FlightStatusInfo"
                                                   object:nil];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"FlightStatusInfo"
                                                  object:nil];
}
-(void) showArrFlightHourView:(UIButton *)sender
{
    if ([CommonFunction hasFunction:OV_FLIGHT_ARRHOUR]) {
        [_delegate showFlightHourView:(ArrFlightHour)];
    }
}

-(void) showDepFlightHourView:(UIButton *)sender
{
    if([CommonFunction hasFunction:OV_FLIGHT_DEPHOUR]){
        [_delegate showFlightHourView:(DepFlightHour)];
    }
}

-(void) showAbnRsnAndDlyTime:(UIButton *)sender
{
    if ([CommonFunction hasFunction:OV_FLIGHT_DEPABN]) {
        [_delegate showFlightAbnnormalView];
    }
}

-(void) updateShapeArray:(NSMutableArray *)array
{
    if (array == arrShapeArray) {
        [array removeAllObjects];

        //间隔块大小
        float interval = (_flightStusModel.arrDelay +_flightStusModel.arrDoneNormal + _flightStusModel.arrCancel + _flightStusModel.arrPlanNormal)/360.0 *5;
        if(_flightStusModel.arrDelay>0){
            [array addObject: [PNPieChartDataItem dataItemWithValue:interval
                                                          color:[UIColor clearColor]]];
        }
        [array addObject: [PNPieChartDataItem dataItemWithValue:_flightStusModel.arrDelay
                                                          color:[CommonFunction colorFromHex:0xFFFFCD21]
                                                    description:[NSString stringWithFormat:@"%@   :%d",@"延误",_flightStusModel.arrDelay]]];
        if (_flightStusModel.arrDoneNormal>0) {
            [array addObject: [PNPieChartDataItem dataItemWithValue:interval
                                                              color:[UIColor clearColor]]];
        }

        [array addObject: [PNPieChartDataItem dataItemWithValue:_flightStusModel.arrDoneNormal
                                                          color:[CommonFunction colorFromHex:0xFF00B0D8]
                                                    description:[NSString stringWithFormat:@"%@:%d",@"已执行",_flightStusModel.arrDoneNormal]]];
        if (_flightStusModel.arrCancel>0) {
            [array addObject: [PNPieChartDataItem dataItemWithValue:interval
                                                              color:[UIColor clearColor]]];
        }

        [array addObject: [PNPieChartDataItem dataItemWithValue:_flightStusModel.arrCancel
                                                          color:[CommonFunction colorFromHex:0xFFFF4D62]
                                                    description:[NSString stringWithFormat:@"%@   :%d",@"取消",_flightStusModel.arrCancel]]];
        if (_flightStusModel.arrPlanNormal>0) {
            [array addObject: [PNPieChartDataItem dataItemWithValue:interval
                                                              color:[UIColor clearColor]]];
        }
        [array addObject: [PNPieChartDataItem dataItemWithValue:_flightStusModel.arrPlanNormal
                                                          color:[CommonFunction colorFromHex:0xFFC8C8C8]
                                                    description:[NSString stringWithFormat:@"%@:%d",@"未执行",_flightStusModel.arrPlanNormal]]];

    }else{
        [array removeAllObjects];

        //间隔块大小
        float interval = (_flightStusModel.depDelay +_flightStusModel.depDoneNormal + _flightStusModel.depCancel + _flightStusModel.depPlanNormal)/360.0 *5;

        if (_flightStusModel.depDelay>0) {
            [array addObject: [PNPieChartDataItem dataItemWithValue:interval
                                                              color:[UIColor clearColor]]];
        }

        [array addObject: [PNPieChartDataItem dataItemWithValue:_flightStusModel.depDelay
                                                          color:[CommonFunction colorFromHex:0xFFFFCD21]
                                                    description:[NSString stringWithFormat:@"%@   :%d",@"延误",_flightStusModel.depDelay]]];
        if (_flightStusModel.depDoneNormal>0) {
            [array addObject: [PNPieChartDataItem dataItemWithValue:interval
                                                              color:[UIColor clearColor]]];
        }

        [array addObject: [PNPieChartDataItem dataItemWithValue:_flightStusModel.depDoneNormal
                                                          color:[CommonFunction colorFromHex:0xFF00B0D8]
                                                    description:[NSString stringWithFormat:@"%@:%d",@"已执行",_flightStusModel.depDoneNormal]]];
        if (_flightStusModel.depCancel>0) {
            [array addObject: [PNPieChartDataItem dataItemWithValue:interval
                                                              color:[UIColor clearColor]]];
        }
        [array addObject: [PNPieChartDataItem dataItemWithValue:_flightStusModel.depCancel
                                                          color:[CommonFunction colorFromHex:0xFFFF4D62]
                                                    description:[NSString stringWithFormat:@"%@   :%d",@"取消",_flightStusModel.depCancel]]];
        if (_flightStusModel.depPlanNormal>0) {
            [array addObject: [PNPieChartDataItem dataItemWithValue:interval
                                                              color:[UIColor clearColor]]];
        }
        [array addObject: [PNPieChartDataItem dataItemWithValue:_flightStusModel.depPlanNormal
                                                          color:[CommonFunction colorFromHex:0xFFC8C8C8]
                                                    description:[NSString stringWithFormat:@"%@:%d",@"未执行",_flightStusModel.depPlanNormal]]];

    }

}

-(void) buttonClickedWithSender:(UIButton *)sender
{
    depFlightBackgroundImageView.image = nil;
    arrFlightBackgroundImageView.image = nil;

    switch (sender.tag)
    {
        case 0:
        {
            depFlightBackgroundImageView.image  = [UIImage imageNamed:@"SegmentedLeft"];
            arrFlightLabel.textColor            = [CommonFunction colorFromHex:0xFF17B9E8];
            depFlightLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            NSMutableAttributedString *delayAttributeString = [[NSMutableAttributedString alloc ] initWithString:[NSString stringWithFormat:@"延误 %d",_flightStusModel.depDelay]];
            [delayAttributeString addAttribute:NSFontAttributeName
                                         value:[UIFont fontWithName:@"PingFangSC-Regular" size:13]
                                         range:NSMakeRange(0, 2)];
            delay.attributedText = delayAttributeString;


            NSMutableAttributedString *cancelAttributeString = [[NSMutableAttributedString alloc ]
                                                                initWithString:[NSString stringWithFormat:@"取消 %d",_flightStusModel.depCancel]];
            [cancelAttributeString addAttribute:NSFontAttributeName
                                          value:[UIFont fontWithName:@"PingFangSC-Regular" size:13]
                                          range:NSMakeRange(0, 2)];
            cancel.attributedText = cancelAttributeString;

            abnButton.enabled = YES;
            abnLabel.textColor = [UIColor whiteColor];
            [self updateShapeArray:depShapeArray];

            break;
        }
        case 1:
        {
            arrFlightBackgroundImageView.image = [UIImage imageNamed:@"SegmentedRight"];
            depFlightLabel.textColor = [CommonFunction colorFromHex:0xFF17B9E8];
            arrFlightLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];
            [scrollView setContentOffset:CGPointMake(viewWidth(scrollView), 0) animated:YES];
            NSMutableAttributedString *delayAttributeString = [[NSMutableAttributedString alloc ] initWithString:[NSString stringWithFormat:@"延误 %d",_flightStusModel.arrDelay]];
            [delayAttributeString addAttribute:NSFontAttributeName
                                         value:[UIFont fontWithName:@"PingFangSC-Regular" size:13]
                                         range:NSMakeRange(0, 2)];
            delay.attributedText = delayAttributeString;

            NSMutableAttributedString *cancelAttributeString = [[NSMutableAttributedString alloc ]
                                                                initWithString:[NSString stringWithFormat:@"取消 %d",_flightStusModel.arrCancel]];
            [cancelAttributeString addAttribute:NSFontAttributeName
                                          value:[UIFont fontWithName:@"PingFangSC-Regular" size:13]
                                          range:NSMakeRange(0, 2)];
            cancel.attributedText = cancelAttributeString;

            abnButton.enabled = NO;
            abnLabel.textColor = [CommonFunction colorFromHex:0xffb3b3b3];
            [self updateShapeArray:arrShapeArray];

            break;
        }

        default:
            break;
    }
}


/**
 *  滑动page时的回调
 *
 *  @param scrollview 滑动视图
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollview
{

    if (scrollview.contentOffset.x== 0) {
        [self buttonClickedWithSender:depFlightButton];
    }else{
        [self buttonClickedWithSender:arrFlightButton];
    }
}

-(void)loadData:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[FlightStusModel class]]) {

        if(!arrInNum ||[arrInNum.text isEqualToString:@""] ||[arrInNum.text isEqualToString:@"0"]){
            _flightStusModel = notification.object;
            arrInNum.text    = @(_flightStusModel.arrCount).stringValue;
            depOutNum.text   = @(_flightStusModel.depCount).stringValue;

            NSInteger Delay = 0;
            NSInteger Cancel = 0;
            if (scrollView.contentOffset.x == 0) {
                Delay = _flightStusModel.depDelay;
                Cancel = _flightStusModel.depCancel;
            }else{
                Delay = _flightStusModel.arrDelay;
                Cancel = _flightStusModel.arrCancel;

            }
            NSMutableAttributedString *delayAttributeString = [[NSMutableAttributedString alloc ] initWithString:[NSString stringWithFormat:@"延误 %ld",(long)Delay]];
            [delayAttributeString addAttribute:NSFontAttributeName
                                         value:[UIFont fontWithName:@"PingFangSC-Regular" size:13]
                                         range:NSMakeRange(0, 2)];
            delay.attributedText = delayAttributeString;

            NSMutableAttributedString *cancelAttributeString = [[NSMutableAttributedString alloc ]
                                                                initWithString:[NSString stringWithFormat:@"取消 %ld",(long)Cancel]];
            [cancelAttributeString addAttribute:NSFontAttributeName
                                          value:[UIFont fontWithName:@"PingFangSC-Regular" size:13]
                                          range:NSMakeRange(0, 2)];
            cancel.attributedText = cancelAttributeString;

            totalNum.text = @(_flightStusModel.flightCount).stringValue;
            arrNum.text = @(_flightStusModel.arrCount).stringValue;
            
            [self updateShapeArray:arrShapeArray];
            [self updateShapeArray:depShapeArray];

        }

    }
}
@end
