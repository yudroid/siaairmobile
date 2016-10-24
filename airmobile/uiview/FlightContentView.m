//
//  FlightContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightContentView.h"

@implementation FlightContentView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if(self){
        arrShapeArray = [[NSMutableArray alloc] init];
        depShapeArray = [[NSMutableArray alloc] init];
        
        UIView *uiview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 64)];
        uiview.center = CGPointMake(frame.size.width/2, 60);
        [self addSubview:uiview];

        UILabel *totalNum = [CommonFunction addLabelFrame:CGRectMake(0, 0, uiview.frame.size.width/3, 34) text:@"852" font:30 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF4D4D4D];
        [uiview addSubview:totalNum];
        
        UILabel *totalLabel = [CommonFunction addLabelFrame:CGRectMake(0, 0+34+6, uiview.frame.size.width/3, 24) text:@"航班总数" font:20 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF8B8C8C];
        [uiview addSubview:totalLabel];
        
        UILabel *arrNum = [CommonFunction addLabelFrame:CGRectMake(uiview.frame.size.width/3, 0, uiview.frame.size.width/3, 34) text:@"427" font:30 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF4D4D4D];
        [uiview addSubview:arrNum];
        
        UILabel *arrLabel = [CommonFunction addLabelFrame:CGRectMake(uiview.frame.size.width/3, 0+34+6, uiview.frame.size.width/3, 24) text:@"进港航班" font:20 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF8B8C8C];
        [uiview addSubview:arrLabel];
        
        UILabel *depNum = [CommonFunction addLabelFrame:CGRectMake(uiview.frame.size.width*2/3, 0, uiview.frame.size.width/3, 34) text:@"425" font:30 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF4D4D4D];
        [uiview addSubview:depNum];
        
        UILabel *depLabel = [CommonFunction addLabelFrame:CGRectMake(uiview.frame.size.width*2/3, 0+34+6, uiview.frame.size.width/3, 24) text:@"出港航班" font:20 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF8B8C8C];
        [uiview addSubview:depLabel];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30+64+25, frame.size.width, 250)];
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(frame.size.width*2, 250);
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];

        [self updateShapeArray:arrShapeArray];
        [self updateShapeArray:depShapeArray];
        
        PNPieChart *arrRoundProgress = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, 180, 180) items:arrShapeArray];
        arrRoundProgress.center = CGPointMake(frame.size.width/2, 30+64+25);
        arrRoundProgress.descriptionTextColor = [UIColor whiteColor];
        arrRoundProgress.descriptionTextFont  = [UIFont systemFontOfSize:11];
        arrRoundProgress.descriptionTextShadowColor = [UIColor clearColor];
        arrRoundProgress.showAbsoluteValues = YES;
        arrRoundProgress.showOnlyValues = YES;
        [arrRoundProgress strokeChart];
        arrRoundProgress.legendStyle = PNLegendItemStyleStacked;
        arrRoundProgress.legendFont = [UIFont systemFontOfSize:10];
        [scrollView addSubview:arrRoundProgress];
        UIView *legend = [arrRoundProgress getLegendWithMaxWidth:200];
        [legend setFrame:CGRectMake(frame.size.width-legend.frame.size.width-20, 30+64+25+250-legend.frame.size.height, legend.frame.size.width, legend.frame.size.height)];
        [self addSubview:legend];
        
        
        
        PNPieChart *depRoundProgress = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, 180, 180) items:depShapeArray];
        depRoundProgress.center = CGPointMake(frame.size.width+frame.size.width/2, 30+64+25);
        depRoundProgress.descriptionTextColor = [UIColor whiteColor];
        depRoundProgress.descriptionTextFont  = [UIFont systemFontOfSize:11];
        depRoundProgress.descriptionTextShadowColor = [UIColor clearColor];
        depRoundProgress.showAbsoluteValues = YES;
        depRoundProgress.showOnlyValues = YES;
        [depRoundProgress strokeChart];
        depRoundProgress.legendStyle = PNLegendItemStyleStacked;
        depRoundProgress.legendFont = [UIFont systemFontOfSize:10];
        [scrollView addSubview:depRoundProgress];
        UIView *depLegend = [depRoundProgress getLegendWithMaxWidth:200];
        [depLegend setFrame:CGRectMake(frame.size.width-depLegend.frame.size.width-20, 30+64+25+250-depLegend.frame.size.height, depLegend.frame.size.width, depLegend.frame.size.height)];
        [scrollView addSubview:depRoundProgress];
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        pageControl.center = CGPointMake(frame.size.width/2, 30+64+25+250+30/2);
        pageControl.numberOfPages = 2;
        pageControl.userInteractionEnabled = NO;
        pageControl.pageIndicatorTintColor = [CommonFunction colorFromHex:0X5F16C1F4];
        pageControl.currentPageIndicatorTintColor = [CommonFunction colorFromHex:0XFF16C1F4];
        [self addSubview:pageControl];
        
        UIView *abnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        abnBgView.center = CGPointMake(frame.size.width/6, 30+64+25+250+30+30+30/2);
        [abnBgView setBackgroundColor:[CommonFunction colorFromHex:0xFFFF4D62]];
        [abnBgView.layer setCornerRadius:8.0f];
        [self addSubview:abnBgView];
        
        UILabel *abnLabel = [CommonFunction addLabelFrame:CGRectMake(0, 30+64+25+250+30+30, frame.size.width/3, 30) text:@"异常航班" font:23 textAlignment:NSTextAlignmentCenter colorFromHex:0xFFFFFFFF];
        [self addSubview:abnLabel];
        
        UILabel *delay = [CommonFunction addLabelFrame:CGRectMake(frame.size.width/3, 30+64+25+250+30+30, frame.size.width/3, 30) text:@"延误  " font:17 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF4D4D4D];
        NSMutableAttributedString *delayAttributeString = [[NSMutableAttributedString alloc ] initWithString:@"延误 52"];
        [delayAttributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:23] range:NSMakeRange(3, 2)];
        delay.attributedText = delayAttributeString;
        [self addSubview:delay];
        
        UILabel *cancel = [CommonFunction addLabelFrame:CGRectMake(frame.size.width*2/3, 30+64+25+250+30+30, frame.size.width/3, 30) text:@"取消" font:17 textAlignment:NSTextAlignmentCenter colorFromHex:0xFF4D4D4D];
        NSMutableAttributedString *cancelAttributeString = [[NSMutableAttributedString alloc ] initWithString:@"取消 12"];
        [cancelAttributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:23] range:NSMakeRange(3, 2)];
        cancel.attributedText = cancelAttributeString;
        [self addSubview:cancel];
    }
    return self;
}

-(void) updateShapeArray:(NSMutableArray *)array
{
    [array removeAllObjects];
    [array addObject: [PNPieChartDataItem dataItemWithValue:2 color:[UIColor clearColor]]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:12 color:[CommonFunction colorFromHex:0xFFFFCD21] description:@"已执行延误"]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:32 color:[CommonFunction colorFromHex:0xFF00B0D8] description:@"已执行正常"]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:2 color:[UIColor clearColor]]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:8 color:[CommonFunction colorFromHex:0xFFFF4D62] description:@"取消"]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:2 color:[UIColor clearColor]]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:32 color:[CommonFunction colorFromHex:0xFFC8C8C8] description:@"未执行正常"]];
    [array addObject: [PNPieChartDataItem dataItemWithValue:10 color:[CommonFunction colorFromHex:0xFFFFCD21] description:@"未执行延误"]];
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
