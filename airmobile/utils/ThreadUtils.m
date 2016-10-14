//
//  ThreadUtils.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/11.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ThreadUtils.h"

@implementation ThreadUtils


/**
 *  在多线程中执行action回调
 *
 *  @param action action回调
 */
+(void) dispatch:(void (^) (void)) action{
    if(action){
        //使用具有默认优先级的队列执行
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, action);
    }
}

/**
 *  在主线程上执行action回调
 *
 *  @param action action 回调
 */
+(void) dispatchMain:(void (^)(void))action{
    if(action){
        dispatch_async(dispatch_get_main_queue(), action);
    }
}

/**
 *  将一系列actions分布到多线程中
 *
 *  @param actions   一系列action
 *  @param completed 当action完成时的异步回调
 */
+(void) dispatchGroup:(NSArray*) actions onCompleted:(void (^)(void)) completed{
    if (actions == nil || [actions count] == 0) {
        return;
    }
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (id action in actions) {
        dispatch_group_async(group, queue, action);
    }
    
    //notify异步调用
    dispatch_group_notify(group, queue,completed);
    
}


@end
