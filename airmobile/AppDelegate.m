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
#import <Bugly/Bugly.h>
#import <UMESDKKit/UMESDKApi.h>
#import "KyAirportService.h"
#import "HttpsUtils+Business.h"
#import "FlightDelaysViewController.h"
#import "LoginViewController.h"
#import <PushKit/PushKit.h>


@interface AppDelegate ()<PKPushRegistryDelegate>

@property (nonatomic, assign) NSInteger loginNum;
@property (nonatomic, copy)  NSString *tokenStr;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//
//    [UIViewController preferredStatusBarStyle];

    NSString *path = NSHomeDirectory();//主目录
    NSLog(@"NSHomeDirectory:%@",path);

    //腾讯bugly
    [Bugly startWithAppId:@"77560c2856"];

//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:nil forKey:@"CONCERNIDENTIFIER"];

    [PersistenceUtils initTable];

//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    HomePageViewController *homepage = [[HomePageViewController alloc] init];
//    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:homepage];
//    nv.navigationBarHidden= YES;
//    self.window.rootViewController = nv;
//    [self.window makeKeyWindow];

    // 加载数据
//    [[KyAirportService sharedKyAirportService] cacheAirport];

    //注册pushkit
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationSettings *userNotifiSetting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:userNotifiSetting];
        PKPushRegistry *pushRegistry = [[PKPushRegistry alloc] initWithQueue:nil];
        pushRegistry.delegate = self;
        pushRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
    }

    //注册通知
    // 设置应用程序的图标右上角的数字
    [application setApplicationIconBadgeNumber:0];

    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    // 程序将转入后台，关闭程序远程service
    [[HomePageService sharedHomePageService] stopService];
//    [[MessageService sharedMessageService] stopService];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    if(self.userInfoModel.id && self.userInfoModel.id != 0){
//
//    }
    // 程序将展示，开起个别远程service
    [self reLogin];
    if(_userInfoModel != nil) {
//        NSLog(@"%s",__func__);
        _loginNum = 0;
//        [[MessageService sharedMessageService] startService];

    }

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[HomePageService sharedHomePageService] stopService];
    [[MessageService sharedMessageService] stopService];

}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // 必须要监听--应用程序在后台的时候进行的跳转
    if (application.applicationState == UIApplicationStateInactive) {
//        NSLog(@"进行界面的跳转");
        // 如果在上面的通知方法中设置了一些，可以在这里打印额外信息的内容，就做到监听，也就可以根据额外信息，做出相应的判断
        FlightDelaysViewController *flightDelaysVC = [[FlightDelaysViewController alloc]initWithNibName:@"FlightDelaysViewController"
                                                                                                 bundle:nil];
        flightDelaysVC.type = @"FLIGHT";

        [self.window.rootViewController.navigationController pushViewController:flightDelaysVC animated:YES];
    }
}

//这个代理方法是获取了设备的唯tokenStr，是要给服务器的
- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:(PKPushCredentials *)credentials forType:(NSString *)type{
    NSString *str = [NSString stringWithFormat:@"%@",credentials.token];
    _tokenStr = [[[str stringByReplacingOccurrencesOfString:@"<" withString:@""]
                  stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(NSString *)type {

//    NSDictionary *dic = [self jsonToDictionary:[[payload.dictionaryPayload objectForKey:@"aps"] objectForKey:@"alert"]];
//    if ([[dic objectForKey:@"cmd"] isEqualToString:@"precall"]) {
//        UIUserNotificationType theType = [UIApplication sharedApplication].currentUserNotificationSettings.types;
//        if (theType == UIUserNotificationTypeNone)
//        {
//            UIUserNotificationSettings *userNotifySetting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
//            [[UIApplication sharedApplication] registerUserNotificationSettings:userNotifySetting];
//        }
//        UILocalNotification *backgroudMsg = [[UILocalNotification alloc] init];
//        if (backgroudMsg) {
//            backgroudMsg.timeZone = [NSTimeZone defaultTimeZone];
//            backgroudMsg.alertBody = @"门口机来电";
//            backgroudMsg.alertAction = @"查看";
//            //设置通知的相关信息，这个很重要，可以添加一些标记性内容，方便以后区分和获取通知的信息
//            NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"name" forKey:@"key"];;
//            backgroudMsg.userInfo = infoDic;
//            [[UIApplication sharedApplication] presentLocalNotificationNow:backgroudMsg];
//
//        }
//    }else if ([[dic objectForKey:@"cmd"] isEqualToString:@"precancel"]){
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"precancel"
//                                                            object:nil];
//
//    }
}

-(void)reLogin{
    NSString* userKey = @"taocares_userName";
    NSString* pwdKey = @"taocares_pwd";
    NSString *username=[DefaultHelper getStringForKey:userKey];
    NSString *pwd=[DefaultHelper getStringForKey:pwdKey];
    if (![userKey isKindOfClass:[NSString class]] || ![pwd isKindOfClass:[NSString class]] ) {
        return;
    }
    [HttpsUtils loginUser:username pwd:pwd deviceInfo:@"" success:^(UserInfoModel *user){

        [[HomePageService sharedHomePageService] startService];

    }failure:^(NSError* error){
        _loginNum ++;
        if (_loginNum <=3) {
            [self reLogin];
        }else{
            LoginViewController *homepage = [[LoginViewController alloc] init];
            UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:homepage];
            nv.navigationBarHidden= YES;
            self.window.rootViewController = nv;
            [self.window makeKeyWindow];

        }
    }];

}

@end
