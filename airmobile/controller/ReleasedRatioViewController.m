//
//  ReleasedRatioViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ReleasedRatioViewController.h"

@interface ReleasedRatioViewController ()

@end

@implementation ReleasedRatioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitle];
    
//    UIImageView *tenDayImageView = [CommonFunction imageView:nil frame:CGRectMake(0, 0, 120, 35)];
//    tenDayImageView.center = CGPointMake(kScreenWidth/2-120/2, 65+10+35/2);
//    [self.view addSubview:tenDayImageView];
    tenDayImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 35)];
    tenDayImageView.center = CGPointMake(kScreenWidth/2-120/2, 65+10+35/2);
    tenDayImageView.backgroundColor = [CommonFunction colorFromHex:0xFF17B9EA];
    [tenDayImageView.layer setCornerRadius:8.0f];
    [self.view addSubview:tenDayImageView];
    
    UILabel *tenDayLabel = [CommonFunction addLabelFrame:CGRectMake(0, 0, 120, 35) text:@"最近10天" font:20 textAlignment:(NSTextAlignmentCenter) colorFromHex:0xFF1B1B1B];
    tenDayLabel.center = CGPointMake(kScreenWidth/2-120/2, 65+10+35/2);
    [self.view addSubview:tenDayLabel];
    
    UIButton *tenDayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 35)];
    tenDayButton.center = CGPointMake(kScreenWidth/2-120/2, 65+10+35/2);
    [tenDayButton addTarget:self action:@selector(buttonClickedWithSender:) forControlEvents:(UIControlEventTouchUpInside)];
    tenDayButton.tag = 0;
    [self.view addSubview:tenDayButton];
    
//    UIImageView *eightMonthImageView = [CommonFunction imageView:nil frame:CGRectMake(0, 0, 120, 35)];
    eightMonthImageView = [[UIView alloc ] initWithFrame:CGRectMake(0, 0, 120, 35)];
    eightMonthImageView.center = CGPointMake(kScreenWidth/2+120/2, 65+10+35/2);
    [self.view addSubview:eightMonthImageView];
    
    UILabel *eightMonthLabel = [CommonFunction addLabelFrame:CGRectMake(0, 0, 120, 35) text:@"近8个月" font:20 textAlignment:(NSTextAlignmentCenter) colorFromHex:0xFF1B1B1B];
    eightMonthLabel.center = CGPointMake(kScreenWidth/2+120/2, 65+10+35/2);
    [self.view addSubview:eightMonthLabel];
    
    UIButton *eightMonthButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 35)];
    eightMonthButton.center = CGPointMake(kScreenWidth/2+120/2, 65+10+35/2);
    [eightMonthButton addTarget:self action:@selector(buttonClickedWithSender:) forControlEvents:(UIControlEventTouchUpInside)];
    eightMonthButton.tag = 1;
    [self.view addSubview:eightMonthButton];
 
    [self showTenDayRatioView];
}

-(void) buttonClickedWithSender:(UIButton *)sender
{
    tenDayImageView.backgroundColor = [CommonFunction colorFromHex:0X7FFFFFFF];
    eightMonthImageView.backgroundColor = [CommonFunction colorFromHex:0X7FFFFFFF];
    
    [self removeAllView];
    
    switch (sender.tag)
    {
        case 0:
            tenDayImageView.backgroundColor = [CommonFunction colorFromHex:0xFF17B9EA];
            [self showTenDayRatioView];
            break;
            
        case 1:
            eightMonthImageView.backgroundColor = [CommonFunction colorFromHex:0xFF17B9EA];
            [self showEightMonthRatioView];
            break;
            
        default:
            break;
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
        tenDayRatioView = [[TenDayRatioView alloc] initWithFrame:CGRectMake(0, 65+10+35, kScreenWidth, kScreenHeight-110)];
        [self.view addSubview:tenDayRatioView];
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
        eightMonthRatioView = [[EightMonthRatioView alloc] initWithFrame:CGRectMake(0, 110, kScreenWidth, kScreenHeight-110)];
        [self.view addSubview:eightMonthRatioView];
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

    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 65)];
    self.titleView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];
    
    [self titleViewAddBackBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
