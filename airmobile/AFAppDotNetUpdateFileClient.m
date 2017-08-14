//
//  AFAppDotNetUpdateFileClient.m
//  airmobile
//
//  Created by xuesong on 2017/8/10.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "AFAppDotNetUpdateFileClient.h"

static NSString * const AFAppDotNetAPIBaseURLString = @"https://api.app.net/";

@implementation AFAppDotNetUpdateFileClient

+ (instancetype)sharedClient {
    static AFAppDotNetUpdateFileClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetUpdateFileClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return _sharedClient;
}

+ (instancetype)sharedClientString {
    static AFAppDotNetUpdateFileClient *_sharedClientString = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClientString =  [AFAppDotNetUpdateFileClient manager];
        _sharedClientString.responseSerializer = [AFHTTPResponseSerializer serializer];

        //请求超时时间
        [_sharedClientString.requestSerializer setTimeoutInterval: 10];

        //设置请求编码格式
        [_sharedClientString.requestSerializer setStringEncoding:NSUTF8StringEncoding];

        //设置响应编码格式
        [_sharedClientString.responseSerializer setStringEncoding:NSUTF8StringEncoding];

    });
    return _sharedClientString;
}


@end
