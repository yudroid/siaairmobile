//
//  PassengerContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PassengerContentView.h"
#import "UIView+Toast.h"
#import "PassengerModel.h"
#import "HomePageService.h"
@interface  PassengerContentView()

@property (nonatomic ,strong) PassengerModel *passengermodel;
@property (nonatomic ,weak) id<PassengerContentViewDelegate>    delegate;

@end

@implementation PassengerContentView{
    UIPageControl                       *pageControl;
    PsnGeneralContentView               *psnGeneral;
    PsnSafetyContentView                *psnSafety;

}


-(instancetype)initWithFrame:(CGRect)frame
              PassengerModel:(PassengerModel *)passengermodel
                    delegate:(id<PassengerContentViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    
    if(self){

        _passengermodel             = passengermodel;
        _delegate                   = delegate;
        CGFloat width               =  frame.size.width;
        CGFloat height              = frame.size.height;
        UIScrollView *scrollView    = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        scrollView.delegate         = self;
        scrollView.contentSize      = CGSizeMake(width*2, height-50);
        scrollView.backgroundColor  = [UIColor clearColor];
        scrollView.pagingEnabled    = YES;
        scrollView.showsHorizontalScrollIndicator   = NO;
        scrollView.showsVerticalScrollIndicator     = NO;
        [self addSubview:scrollView];

        psnGeneral = [[PsnGeneralContentView alloc] initWithFrame:CGRectMake(0, 0, width, height)
                                                   passengerModel:[HomePageService sharedHomePageService].psnModel];
        [scrollView addSubview:psnGeneral];

//        UIButton *psnHourBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2, 200+30, kScreenWidth/2-20, 90)];
//        [psnHourBtn addTarget:self
//                       action:@selector(showPassengerHourView:)
//             forControlEvents:(UIControlEventTouchUpInside)];
//        [scrollView addSubview:psnHourBtn];
//
//        UIButton *showSafeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 200+30+30+30+90, kScreenWidth-40, 30)];
//        showSafeBtn.backgroundColor = [UIColor blackColor];
//        [showSafeBtn addTarget:self action:@selector(showSafetyPassenger:) forControlEvents:UIControlEventTouchUpInside];
//        [scrollView addSubview:showSafeBtn];
        
        psnSafety = [[PsnSafetyContentView alloc] initWithFrame:CGRectMake(width, 0, width, height)
                                                      dataArray:_passengermodel.psnOnPlane];
        [scrollView addSubview:psnSafety];
        
//        UIButton *showTopBtn = [[UIButton alloc] initWithFrame:CGRectMake(width+20, 200+30+30+10+30+10+90, kScreenWidth-40, 30)];
//        showTopBtn.backgroundColor = [UIColor redColor];
//        [showTopBtn addTarget:self action:@selector(showTop5DaysView:) forControlEvents:UIControlEventTouchUpInside];
//        [scrollView addSubview:showTopBtn];

        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
        pageControl.center                  = CGPointMake(width/2, height-15);
        pageControl.numberOfPages           = 2;
        pageControl.userInteractionEnabled  = NO;
        pageControl.pageIndicatorTintColor  = [CommonFunction colorFromHex:0X5F16C1F4];
        pageControl.currentPageIndicatorTintColor = [CommonFunction colorFromHex:0XFF16C1F4];
//        pageControl.backgroundColor = [UIColor blueColor];
        [self addSubview:pageControl];//四个按钮

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showSafetyPassenger:)
                                                     name:@"showSafetyPassenger"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showTop5DaysView:)
                                                     name:@"showTop5DaysView"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showPassengerHourView:)
                                                     name:@"showPassengerHourView"
                                                   object:nil];
    }
    
    return self;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"showSafetyPassenger"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"showTop5DaysView"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"showPassengerHourView"
                                                  object:nil];
}

-(void) showPassengerHourView:(UIButton *)sender
{
    [_delegate showPassengerHourView];
}

-(void) showSafetyPassenger:(UIButton *)sender
{
    [_delegate showSecurityPassengerView];
}

-(void) showTop5DaysView:(UIButton *)sender
{
    [_delegate showTop5DaysView];
}

/**
 *  滑动page时的回调
 *
 *  @param scrollView <#scrollView description#>
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
