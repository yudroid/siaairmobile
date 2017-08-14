//
//  AFAppDotNetUpdateFileClient.h
//  airmobile
//
//  Created by xuesong on 2017/8/10.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


@interface AFAppDotNetUpdateFileClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
+ (instancetype)sharedClientString;

@end
