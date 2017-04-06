//
//  UILocalNotification+Business.h
//  airmobile
//
//  Created by xuesong on 17/3/21.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILocalNotification (Business)


/**
 发送本地通知

 @param title 标题
 @param content 内容
 */
+(void)sendLocalNotificationWithTitle:(NSString *)title content:(NSString *)content;



/**
 发送航班变更消息

 @param content 内容
 */
+(void)sendFlightChangeNotificationWithContent:(NSString *)content;

@end
