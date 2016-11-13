//
//  FlightContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightContentView.h"

@implementation FlightContentView
{
    UIView *segmentedView;
    UIView *depFlightImageView;
    UIImageView *depFlightBackgroundImageView;
    UILabel *depFlightLabel;
    UIView *arrFlightImageView;
    UIImageView *arrFlightBackgroundImageView;
    UILabel *arrFlightLabel;
}

-(instancetype)initWithFrame:(CGRect)frame delegate:(id<FlightContentViewDelegate>)delegate
{
    self = [super initWithFrame:frame];

    if(self){
        
        _delegate = delegate;
        
        arrShapeArray = [[NSMutableArray alloc] init];
        depShapeArray = [[NSMutableArray alloc] init];

        float y = 0;
        segmentedView = [[UIView alloc]initWithFrame:CGRectMake(10, y, kScreenWidth-2*10, 34)];
        [self addSubview:segmentedView];
        UIImageView *segmentedBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(segmentedView), viewHeight(segmentedView))];
        segmentedBackgroundImageView.image = [UIImage imageNamed:@"segmentedBackground"];
        [segmentedView addSubview:segmentedBackgroundImageView];
        depFlightImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth(segmentedView)/2, viewHeight(segmentedView))];
        [segmentedView addSubview:depFlightImageView];


        depFlightBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(depFlightImageView), viewHeight(depFlightImageView))];
        depFlightBackgroundImageView.image = [UIImage imageNamed:@"SegmentedLeft"];
        [depFlightImageView addSubview:depFlightBackgroundImageView];

        depFlightLabel = [CommonFunction addLabelFrame:CGRectMake(0, 0, viewWidth(depFlightImageView) , viewHeight(depFlightImageView)) text:@"出港航班" font:33/2 textAlignment:(NSTextAlignmentCenter) colorFromHex:0xFFFFFFFF];
        [depFlightImageView addSubview:depFlightLabel];

        UIButton *depFlightButton = [[UIButton alloc] initWithFrame:depFlightLabel.frame];
        [depFlightButton addTarget:self action:@selector(buttonClickedWithSender:) forControlEvents:(UIControlEventTouchUpInside)];
        depFlightButton.tag = 0;
        [depFlightImageView addSubview:depFlightButton];

        arrFlightImageView = [[UIView alloc ] initWithFrame:CGRectMake(viewWidth(depFlightImageView), 0, viewWidth(depFlightImageView), viewHeight(depFlightImageView))];
        [segmentedView addSubview:arrFlightImageView];

        arrFlightBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(arrFlightImageView), viewHeight(arrFlightImageView))];
        arrFlightBackgroundImageView.image = nil;
        [arrFlightImageView addSubview:arrFlightBackgroundImageView];

        arrFlightLabel = [CommonFunction addLabelFrame:CGRectMake(0, 0, viewWidth(depFlightLabel), viewHeight(depFlightLabel)) text:@"进港航班" font:33/2 textAlignment:(NSTextAlignmentCenter) colorFromHex:0xFF17B9E8];
        [arrFlightImageView addSubview:arrFlightLabel];

        UIButton *arrFlightButton = [[UIButton alloc] initWithFrame:arrFlightLabel.frame];
        [arrFlightButton addTarget:self action:@selector(buttonClickedWithSender:) forControlEvents:(UIControlEventTouchUpInside)];
        arrFlightButton.tag = 1;
        [arrFlightImageView addSubview:arrFlightButton];

        UILabel *explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth(self)-90-15, viewBotton(segmentedView)+20, 90, 11)];
        explainLabel.text = @"即将出港航班";
        explainLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:27/2];
        explainLabel.textColor = [CommonFunction colorFromHex:0xFFFFCD21];
        [self addSubview:explainLabel];

        UIImageView *explainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(explainLabel)-4-10, viewY(explainLabel), 10, 10)];
        explainImageView.image = [UIImage imageNamed:@"Completed"];
        [self addSubview:explainImageView];

        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, viewBotton(explainImageView)+20, frame.size.width, 250)];
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(frame.size.width*2, 250);
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];

        [self updateShapeArray:arrShapeArray];
        [self updateShapeArray:depShapeArray];

        PNPieChart *arrRoundProgress = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, 220, 220) items:arrShapeArray];
        arrRoundProgress.center = CGPointMake(frame.size.width/2, 250/2);
        arrRoundProgress.descriptionTextColor = [UIColor whiteColor];
        arrRoundProgress.descriptionTextFont  = [UIFont fontWithName:@"PingFangSC-Regular" size:29/2];
        arrRoundProgress.descriptionTextShadowColor = [UIColor clearColor];
        arrRoundProgress.showAbsoluteValues = YES;
        arrRoundProgress.showOnlyValues = YES;
        [arrRoundProgress strokeChart];
        arrRoundProgress.legendStyle = PNLegendItemStyleStacked;
        arrRoundProgress.legendFont = [UIFont fontWithName:@"PingFangSC-Regular" size:9];
        arrRoundProgress.legendFontColor = [CommonFunction colorFromHex:0xff595757];
        [scrollView addSubview:arrRoundProgress];

        



        
        UIView *legend = [arrRoundProgress getLegendWithMaxWidth:200];
        [legend setFrame:CGRectMake(frame.size.width-legend.frame.size.width-20, 250/2+250-legend.frame.size.height, legend.frame.size.width, legend.frame.size.height)];
        [self addSubview:legend];
        
        UILabel *arrInNum = [CommonFunction addLabelFrame:CGRectMake(0, (viewHeight(arrRoundProgress)-48)/2-20,viewWidth(arrRoundProgress), 48) text:@"4274" font:30 textAlignment:(NSTextAlignmentCenter) colorFromHex:0xFF0b0b0b];
        arrInNum.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:60];
        [arrRoundProgress addSubview:arrInNum];
        UILabel *arrInLabel = [CommonFunction addLabelFrame:CGRectMake(0, viewBotton(arrInNum)+22, viewWidth(arrRoundProgress), 20) text:@"进港航班" font:18 textAlignment:(NSTextAlignmentCenter) colorFromHex:0xFF00b0d8];
        [arrRoundProgress addSubview:arrInLabel];
        
        UIButton *arrButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 35+20)];
        [arrButton addTarget:self action:@selector(showArrFlightHourView:) forControlEvents:(UIControlEventTouchUpInside)];
        arrButton.center = CGPointMake(frame.size.width/2, 250/2);
        [scrollView addSubview:arrButton];
        
        PNPieChart *depRoundProgress = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, 220, 220) items:depShapeArray];
        depRoundProgress.center = CGPointMake(frame.size.width+frame.size.width/2, 250/2);
        depRoundProgress.descriptionTextColor = [UIColor whiteColor];
        depRoundProgress.descriptionTextFont  = [UIFont fontWithName:@"PingFangSC-Regular" size:29/2];
        depRoundProgress.descriptionTextShadowColor = [UIColor clearColor];
        depRoundProgress.showAbsoluteValues = YES;
        depRoundProgress.showOnlyValues = YES;
        [depRoundProgress strokeChart];
        depRoundProgress.legendStyle = PNLegendItemStyleStacked;
        depRoundProgress.legendFont = [UIFont systemFontOfSize:10];
        [scrollView addSubview:depRoundProgress];
        
        UILabel *depOutNum = [CommonFunction addLabelFrame:CGRectMake(0, (viewHeight(arrRoundProgress)-48)/2-20,viewWidth(arrRoundProgress), 48) text:@"427" font:30 textAlignment:(NSTextAlignmentCenter) colorFromHex:0xFF0B0b0b];
        depOutNum.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:60];
        [depRoundProgress addSubview:depOutNum];
        UILabel *depOutLabel = [CommonFunction addLabelFrame:CGRectMake(0, viewBotton(arrInNum)+22, viewWidth(arrRoundProgress), 20) text:@"出港航班" font:18 textAlignment:(NSTextAlignmentCenter) colorFromHex:0xFF00b0d8];
        [depRoundProgress addSubview:depOutLabel];

        UIButton *depButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 35+20)];
        [depButton addTarget:self action:@selector(showDepFlightHourView:) forControlEvents:(UIControlEventTouchUpInside)];
        depButton.center = CGPointMake(frame.size.width+frame.size.width/2, 250/2);
        [scrollView addSubview:depButton];
        
