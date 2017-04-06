//
//  WeatherAirportController.m
//  KaiYa
//
//  Created by chunminglu on 16/4/6.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "WeatherAirportController.h"
#import <UMESDKKit/AirportFuctionWebViewController.h>
#import <UMESDKKit/UMESDKApi.h>



@implementation WeatherAirportController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    //初始化标题
    [self titleViewInit];
    //创建第三方Webview
    [self createWebView];
    

}


//titleView订制
- (void)titleViewInit{
    [self titleViewInitWithHight:64];
    [self titleViewAddTitleText:self.title];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddBackBtn];
    //[self titleViewAddRefreshBtn];
}


-(void) createWebView{
    AirportFuctionWebViewController* airportController = [[AirportFuctionWebViewController alloc] init];
    airportController.airportCode = self.airportCode;
    airportController.functionID = self.functionId;
    airportController.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight);
    [self addChildViewController:airportController];
    [self.view addSubview:airportController.view];
    [self webView:airportController.view];
}


///解决底部遮挡不显示
-(void)webView:(UIView *)rootView
{
    for (UIView *subView in rootView.subviews) {
        if ([subView isKindOfClass:[UIWebView class]]) {
            CGRect webFrame = subView.frame;
            webFrame.size.height = kScreenHeight-64;
            subView.frame = webFrame;
        }
    }
}


@end
