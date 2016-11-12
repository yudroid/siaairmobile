//
//  FlightAbnViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightAbnViewController.h"

@interface FlightAbnViewController ()

@end

@implementation FlightAbnViewController
{
    UIPageControl *pageControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initTitle];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 65+10, kScreenWidth, kScreenHeight-(65+10)-40)];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*2, scrollView.frame.size.height) ;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    AbnormalReasonView *abnView = [[AbnormalReasonView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
    [scrollView addSubview:abnView];
    
    AreaDelayTimeView *dlyView = [[AreaDelayTimeView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
    [scrollView addSubview:dlyView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight-40, kScreenWidth, 40)];
    pageControl.numberOfPages = 2;
    pageControl.userInteractionEnabled = NO;
    pageControl.pageIndicatorTintColor = [CommonFunction colorFromHex:0X5F16C1F4];
    pageControl.currentPageIndicatorTintColor = [CommonFunction colorFromHex:0XFF16C1F4];
    [self.view addSubview:pageControl];
}

-(void) initTitle
{
    [self titleViewInitWithHight:65];
    [self titleViewAddTitleText:@"航班异常分析"];
    
    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 65)];
    self.titleView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];
    
    [self titleViewAddBackBtn];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
