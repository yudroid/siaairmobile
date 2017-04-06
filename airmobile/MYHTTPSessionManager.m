//
//  MYHTTPSessionManager.m
//  airmobile
//
//  Created by xuesong on 17/4/1.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "MYHTTPSessionManager.h"

static MYHTTPSessionManager *sharedManager;

@implementation MYHTTPSessionManager

+(instancetype) sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [MYHTTPSessionManager manager];

    });
    sharedManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sharedManager.requestSerializer  = [AFHTTPRequestSerializer serializer];

    return sharedManager;
}

@end
