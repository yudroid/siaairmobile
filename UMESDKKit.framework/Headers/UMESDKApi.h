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
#import "UMEFlightStatusDetailResponse.h"
#import "UMEFlightStatusCancelSubscribeResponse.h"
#import "UMEFlightStatusSubscribeResponse.h"
#import "UMEFlightStatusSubscribeKeyResponse.h"
#import "UMEInstallResponse.h"
#import "UMEAirportDetailResponse.h"
#import "UMECheckinResponse.h"
#import "UMEGetSeatMapInfoResponse.h"
#import "UMEBindingResponse.h"
#import "UMECheckBindingResponse.h"
#import "UMEGetCancelCheckinURLResponse.h"
#import "UMECancelCheckinResponse.h"

#import "UMESDKApiDelegate.h"
#import "UMEBaseView.h"
#import "UMEFlightStatusDetailView.h"
#import "UMEFlightStatusSearchResultView.h"
#import "UMESubscribedFlightStatusListView.h"


#import "UMEBaseReq.h"
#import "UMESubscribedFlightStatusRequest.h"
#import "UMECancelSubscribeFlightStatusRequest.h"
#import "UMECheckBindingRequest.h"
#import "UMEBindingRequest.h"


@interface UMESDKApi : NSObject<UIAlertViewDelegate>

//进行SDK使用注册

+(void)registerApp:(NSString *)aAppid andAppKey:(NSString *)aAppKey;

+(void)registerApp:(NSString *)aAppid andAppKey:(NSString *)aAppKey andApiDelegate:(id<UMESDKApiDelegate>) aApiDelegate;

//设置是否为测试服务器
+(void)setTestMode:(BOOL) isTestMode;

+(id)requestManager;

+(void) clearUserInfo:(NSString *)userIdentifier;


+(NSInteger)getSubscribedFlightCount;

-(void)sendRequest:(UMEBaseReq *)request withDelegate:(id<UMESDKApiDelegate>) aApiDelegate;


@end
