//
//  FlightConcernDetailViewController.m
//  airmobile
//
//  Created by xuesong on 17/1/13.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "FlightConcernDetailViewController.h"
#import <UMESDKKit/UMEFlightStatusDetailView.h>
#import <UMESDKKit/UMESubscribedFlightStatusRequest.h>
#import <UMESDKKit/UMEFlightStatusDetailResponse.h>
#import <UMESDKKit/UMESDKApi.h>

@interface FlightConcernDetailViewController ()<UMESDKApiDelegate>

@end

@implementation FlightConcernDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initTitleView];

    UMEFlightStatusDetailView *_flightView = [[UMEFlightStatusDetailView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _flightView.date = self.date;
    _flightView.startCityCode = self.startCityCode;
    _flightView.endCityCode = self.endCityCode;

    _flightView.flightNo = _flightNo;
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
    [self titleViewAddTitleText:@"航班详情"];
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
        UMESubscribedFlightStatusRequest *request = [[UMESubscribedFlightStatusRequest alloc] init];
        request.flightDate =  response.date;
        request.flightNo = response.flightNo;
        request.depCityCode = response.endCityCode;
        request.arrCityCode = response.startCityCode;
        request.subKey = @"123456";
        request.airlineCode = response.airlineName;
        [[UMESDKApi requestManager] sendRequest:request withDelegate:self];

    
}

@end
