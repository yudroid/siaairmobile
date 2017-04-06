//
//  HasTabbarRootViewController.m
//  airmobile
//
//  Created by xuesong on 17/1/11.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "HasTabbarRootViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "TabFlightSearchViewController.h"
#import "MessageViewController.h"
#import "FunctionViewController.h"
#import "UserInfoViewController.h"
#import "SingleMessageViewController.h"

@interface HasTabbarRootViewController ()

@end

@implementation HasTabbarRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 切换底部主功能页面
-(void)selectWithType:(TabBarSelectedType)type
{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIViewController *viewController = nil;
    switch (type) {
        case TabBarSelectedTypeHomePage:
            viewController = [[HomePageViewController alloc] init];
            break;

        case TabBarSelectedTypeFlight:
            viewController = [[TabFlightSearchViewController alloc] init];
            break;
        case TabBarSelectedTypeMessage:
            [self showMessageViewController];
            return;
        case TabBarSelectedTypeFunction:
            viewController = [[FunctionViewController alloc] init];
            break;
        case TabBarSelectedTypeUserInfo:
            viewController = [[UserInfoViewController alloc] init];
            break;
        default:
            break;
    }
    UINavigationController *navigationContoller = [[UINavigationController alloc]initWithRootViewController:viewController];
    appdelegate.window.rootViewController = navigationContoller;
    [appdelegate.window makeKeyWindow];

}

-(void)showMessageViewController
{
    UIViewController *message ;
    if([CommonFunction hasFunction:MSG_WORNING] && ![CommonFunction hasFunction:MSG_FLIGHT] && ![CommonFunction hasFunction:MSG_DIALOG]){
        message = [[SingleMessageViewController alloc] init];
        ((SingleMessageViewController*)message).type = @"COMMAND";
    }else if(![CommonFunction hasFunction:MSG_WORNING] && [CommonFunction hasFunction:MSG_FLIGHT] && ![CommonFunction hasFunction:MSG_DIALOG]){
        message = [[SingleMessageViewController alloc] init];
        ((SingleMessageViewController*)message).type = @"FLIGHT";
    }else{
        message = [[MessageViewController alloc]init];
    }
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UINavigationController *navigationContoller = [[UINavigationController alloc]initWithRootViewController:message];
    appdelegate.window.rootViewController = navigationContoller;
    [appdelegate.window makeKeyWindow];
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
