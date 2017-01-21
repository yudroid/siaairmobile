//
//  FlightConcernViewController.m
//  airmobile
//
//  Created by xuesong on 17/1/13.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "FlightConcernViewController.h"
#import "FlightConcernDetailViewController.h"
#import <UMESDKKit/UMESubscribedFlightStatusListView.h>
#import "FlightSearchViewController.h"

@interface FlightConcernViewController ()<UMESDKApiDelegate>

@property (weak, nonatomic) IBOutlet UITextField *flightNoTextField;


@end

@implementation FlightConcernViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];

    UMESubscribedFlightStatusListView *_flightView = [[UMESubscribedFlightStatusListView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _flightView.apiDelegate = self;
    [self.view addSubview:_flightView];
    [_flightView loadData];
}


-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddBackBtn];
    [self titleViewAddTitleText:@"航班关注"];

    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-18-16, 20+8, 18, 18)];
    [addButton  setTitle:@"+" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [addButton setTintColor:[UIColor whiteColor]];
    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:addButton];
}


-(void)addButtonClick:(UIButton *)sender
{
    FlightSearchViewController *flightSearchVC = [[FlightSearchViewController alloc]init];
    [self.navigationController pushViewController:flightSearchVC animated:YES];
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
