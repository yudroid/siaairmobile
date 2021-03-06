//
//  SecurityPsnViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "SecurityPsnViewController.h"
#import "PsnSafetyAreaView.h"
#import "PsnSafetyHourView.h"
#import "PassengerModel.h"

@interface SecurityPsnViewController ()

@property (nonatomic ,strong) PassengerModel *passengerModel;

@end

@implementation SecurityPsnViewController
{
    UIPageControl *pageControl;
}

-(instancetype)initWithPassengerModel:(id)passengerModel
{
    self = [super init];
    if (self) {
        _passengerModel = passengerModel;
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
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*2, scrollView.frame.size.height) ;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    PsnSafetyHourView *safetyView = [[PsnSafetyHourView alloc] initWithFrame:CGRectMake(0,
                                                                                        0,
                                                                                        scrollView.frame.size.width,
                                                                                        scrollView.frame.size.height)];

    [scrollView addSubview:safetyView];
    
    PsnSafetyAreaView *areaView = [[PsnSafetyAreaView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width,
                                                                                      0,
                                                                                      scrollView.frame.size.width,
                                                                                      scrollView.frame.size.height)
                                                                 nearArray:_passengerModel.psnNearAreas farArray:_passengerModel.psnFarAreas ];
                                                                
    [scrollView addSubview:areaView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,
                                                                  kScreenHeight-40,
                                                                  kScreenWidth,
                                                                  40)];
    pageControl.numberOfPages = 2;
    pageControl.userInteractionEnabled = NO;
    pageControl.pageIndicatorTintColor = [CommonFunction colorFromHex:0X5F16C1F4];
    pageControl.currentPageIndicatorTintColor = [CommonFunction colorFromHex:0XFF16C1F4];
    [self.view addSubview:pageControl];

}

-(void)initTitle
{
    [self titleViewInitWithHight:65];
    [self titleViewAddTitleText:@"隔离区分布图"];
    
    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      kScreenWidth,
                                                                      65)];
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



@end
