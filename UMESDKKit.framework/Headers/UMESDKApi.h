//
//  UMESDKApi.h
//  UMESDK
//
//  Created by zhangbo on 14-2-25.
//  Copyright (c) 2014年 Livindesign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UMEBaseResponse.h"
#import "UMEGetAirportFunctionUrlResponse.h"

#import "UMESDKApiDelegate.h"
#import "UMEBaseView.h"
#import "AirportFuctionWebViewController.h"


typedef enum {
    English,
    Chinese
    
}Language;

@interface UMESDKApi : NSObject<UIAlertViewDelegate>

//设置SDK语言
+(void)setLanguage:(Language) language;


//进行SDK使用注册

+(void)registerApp:(NSString *)aAppid andAppKey:(NSString *)aAppKey;

+(void)registerApp:(NSString *)aAppid andAppKey:(NSString *)aAppKey andApiDelegate:(id<UMESDKApiDelegate>) aApiDelegate;

+(void)setTestMode:(BOOL) isTestMode;

+(id)requestManager;

+(void) clearUserInfo:(NSString *)userIdentifier;


+(NSInteger)getSubscribedFlightCount;


@end
