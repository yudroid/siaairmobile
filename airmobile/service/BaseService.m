//
//  BaseService.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/2.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "BaseService.h"
#import <Foundation/Foundation.h>

typedef void  (^TimeBlock)(void);

@implementation BaseService
{
    NSTimer *timer;
    TimeBlock timeblock;

}

- (void)startService:(void (^)(void))callBack
{
    [self performSelectorInBackground:@selector(startTimer:)
                           withObject:callBack];
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
//    timer =  [NSTimer scheduledTimerWithTimeInterval:30
//                                             repeats:YES
//                                               block:(^(NSTimer *timer){
//        if(callBack){
////            callBack();<#(nonnull NSInvocation *)#>
//
//        }
//    })];

//    timer = [NSTimer scheduledTimerWithTimeInterval:30 invocation: repeats:YES]
    timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timerFounction) userInfo:nil repeats:YES];

    timeblock = callBack;

    [timer fire];
    [[NSRunLoop currentRunLoop] run];
}


-(void)timerFounction
{
    timeblock();

}

@end
