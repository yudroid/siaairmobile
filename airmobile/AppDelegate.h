//
//  AppDelegate.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/3.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "UserInfoModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UserInfoModel *userInfoModel;

@end

