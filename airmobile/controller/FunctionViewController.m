//
//  FunctionViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FunctionViewController.h"
#import "FlightViewController.h"
#import "HomePageViewController.h"
#import "MessageViewController.h"
#import "UserInfoViewController.h"

@interface FunctionViewController ()

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TabBer自定义
    self.tabBarView = [[TabBarView alloc] initTabBarWithModel:TabBarBgModelHomePage selectedType:TabBarSelectedTypeFunction delegate:self];
    [self.view insertSubview:self.tabBarView aboveSubview:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 切换底部主功能页面
-(void)selectWithType:(TabBarSelectedType)type
{
    switch (type) {
        case TabBarSelectedTypeHomePage:
        {
            HomePageViewController *homepage = [[HomePageViewController alloc] init];
            [self.navigationController pushViewController:homepage animated:NO];
            break;
        }
        case TabBarSelectedTypeMessage:
        {
            MessageViewController *messagepage = [[MessageViewController alloc] init];
            [self.navigationController pushViewController:messagepage animated:NO];
            break;
        }
        case TabBarSelectedTypeFunction:
        {
            FunctionViewController *function = [[FunctionViewController alloc] init];
            [self.navigationController pushViewController:function animated:NO];
            break;
        }
        case TabBarSelectedTypeUserInfo:
        {
            UserInfoViewController *userInfo = [[UserInfoViewController alloc] init];
            [self.navigationController pushViewController:userInfo animated:NO];
            break;
        }
        default:
            break;
    }
}

@end
