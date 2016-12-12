//
//  FlightAbnViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightAbnViewController.h"
#import "FlightStusModel.h"
#import "HomePageService.h"

@interface FlightAbnViewController ()
//@property (nonatomic, strong) FlightStusModel *flightHourModel;

@end

@implementation FlightAbnViewController
{
    UIPageControl   *pageControl;
    UIView          *segmentedView;
    UIView          *abnormalView;
    UIImageView     *abnBackgroundImageView;
    UILabel         *abnLabel;
    UIView          *delayView;
    UIImageView     *delayBackgroundImageView;
    UILabel         *delayLabel;
    UIScrollView    *scrollView;
    UIButton        *abnsButton;
    UIButton        *delayButton;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initTitle];

    float y =65+ px_px_2_3(19, 43);
    segmentedView = [[UIView alloc]initWithFrame:CGRectMake(10,
                                                            y,
                                                            kScreenWidth-2*10,
                                                            34)];
    [self.view addSubview:segmentedView];
    UIImageView *segmentedBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                             0,
                                                                                             viewWidth(segmentedView),
                                                                                             viewHeight(segmentedView))];
    segmentedBackgroundImageView.image = [UIImage imageNamed:@"segmentedBackground"];
    [segmentedView addSubview:segmentedBackgroundImageView];
    abnormalView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            viewWidth(segmentedView)/2,
                                                            viewHeight(segmentedView))];
    [segmentedView addSubview:abnormalView];


    abnBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                          0,
                                                                          viewWidth(abnormalView),
                                                                          viewHeight(abnormalView))];
    abnBackgroundImageView.image = [UIImage imageNamed:@"SegmentedLeft"];
    [abnormalView addSubview:abnBackgroundImageView];

    abnLabel = [CommonFunction addLabelFrame:CGRectMake(0,
                                                        0,
                                                        viewWidth(abnormalView) ,
                                                        viewHeight(abnormalView))
                                        text:@"异常原因"
                                        font:33/2
                               textAlignment:(NSTextAlignmentCenter)
                                colorFromHex:0xFFFFFFFF];
    [abnormalView addSubview:abnLabel];

    abnsButton = [[UIButton alloc] initWithFrame:abnLabel.frame];
    [abnsButton addTarget:self
                   action:@selector(buttonClickedWithSender:)
         forControlEvents:(UIControlEventTouchUpInside)];
    abnsButton.tag = 0;
    [abnormalView addSubview:abnsButton];

    delayView = [[UIView alloc ] initWithFrame:CGRectMake(viewWidth(abnormalView),
                                                          0,
                                                          viewWidth(abnormalView),
                                                          viewHeight(abnormalView))];
    [segmentedView addSubview:delayView];

    delayBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            viewWidth(delayView),
                                                                            viewHeight(delayView))];
    delayBackgroundImageView.image = nil;
    [delayView addSubview:delayBackgroundImageView];

    delayLabel = [CommonFunction addLabelFrame:CGRectMake(0,
                                                          0,
                                                          viewWidth(delayView),
                                                          viewHeight(delayView))
                                          text:@"区域平均延误时间"
                                          font:33/2
                                 textAlignment:(NSTextAlignmentCenter)
                                  colorFromHex:0xFF17B9E8];
    [delayView addSubview:delayLabel];

    delayButton = [[UIButton alloc] initWithFrame:delayLabel.frame];
    [delayButton addTarget:self
                    action:@selector(buttonClickedWithSender:)
          forControlEvents:(UIControlEventTouchUpInside)];
    delayButton.tag = 1;
    [delayView addSubview:delayButton];


    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                viewBotton(segmentedView)+px_px_2_3(26, 43),
                                                                kScreenWidth,
                                                                kScreenHeight-viewBotton(segmentedView)-40)];
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*2, scrollView.frame.size.height) ;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];

    AbnormalReasonView *abnView = [[AbnormalReasonView alloc] initWithFrame:CGRectMake(0,
                                                                                       0,
                                                                                       scrollView.frame.size.width,
                                                                                       scrollView.frame.size.height)
                                                                  dataArray:[HomePageService sharedHomePageService].flightModel.abnReasons];
    [scrollView addSubview:abnView];
    
    AreaDelayTimeView *dlyView = [[AreaDelayTimeView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width,
                                                                                     0,
                                                                                     scrollView.frame.size.width,
                                                                                     scrollView.frame.size.height)
                                                                dataArray:[HomePageService sharedHomePageService].flightModel.regionDlyTimes];
    [scrollView addSubview:dlyView];
    
//    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight-40, kScreenWidth, 40)];
//    pageControl.numberOfPages = 2;
//    pageControl.userInteractionEnabled = NO;
//    pageControl.pageIndicatorTintColor = [CommonFunction colorFromHex:0X5F16C1F4];
//    pageControl.currentPageIndicatorTintColor = [CommonFunction colorFromHex:0XFF16C1F4];
//    [self.view addSubview:pageControl];
}

-(void) initTitle
{
    [self titleViewInitWithHight:65];
    [self titleViewAddTitleText:@"航班异常分析"];
    
    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      kScreenWidth,
                                                                      65)];
    self.titleView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];
    [self titleViewAddBackBtn];
}


-(void) buttonClickedWithSender:(UIButton *)sender
{
    abnBackgroundImageView.image = nil;
    delayBackgroundImageView.image = nil;

    switch (sender.tag)
    {
        case 0:
            abnBackgroundImageView.image = [UIImage imageNamed:@"SegmentedLeft"];
            delayLabel.textColor = [CommonFunction colorFromHex:0xFF17B9E8];
            abnLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//            [self showTenDayRatioView];
            break;

        case 1:
            delayBackgroundImageView.image = [UIImage imageNamed:@"SegmentedRight"];
            abnLabel.textColor = [CommonFunction colorFromHex:0xFF17B9E8];
            delayLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];
            [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0) animated:YES];
//            [self showEightMonthRatioView];
            break;

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
//    NSInteger page = scrollView.contentOffset.x/kScreenWidth;
//    NSLog(@"%ld",page);
//    [pageControl setCurrentPage:page];
//    if (page == 0)
//    {
//        
//    }
//    else if (page == 1)
//    {
//        
//    }
    if (scrollview.contentOffset.x==0) {
        [self buttonClickedWithSender:abnsButton];
    }else{
        [self buttonClickedWithSender:delayButton];
    }
}




@end
