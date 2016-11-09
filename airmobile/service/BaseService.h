//
//  BaseService.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/2.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseService : NSObject

- (void)startService:(void (^)(void))callBack;

- (void)stopService;

@end
