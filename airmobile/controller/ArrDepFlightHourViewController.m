//
//  ArrDepFlightHourViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ArrDepFlightHourViewController.h"
#import "FlightHourModel.h"

@interface ArrDepFlightHourViewController ()

@property (nonatomic, copy) NSArray<FlightHourModel*> *dataArray;

@end

@implementation ArrDepFlightHourViewController
{
    UIPageControl *pageControl;
}


-(instancetype)initWithDataArray:(NSArray<FlightHourModel *> *)dataArray
{
    self = [super init];
    if (self) {
        _dataArray = [dataArray copy];
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitle];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                              65+10,
                                                                              kScreenWidth,
                                                                              kScreenHeight-(65+10)-40)];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*2,
                                        scrollView.frame.size.height) ;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    FlightHourView *arrView = [[FlightHourView alloc] initWithFrame:CGRectMake(0,
                                                                               0,
                                                                               scrollView.frame.size.width,
                                                                               scrollView.frame.size.height)
                                                          DataArray:_dataArray
                                                     flightHourType:ArrFlightHour];
    [scrollView addSubview:arrView];
    
    FlightHourView *depView = [[FlightHourView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width,
                                                                               0,
                                                                               scrollView.frame.size.width,
                                                                               scrollView.frame.size.height)
                                                          DataArray:_dataArray
                                                     flightHourType:DepFlightHour];
    [scrollView addSubview:depView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight-40, kScreenWidth, 40)];
    pageControl.numberOfPages = 2;
    pageControl.userInteractionEnabled = NO;
    pageControl.pageIndicatorTintColor = [CommonFunction colorFromHex:0X5F16C1F4];
    pageControl.currentPageIndicatorTintColor = [CommonFunction colorFromHex:0XFF16C1F4];
    [self.view addSubview:pageControl];
    
    if(DepFlightHour == _hourType){
        [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width,
                                                   0,
                                                   scrollView.frame.size.width,
                                                   scrollView.frame.size.height)
                               animated:YES];
        NSInteger page = scrollView.contentOffset.x/kScreenWidth;
        [pageControl setCurrentPage:page];
    }
}

-(void) initTitle
{
    [self titleViewInitWithHight:65];
    [self titleViewAddTitleText:@"航班小时分布图"];
    
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
//    NSLog(@"%ld",(long)page);
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
}

@end
