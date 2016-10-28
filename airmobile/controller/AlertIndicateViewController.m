//
//  AlertIndicateViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AlertIndicateViewController.h"
#import "RoundProgressView.h"

@interface AlertIndicateViewController ()

@end

@implementation AlertIndicateViewController
{
    CGFloat normalProportion;
    CGFloat abnormalProportion;
    CGFloat cancleProportion;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitle];
    
    //圆圈
    RoundProgressView *progressRound = [[RoundProgressView alloc] initWithCenter:CGPointMake(kScreenWidth/2, 65+60+86) radius:86 aboveColos:@[(__bridge id)[CommonFunction colorFromHex:0XFFC42FEB].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF00F383].CGColor ] belowColos:@[(__bridge id)[CommonFunction colorFromHex:0XFFFF9F38].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF49B7CE].CGColor ] start:270 end:271 clockwise:NO];
    [self.view addSubview:progressRound];
    
    normalProportion = 0.6;
    abnormalProportion = 0.0;
    cancleProportion = 0.0;
    
    //对数据进行动画
    [progressRound animationWithStrokeEnd:normalProportion withProgressType:ProgreesTypeNormal];
    [progressRound animationWithStrokeEnd:abnormalProportion withProgressType:ProgreesTypeAbnormal];
    [progressRound animationWithStrokeEnd:cancleProportion withProgressType:ProgreesTypeCancel];
    
    UILabel *totalNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 65+60+86-40/2, 100, 35)];
    totalNumLabel.text = @"80";
    totalNumLabel.textAlignment = NSTextAlignmentCenter;
    totalNumLabel.font = [UIFont systemFontOfSize:35];
    [self.view addSubview:totalNumLabel];
    
    UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 65+60+86-17/2+30, 100, 13)];
    totalLabel.text = @"航班执行率";
    totalLabel.textAlignment = NSTextAlignmentCenter;
    totalLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:totalLabel];
    
    UIImageView *buildingImageView = [CommonFunction imageView:nil frame:CGRectMake(30, 65+60+86*2+40, 30, 30)];
    [self.view addSubview:buildingImageView];
    
    [self.view addSubview:[CommonFunction addLabelFrame:CGRectMake(30+30, 65+60+86*2+40, kScreenWidth-160, 30) text:@"航站楼内滞留旅客" font:20 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
    
    [self.view addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-100, 65+60+86*2+40, 80, 30) text:@"6520" font:20 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
    
    UIImageView *delayImageView = [CommonFunction imageView:nil frame:CGRectMake(30, 65+60+86*2+40+30+25, 30, 30)];
    [self.view addSubview:delayImageView];
    
    [self.view addSubview:[CommonFunction addLabelFrame:CGRectMake(30+30, 65+60+86*2+40+30+25, kScreenWidth-160, 30) text:@"延误>1h航班出港率" font:20 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
    
    [self.view addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-100, 65+60+86*2+40+30+25, 80, 30) text:@"97%" font:20 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
    
    UIImageView *noFlightImageView = [CommonFunction imageView:nil frame:CGRectMake(30, 65+60+86*2+40+30+25+30+25, 30, 30)];
    [self.view addSubview:noFlightImageView];
    
    [self.view addSubview:[CommonFunction addLabelFrame:CGRectMake(30+30, 65+60+86*2+40+30+25+30+25, kScreenWidth-160, 30) text:@"无航班起降累积时间" font:20 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
    
    [self.view addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-100, 65+60+86*2+40+30+25+30+25, 80, 30) text:@"110min" font:20 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];

}

-(void)initTitle
{
    [self titleViewInitWithHight:65];
    [self titleViewAddTitleText:@"关键指标"];
    
    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 65)];
    self.titleView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];
    
    [self titleViewAddBackBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