//        
//        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
//        pageControl.center = CGPointMake(frame.size.width/2, 30+64+25+250+30/2);
//        pageControl.numberOfPages = 2;
//        pageControl.userInteractionEnabled = NO;
//        pageControl.pageIndicatorTintColor = [CommonFunction colorFromHex:0X5F16C1F4];
//        pageControl.currentPageIndicatorTintColor = [CommonFunction colorFromHex:0XFF16C1F4];
//        [self addSubview:pageControl];

        UIView *uiview = [[UIView alloc] initWithFrame:CGRectMake(0, viewBotton(scrollView)+30, viewWidth(self), 48)];

        [self addSubview:uiview];

        UILabel *totalNum = [CommonFunction addLabelFrame:CGRectMake((viewWidth(uiview)-302)/2, 0,100, 28) text:@"852" font:30 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF525151];
        totalNum.font = [UIFont fontWithName:@"PingFangSC-Medium" size:65/2];
        [uiview addSubview:totalNum];

        UILabel *totalLabel = [CommonFunction addLabelFrame:CGRectMake(viewX(totalNum), viewBotton(totalNum)+6, 100, 12) text:@"航班总数" font:20 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF8B8C8C];
        totalLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:31/2];
        [uiview addSubview:totalLabel];

        UIImageView *verticalLineImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(totalNum), 0, 1, viewHeight(uiview))];
        verticalLineImageView1.image = [UIImage imageNamed:@"VerticalLine"];
        [uiview addSubview:verticalLineImageView1];

        UILabel *arrNum = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(verticalLineImageView1), 0, 100, 28) text:@"427" font:30 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF525151];
        arrNum.font = [UIFont fontWithName:@"PingFangSC-Medium" size:65/2];
        [uiview addSubview:arrNum];

        UILabel *arrLabel = [CommonFunction addLabelFrame:CGRectMake(viewX(arrNum), viewBotton(arrNum)+6, 100, 12) text:@"进港航班" font:20 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF8B8C8C];
        arrLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:31/2];
        [uiview addSubview:arrLabel];

        UIImageView *verticalLineImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(arrNum), 0, 1, viewHeight(uiview))];
        verticalLineImageView2.image = [UIImage imageNamed:@"VerticalLine"];
        [uiview addSubview:verticalLineImageView2];

        UILabel *depNum = [CommonFunction addLabelFrame:CGRectMake(viewTrailing(verticalLineImageView2), 0, 100, 30) text:@"425" font:30 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF525151];
        depNum.font = [UIFont fontWithName:@"PingFangSC-Medium" size:65/2];
        [uiview addSubview:depNum];

        UILabel *depLabel = [CommonFunction addLabelFrame:CGRectMake(viewX(depNum), viewBotton(depNum), 100, 12) text:@"出港航班" font:20 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF8B8C8C];
        depLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:31/2];
        [uiview addSubview:depLabel];

        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, viewBotton(uiview)+20, kScreenWidth, 0.5)];
        lineImageView.image = [UIImage imageNamed:@"Line"];
        [self addSubview:lineImageView];
