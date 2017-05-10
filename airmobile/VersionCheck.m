//
//  VersionCheck.m
//  airmobile
//
//  Created by xuesong on 17/4/10.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "VersionCheck.h"
#import "HttpsUtils+Business.h"
#import "VersionModel.h"
#import "UIViewController+Reminder.h"

@implementation VersionCheck

+(void)versionCheck:(UIViewController *)viewController
{
    __weak typeof(viewController) weakVC = viewController;
    [self versionCheckWithViewController:weakVC
                            isNewVersion:^{
                                [weakVC showAnimationTitle:@"现在是最新版本"];
                            } httpFailuer:^(NSError *error) {
                                [weakVC showAnimationTitle:@"网络加载失败"];
                            }];
}

+(void)versionCheckWithViewController:(UIViewController*) viewController
                           isNewVersion:(void (^)(void) )newVersion
                          httpFailuer:(void (^)(NSError *error)) failer

{
    __weak typeof(viewController) weakVC = viewController;
    [HttpsUtils versionCheckSuccess:^(id response) {
        NSArray * data = [response objectForKey:@"data"];
        VersionModel *version = [[VersionModel alloc]initWithDictionary:[data lastObject]];
        NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        if ((version.appVersion.floatValue<app_Version.floatValue)||
            (version.appVersion.floatValue==app_Version.floatValue&&version.appVersionNo.floatValue<=build.floatValue )) {
            if (newVersion) {
                newVersion();
            }

        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发现新版本"
                                                                                     message:@"是否更新？"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                                style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action){
                                                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",@"itms-services://?action=download-manifest&url=https://www.pgyer.com/app/plist/",version.appKey,@"&password=",@"siaaoc"]]];
                                                              }]];
            [weakVC presentViewController:alertController animated:YES completion:nil];
        }
    } failure:^(id error) {
        if (failer) {
            failer(error);
        }
    }];
    
}
@end
