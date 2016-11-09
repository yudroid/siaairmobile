//
//  BaseService.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/2.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "BaseService.h"
#import <Foundation/Foundation.h>

@implementation BaseService
{
    NSTimer *timer;
}

- (void)startService:(void (^)(void))callBack
{
    [self performSelectorInBackground:@selector(startTimer:) withObject:callBack];
}

- (void)stopService
{
    // 取消定时器
    if(timer != nil){
        [timer invalidate];
        timer = nil;
    }
}

- (void)startTimer:(void (^)(void))callBack
{
    timer =  [NSTimer scheduledTimerWithTimeInterval:30 repeats:YES block:(^(NSTimer *timer){
        if(callBack){
            callBack();
        }
    })];
    [timer fire];
    [[NSRunLoop currentRunLoop] run];
}

@end