//
//        UIView *abnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//        abnBgView.center = CGPointMake(frame.size.width/6, 30+64+25+250+30+30+30/2);
//        [abnBgView setBackgroundColor:[CommonFunction colorFromHex:0xFFFF4D62]];
//        [abnBgView.layer setCornerRadius:8.0f];
//        abnBgView.backgroundColor = [UIColor blackColor];
//        [self addSubview:abnBgView];

        UIImageView *unusualImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(totalNum)+7.5, viewBotton(lineImageView)+28, 85, 26)];
        unusualImageView.image =  [UIImage imageNamed:@"unusualBackground"];
        [self addSubview:unusualImageView];
        UILabel *abnLabel = [CommonFunction addLabelFrame:CGRectMake(viewX(unusualImageView), viewY(unusualImageView), viewWidth(unusualImageView), viewHeight(unusualImageView)) text:@"异常航班" font:23 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF];
        abnLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:35/2];
        [self addSubview:abnLabel];
        
        UILabel *delay = [CommonFunction addLabelFrame:CGRectMake(viewX(arrNum), viewY(unusualImageView), 100, 30) text:@"延误  " font:13 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF4D4D4D];
        NSMutableAttributedString *delayAttributeString = [[NSMutableAttributedString alloc ] initWithString:@"延误 52"];
        [delayAttributeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:22] range:NSMakeRange(3, 2)];
        delay.attributedText = delayAttributeString;
        [self addSubview:delay];
        
        UILabel *cancel = [CommonFunction addLabelFrame:CGRectMake(viewX(depNum), viewY(unusualImageView), 100, 30) text:@"取消" font:13 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF4D4D4D];
        NSMutableAttributedString *cancelAttributeString = [[NSMutableAttributedString alloc ] initWithString:@"取消 12"];
        [cancelAttributeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:22] range:NSMakeRange(3, 2)];
        cancel.attributedText = cancelAttributeString;
        [self addSubview:cancel];
        
        UIButton *abnButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 30+64+25+250+30+30, frame.size.width, 30)];
        [abnButton addTarget:self action:@selector(showAbnRsnAndDlyTime:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:abnButton];
    }
    return self;
}

