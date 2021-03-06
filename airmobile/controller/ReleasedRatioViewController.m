//
//  ReleasedRatioViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ReleasedRatioViewController.h"
#import "ReleasedRatioModel.h"
#import "HomePageService.h"
#import "WeekRatioView.h"

@interface ReleasedRatioViewController ()


@end

@implementation ReleasedRatioViewController
{
//    UIImageView *tenDayBackgroundImageView;
//    UIImageView *eightMonthBackgroundImageView;
//    UILabel *tenDayLabel;
//    UILabel *eightMonthLabel;
//    UIView *segmentedView;
    UISegmentedControl *segmentedControl;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitle];
    
//    UIImageView *tenDayImageView = [CommonFunction imageView:nil frame:CGRectMake(0, 0, 120, 35)];
//    tenDayImageView.center = CGPointMake(kScreenWidth/2-120/2, 65+10+35/2);
//    [self.view addSubview:tenDayImageView];
    float y = 15+65;

//    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(10,
//                                                                                              y,
//                                                                                              kScreenWidth-2*10,
//                                                                                              34)];
//    segmentedControl
//
//    [self.view addSubview:segmentedControl];
    NSString *weekString= @"本周放行率";

    NSString *dayString = [HomePageService sharedHomePageService].summaryModel.dayNum;
    if (dayString &&[dayString isKindOfClass:[NSString class]]&& ![dayString isEqualToString:@""]) {
        dayString = [NSString stringWithFormat:@"最近%@天",[HomePageService sharedHomePageService].summaryModel.dayNum];
    }else{
        dayString = [NSString stringWithFormat:@"最近%lu天",(unsigned long)[HomePageService sharedHomePageService].summaryModel.tenDayReleased.count];
    }

    NSString *monthString = [HomePageService sharedHomePageService].summaryModel.month;
    if (monthString &&[monthString isKindOfClass:[NSString class]]&& ![monthString isEqualToString:@""]) {

        monthString = [NSString stringWithFormat:@"最近%@个月",[HomePageService sharedHomePageService].summaryModel.month];
    }else{
        monthString = [NSString stringWithFormat:@"最近%lu个月",(unsigned long)[HomePageService sharedHomePageService].summaryModel.yearReleased.count];
    }

    NSArray *segmentedArray = @[weekString,dayString,monthString];
    //初始化UISegmentedControl
    segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(10,
                                        y,
                                        kScreenWidth-2*10,
                                        34);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [CommonFunction colorFromHex:0xFF3FB9E8];
    [self.view addSubview:segmentedControl];
    [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];

    [self showWeekRatioView];

//    segmentedView = [[UIView alloc]initWithFrame:CGRectMake(10,
//                                                            y,
//                                                            kScreenWidth-2*10,
//                                                            34)];
//    [self.view addSubview:segmentedView];
//    UIImageView *segmentedBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
//                                                                                             0,
//                                                                                             viewWidth(segmentedView),
//                                                                                             viewHeight(segmentedView))];
//    segmentedBackgroundImageView.image = [UIImage imageNamed:@"segmentedBackground"];
//    [segmentedView addSubview:segmentedBackgroundImageView];
//    tenDayImageView = [[UIView alloc] initWithFrame:CGRectMake(0,
//                                                               0,
//                                                               viewWidth(segmentedView)/2,
//                                                               viewHeight(segmentedView))];
//    [segmentedView addSubview:tenDayImageView];
//
//    //10天的背景
//    tenDayBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
//                                                                             0,
//                                                                             viewWidth(tenDayImageView),
//                                                                             viewHeight(tenDayImageView))];
//    tenDayBackgroundImageView.image = [UIImage imageNamed:@"SegmentedLeft"];
//    [tenDayImageView addSubview:tenDayBackgroundImageView];
//    //10天的Label
//
//    NSString *dayString = [HomePageService sharedHomePageService].summaryModel.dayNum;
//    if (dayString &&[dayString isKindOfClass:[NSString class]]&& ![dayString isEqualToString:@""]) {
//        dayString = [NSString stringWithFormat:@"最近%@天",[HomePageService sharedHomePageService].summaryModel.dayNum];
//    }else{
//        dayString = [NSString stringWithFormat:@"最近%lu天",(unsigned long)[HomePageService sharedHomePageService].summaryModel.tenDayReleased.count];
//    }
//    tenDayLabel = [CommonFunction addLabelFrame:CGRectMake(0,
//                                                           0,
//                                                           viewWidth(tenDayImageView) ,
//                                                           viewHeight(tenDayImageView))
//                                           text:dayString
//                                           font:33/2
//                                  textAlignment:(NSTextAlignmentCenter)
//                                   colorFromHex:0xFFFFFFFF];
//    [tenDayImageView addSubview:tenDayLabel];
//
//    UIButton *tenDayButton = [[UIButton alloc] initWithFrame:tenDayLabel.frame];
//    [tenDayButton addTarget:self
//                     action:@selector(buttonClickedWithSender:)
//           forControlEvents:(UIControlEventTouchUpInside)];
//    tenDayButton.tag = 0;
//    [tenDayImageView addSubview:tenDayButton];
//    
//    //最近8个月
//    eightMonthImageView = [[UIView alloc ] initWithFrame:CGRectMake(viewWidth(tenDayImageView),
//                                                                    0,
//                                                                    viewWidth(tenDayImageView),
//                                                                    viewHeight(tenDayImageView))];
//    [segmentedView addSubview:eightMonthImageView];
//    //背景
//    eightMonthBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
//                                                                                 0,
//                                                                                 viewWidth(eightMonthImageView),
//                                                                                 viewHeight(eightMonthImageView))];
//    eightMonthBackgroundImageView.image = nil;
//    [eightMonthImageView addSubview:eightMonthBackgroundImageView];
//
//    NSString *monthString = [HomePageService sharedHomePageService].summaryModel.month;
//    if (monthString &&[monthString isKindOfClass:[NSString class]]&& ![monthString isEqualToString:@""]) {
//
//        monthString = [NSString stringWithFormat:@"最近%@个月",[HomePageService sharedHomePageService].summaryModel.month];
//    }else{
//        monthString = [NSString stringWithFormat:@"最近%lu个月",(unsigned long)[HomePageService sharedHomePageService].summaryModel.yearReleased.count];
//    }
//
//    eightMonthLabel = [CommonFunction addLabelFrame:CGRectMake(0,
//                                                               0,
//                                                               viewWidth(tenDayLabel),
//                                                               viewHeight(tenDayLabel))
//                                               text:monthString
//                                               font:33/2
//                                      textAlignment:(NSTextAlignmentCenter)
//                                       colorFromHex:0xFF17B9E8];
//    [eightMonthImageView addSubview:eightMonthLabel];
//
//    UIButton *eightMonthButton = [[UIButton alloc] initWithFrame:eightMonthLabel.frame];
//    [eightMonthButton addTarget:self
//                         action:@selector(buttonClickedWithSender:)
//               forControlEvents:(UIControlEventTouchUpInside)];
//    eightMonthButton.tag = 1;
//    [eightMonthImageView addSubview:eightMonthButton];
//
//    [self showTenDayRatioView];

    
}

