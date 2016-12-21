//
//  VersionModel.h
//  airmobile
//
//  Created by xuesong on 16/12/21.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootModel.h"
@interface VersionModel : RootModel
@property (nonatomic, copy)NSString *appKey;
@property (nonatomic, copy)NSString *appType;
@property (nonatomic, copy)NSString *appIsLastest;
@property (nonatomic, copy)NSString *appFileName;
@property (nonatomic, copy)NSString *appFileSize;
@property (nonatomic, copy)NSString *appName;
@property (nonatomic, copy)NSString *appVersion;
@property (nonatomic, copy)NSString *appVersionNo;
@property (nonatomic, copy)NSString *appBuildVersion;
@property (nonatomic, copy)NSString *appIdentifier;
@property (nonatomic, copy)NSString *appIcon;
@property (nonatomic, copy)NSString *appDescription;
@property (nonatomic, copy)NSString *appUpdateDescription;
@property (nonatomic, copy)NSString *appScreenshots;
@property (nonatomic, copy)NSString *appShortcutUrl;
@property (nonatomic, copy)NSString *appCreated;
@property (nonatomic, copy)NSString *appUpdated;
@property (nonatomic, copy)NSString *appQRCodeURL;

@end