-(void) showArrFlightHourView:(UIButton *)sender
{
    [_delegate showFlightHourView:(ArrFlightHour)];
}

-(void) showDepFlightHourView:(UIButton *)sender
{
    [_delegate showFlightHourView:(DepFlightHour)];
}

-(void) showAbnRsnAndDlyTime:(UIButton *)sender
{
    [_delegate showFlightAbnnormalView];
}

-(void) updateShapeArray:(NSMutableArray *)array
{
    [array removeAllObjects];
    [array addObject: [PNPieChartDataItem dataItemWithValue:2 color:[UIColor clearColor]]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:12 color:[CommonFunction colorFromHex:0xFFFFCD21] description:@"延误"]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:32 color:[CommonFunction colorFromHex:0xFF00B0D8] description:@"已执行"]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:2 color:[UIColor clearColor]]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:8 color:[CommonFunction colorFromHex:0xFFFF4D62] description:@"取消"]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:2 color:[UIColor clearColor]]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:32 color:[CommonFunction colorFromHex:0xFFC8C8C8] description:@"未执行"]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:10 color:[CommonFunction colorFromHex:0xFFFFCD21]]];
}

-(void) buttonClickedWithSender:(UIButton *)sender
{
    depFlightBackgroundImageView.image = nil;
    arrFlightBackgroundImageView.image = nil;

    switch (sender.tag)
    {
        case 0:
            depFlightBackgroundImageView.image = [UIImage imageNamed:@"SegmentedLeft"];
            arrFlightLabel.textColor = [CommonFunction colorFromHex:0xFF17B9E8];
            depFlightLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];

//            [self showTenDayRatioView];
            break;

        case 1:
            arrFlightBackgroundImageView.image = [UIImage imageNamed:@"SegmentedRight"];
            depFlightLabel.textColor = [CommonFunction colorFromHex:0xFF17B9E8];
            arrFlightLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];
//            [self showEightMonthRatioView];
            break;

        default:
            break;
    }
}


/**
 *  滑动page时的回调
 *
 *  @param scrollView 滑动视图
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/kScreenWidth;
    NSLog(@"%ld",page);
    [pageControl setCurrentPage:page];
    if (page == 0)
    {
        
    }
    else if (page == 1)
    {
        
    }
}
@end