-(void) didClicksegmentedControlAction:(UISegmentedControl *)seg
{
    NSInteger index = seg.selectedSegmentIndex;

    switch (index)
    {
        case 0:
            [self showWeekRatioView];
            break;
        case 1:
            [self showTenDayRatioView];
            break;
            
        case 2:
            [self showEightMonthRatioView];
            break;
        default:
            break;
    }
}


-(void) showWeekRatioView
{
    if (weekRatioView !=nil)
    {
        return;
    }
    else
    {
        weekRatioView = [[WeekRatioView alloc] initWithFrame:CGRectMake(0,
                                                                            viewBotton(segmentedControl) +13 ,
                                                                            kScreenWidth,
                                                                            kScreenHeight-110)];
        [self.view addSubview:weekRatioView];
        [eightMonthRatioView removeFromSuperview];
        eightMonthRatioView = nil;
        [tenDayRatioView removeFromSuperview];
        tenDayRatioView =nil;
    }
}

-(void) showTenDayRatioView
{
    if (tenDayRatioView !=nil)
    {
        return;
    }
    else
    {
        tenDayRatioView = [[TenDayRatioView alloc] initWithFrame:CGRectMake(0,
                                                                            viewBotton(segmentedControl) +13 ,
                                                                            kScreenWidth,
                                                                            kScreenHeight-110)];
        [self.view addSubview:tenDayRatioView];
        [eightMonthRatioView removeFromSuperview];
        eightMonthRatioView = nil;
        [weekRatioView removeFromSuperview];
        weekRatioView = nil;
    }
}

-(void) showEightMonthRatioView
{
    if (eightMonthRatioView !=nil)
    {
        return;
    }
    else
    {
        eightMonthRatioView = [[EightMonthRatioView alloc] initWithFrame:CGRectMake(0,
                                                                                    viewBotton(segmentedControl) +13 ,
                                                                                    kScreenWidth,
                                                                                    kScreenHeight-110)];

        [self.view addSubview:eightMonthRatioView];
        [tenDayRatioView removeFromSuperview];
        tenDayRatioView = nil;
        [weekRatioView removeFromSuperview];
        weekRatioView = nil;
    }
}

/**
 将子view移除
 */
-(void)removeAllView
{
    [tenDayRatioView removeFromSuperview];
    tenDayRatioView = nil;
    
    [eightMonthRatioView removeFromSuperview];
    eightMonthRatioView = nil;
}

-(void)initTitle
{
    [self titleViewInitWithHight:65];
    
    [self titleViewAddTitleText:@"放行正常率"];

    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      kScreenWidth,
                                                                      65)];
    self.titleView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];
    
    [self titleViewAddBackBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
