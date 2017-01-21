//
//  FlightConcernLIstViewController.m
//  airmobile
//
//  Created by xuesong on 17/1/21.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "FlightConcernListViewController.h"
#import "FlightConcernDetailViewController.h"
#import <UMESDKKit/UMEFlightStatusSearchResultView.h>
#import <UMESDKKit/UMEFlightStatusDetailView.h>
#import <UMESDKKit/UMESubscribedFlightStatusListView.h>
#import <UMESDKKit/UMESubscribedFlightStatusRequest.h>
#import <UMESDKKit/UMESDKApi.h>

@interface FlightConcernListViewController ()<UMESDKApiDelegate>

@end

@implementation FlightConcernListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];

    UMEFlightStatusSearchResultView *_flightView = [[UMEFlightStatusSearchResultView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _flightView.apiDelegate = self;
    _flightView.date = self.date;
    if (self.type == UMEFlightStatusSearchTypeFlightCity) {
        _flightView.startCityCode = self.starCityCode;
        _flightView.endCityCode = self.endCityCode;
    }else{
        _flightView.flightNo = _flightNo;
    }
    [self.view addSubview:_flightView];
    [_flightView loadData];
}


-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddBackBtn];
    [self titleViewAddTitleText:@"航班列表"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//请求发起前调用
-(void)requestDidStart
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
//请求发起前调用
-(void)requestDidStartWithType:(NSInteger) type
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
//请求发起前调用
-(void)requestDidEndWithType:(NSInteger) type
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
//请求完成后前调用
-(void)requestDidEnd
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
//请求数据返回调用
-(void)callBackWithResponse:(UMEFlightStatusDetailResponse *) response
{
//    NSLog(@"%@，%@",NSStringFromSelector(_cmd),response);




    if (self.type == UMEFlightStatusSearchTypeFlightCity) {
        FlightConcernDetailViewController *flightConcernDetailVC = [[FlightConcernDetailViewController alloc] init];
        flightConcernDetailVC.date = response.date;
        flightConcernDetailVC.flightNo = response.flightNo;
        flightConcernDetailVC.startCityCode = response.startCityCode;
        flightConcernDetailVC.endCityCode = response.endCityCode;
        [self.navigationController pushViewController:flightConcernDetailVC animated:YES];
    }else{
        UMESubscribedFlightStatusRequest *request = [[UMESubscribedFlightStatusRequest alloc] init];
        request.flightDate =  response.date;
        request.flightNo = response.flightNo;
        request.depCityCode = response.endCityCode;
        request.arrCityCode = response.startCityCode;
        request.subKey = @"123456";
        request.airlineCode = response.airlineName;
        [[UMESDKApi requestManager] sendRequest:request withDelegate:self];
    }

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
