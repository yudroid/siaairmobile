//
//  UMESDKApiDelegate.h
//  UMESDKDemo
//
//  Created by zhangbo on 14-3-26.
//  Copyright (c) 2014年 Livindesign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMEBaseResponse.h"

@protocol UMESDKApiDelegate <NSObject>

@optional
//请求发起前调用
-(void)requestDidStart;
//请求发起前调用
-(void)requestDidStartWithType:(NSInteger) type;
//请求发起前调用
-(void)requestDidEndWithType:(NSInteger) type;
//请求完成后前调用
-(void)requestDidEnd;
//请求数据返回调用
-(void)callBackWithResponse:(UMEBaseResponse *) response;

@end
