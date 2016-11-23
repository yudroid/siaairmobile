//
//  AppDelegate.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/3.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageService.h"
#import "MessageService.h"
#import "PersistenceUtils+Business.h"
#import "HomePageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [PersistenceUtils initTable];

//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    HomePageViewController *homepage = [[HomePageViewController alloc] init];
//    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:homepage];
//    nv.navigationBarHidden= YES;
//    self.window.rootViewController = nv;
//    [self.window makeKeyWindow];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    // 程序将转入后台，关闭程序远程service
    [[HomePageService sharedHomePageService] stopService];
    [[MessageService sharedMessageService] stopService];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    // 程序将展示，开起个别远程service
    [[HomePageService sharedHomePageService] startService];
    [[MessageService sharedMessageService] startService];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

@end
