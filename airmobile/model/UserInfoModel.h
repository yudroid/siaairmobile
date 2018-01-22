//
//  UserInfoModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/4.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootModel.h"

@interface UserInfoModel : RootModel

@property (nonatomic ,copy)   NSString    *aptitude;
@property (nonatomic ,copy)   NSString    *className;
@property (nonatomic ,assign) long        deptId;
@property (nonatomic ,copy)   NSString    *deptName;
@property (nonatomic ,assign) int         flag;
@property (nonatomic ,assign) long        id;
@property (nonatomic ,copy)   NSString    *jobNumber;
@property (nonatomic ,copy)   NSString    *name;
@property (nonatomic ,copy)   NSString    *password;
@property (nonatomic ,copy)   NSString    *phone;
@property (nonatomic ,assign) long long    post;
@property (nonatomic ,copy)   NSString    *rule;
@property (nonatomic ,copy)   NSString    *seat;
@property (nonatomic ,copy)   NSString    *signStatus; // “” “未签到” "已签到" “已签退”
@property (nonatomic ,copy)   NSString    *functions; // 权限数组
@property (nonatomic ,copy)   NSString    *imagePath;

@property (nonatomic ,copy)   NSString    *version;//版本号


@end
