//
//  MYHTTPSessionManager.m
//  airmobile
//
//  Created by xuesong on 17/4/1.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "MYHTTPSessionManager.h"

static MYHTTPSessionManager *sharedManager;
static NSString * const AFAppDotNetAPIBaseURLString = @"https://api.app.net/";

@implementation MYHTTPSessionManager

+(instancetype) sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[MYHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        sharedManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    sharedManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sharedManager.requestSerializer  = [AFHTTPRequestSerializer serializer];

    return sharedManager;
}

@end
