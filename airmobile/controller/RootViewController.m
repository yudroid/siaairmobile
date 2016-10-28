//
//  RootViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark TitleView方法

-(void)titleViewInitWithHight:(CGFloat)high
{
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, high)];
    self.titleView.backgroundColor = [CommonFunction colorFromHex:0XFFFFFFFF];
    self.titleView.clipsToBounds = YES;
    [self.view insertSubview:self.titleView  aboveSubview:self.view];
}

- (void)titleViewAddTitleText:(NSString *)titleText
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    titleLabel.text = titleText;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
    titleLabel.backgroundColor = [UIColor clearColor];
    [self.titleView addSubview:titleLabel];
}

- (UIButton *)titleViewAddBackBtn
{
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 51, 44)];
    backBtn.backgroundColor = [UIColor clearColor];
    //    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateSelected)];
    [self.titleView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    return backBtn;
}
- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Tabbar方法

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
