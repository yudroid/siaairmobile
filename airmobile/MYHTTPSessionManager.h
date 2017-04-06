//
//  MYHTTPSessionManager.h
//  airmobile
//
//  Created by xuesong on 17/4/1.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface MYHTTPSessionManager : AFHTTPSessionManager

+(instancetype) sharedManager;

@end
