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
//    UIPageControl                       *pageControl;
    PsnGeneralContentView               *psnGeneral;
    PsnSafetyContentView                *psnSafety;
    UIView                              *segmentedView;
    UIView                              *tenDayImageView;
    UIImageView                         *tenDayBackgroundImageView;
    UILabel                             *tenDayLabel;
    UIView                              *eightMonthImageView;
    UIImageView                         *eightMonthBackgroundImageView;
    UILabel                             *eightMonthLabel;
    UIScrollView                        *scrollView ;
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
        CGFloat height              = frame.size.height-34-6-6;
        scrollView    = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 34+6+6, width, height)];
        scrollView.delegate         = self;
        scrollView.contentSize      = CGSizeMake(width*2, height-50);
        scrollView.backgroundColor  = [UIColor clearColor];
        scrollView.pagingEnabled    = YES;
        scrollView.showsHorizontalScrollIndicator   = NO;
        scrollView.showsVerticalScrollIndicator     = NO;
        [self addSubview:scrollView];

        psnGeneral = [[PsnGeneralContentView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [scrollView addSubview:psnGeneral];


        segmentedView = [[UIView alloc]initWithFrame:CGRectMake(10,
                                                                6,
                                                                kScreenWidth-2*10,
                                                                34)];
        [self addSubview:segmentedView];
        UIImageView *segmentedBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                                 0,
                                                                                                 viewWidth(segmentedView),
                                                                                                 viewHeight(segmentedView))];
        segmentedBackgroundImageView.image = [UIImage imageNamed:@"segmentedBackground"];
        [segmentedView addSubview:segmentedBackgroundImageView];
        tenDayImageView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   viewWidth(segmentedView)/2,
                                                                   viewHeight(segmentedView))];
        [segmentedView addSubview:tenDayImageView];


        tenDayBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                 0,
                                                                                 viewWidth(tenDayImageView),
                                                                                 viewHeight(tenDayImageView))];
        tenDayBackgroundImageView.image = [UIImage imageNamed:@"SegmentedLeft"];
        [tenDayImageView addSubview:tenDayBackgroundImageView];

        tenDayLabel = [CommonFunction addLabelFrame:CGRectMake(0,
                                                               0,
                                                               viewWidth(tenDayImageView) ,
                                                               viewHeight(tenDayImageView))
                                               text:@"旅客进出港统计"
                                               font:33/2
                                      textAlignment:(NSTextAlignmentCenter)
                                       colorFromHex:0xFFFFFFFF];
        [tenDayImageView addSubview:tenDayLabel];

        UIButton *tenDayButton = [[UIButton alloc] initWithFrame:tenDayLabel.frame];
        [tenDayButton addTarget:self
                         action:@selector(buttonClickedWithSender:)
               forControlEvents:(UIControlEventTouchUpInside)];
        tenDayButton.tag = 0;
        [tenDayImageView addSubview:tenDayButton];


        eightMonthImageView = [[UIView alloc ] initWithFrame:CGRectMake(viewWidth(tenDayImageView),
                                                                        0,
                                                                        viewWidth(tenDayImageView),
                                                                        viewHeight(tenDayImageView))];
        [segmentedView addSubview:eightMonthImageView];
        //背景
        eightMonthBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                     0,
                                                                                     viewWidth(eightMonthImageView),
                                                                                     viewHeight(eightMonthImageView))];
        eightMonthBackgroundImageView.image = nil;
        [eightMonthImageView addSubview:eightMonthBackgroundImageView];

        eightMonthLabel = [CommonFunction addLabelFrame:CGRectMake(0,
                                                                   0,
                                                                   viewWidth(tenDayLabel),
                                                                   viewHeight(tenDayLabel))
                                                   text:@"机上等待时间"
                                                   font:33/2
                                          textAlignment:(NSTextAlignmentCenter)
                                           colorFromHex:0xFF17B9E8];
        [eightMonthImageView addSubview:eightMonthLabel];

        UIButton *eightMonthButton = [[UIButton alloc] initWithFrame:eightMonthLabel.frame];
        [eightMonthButton addTarget:self
                             action:@selector(buttonClickedWithSender:)
                   forControlEvents:(UIControlEventTouchUpInside)];
        eightMonthButton.tag = 1;
        [eightMonthImageView addSubview:eightMonthButton];
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
        
        psnSafety = [[PsnSafetyContentView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
        [scrollView addSubview:psnSafety];
        
//        UIButton *showTopBtn = [[UIButton alloc] initWithFrame:CGRectMake(width+20, 200+30+30+10+30+10+90, kScreenWidth-40, 30)];
//        showTopBtn.backgroundColor = [UIColor redColor];
//        [showTopBtn addTarget:self action:@selector(showTop5DaysView:) forControlEvents:UIControlEventTouchUpInside];
//        [scrollView addSubview:showTopBtn];

//        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, width, 30)];
//        pageControl.center                  = CGPointMake(width/2, height-15);
//        pageControl.numberOfPages           = 2;
//        pageControl.userInteractionEnabled  = NO;
//        pageControl.pageIndicatorTintColor  = [CommonFunction colorFromHex:0X5F16C1F4];
//        pageControl.currentPageIndicatorTintColor = [CommonFunction colorFromHex:0XFF16C1F4];
//        pageControl.backgroundColor = [UIColor blueColor];
//        [self addSubview:pageControl];//四个按钮

        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:@"showSafetyPassenger"
                                                      object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:@"showTop5DaysView"
                                                      object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:@"showPassengerHourView"
                                                      object:nil];

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

-(void) buttonClickedWithSender:(UIButton *)sender
{
    tenDayBackgroundImageView.image = nil;
    eightMonthBackgroundImageView.image = nil;

    switch (sender.tag)
    {
        case 0:
            tenDayBackgroundImageView.image = [UIImage imageNamed:@"SegmentedLeft"];
            eightMonthLabel.textColor = [CommonFunction colorFromHex:0xFF17B9E8];
            tenDayLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];

            [self showTenDayRatioView];
            break;

        case 1:
            eightMonthBackgroundImageView.image = [UIImage imageNamed:@"SegmentedRight"];
            tenDayLabel.textColor = [CommonFunction colorFromHex:0xFF17B9E8];
            eightMonthLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];
            [self showEightMonthRatioView];
            break;

        default:
            break;
    }
}

-(void) showTenDayRatioView
{
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentOffset = CGPointMake(0, 0);

    }];


}

-(void) showEightMonthRatioView
{
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
        
    }];
    
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
    if (scrollView.contentOffset.x== 0) {
        tenDayBackgroundImageView.image = [UIImage imageNamed:@"SegmentedLeft"];
        eightMonthBackgroundImageView.image = [UIImage imageNamed:@""];
        eightMonthLabel.textColor = [CommonFunction colorFromHex:0xFF17B9E8];
        tenDayLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];
        [self showTenDayRatioView];

    }else{
        eightMonthBackgroundImageView.image = [UIImage imageNamed:@"SegmentedRight"];
        tenDayBackgroundImageView.image = [UIImage imageNamed:@""];
        tenDayLabel.textColor = [CommonFunction colorFromHex:0xFF17B9E8];
        eightMonthLabel.textColor = [CommonFunction colorFromHex:0xFFFFFFFF];
        [self showEightMonthRatioView];
    }
}
@end
