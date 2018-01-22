//
//  UILocalNotification+Business.m
//  airmobile
//
//  Created by xuesong on 17/3/21.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "UILocalNotification+Business.h"

@implementation UILocalNotification (Business)


+(void)sendLocalNotificationWithTitle:(NSString *)title content:(NSString *)content
{

    UILocalNotification *localNote = [[UILocalNotification alloc] init];

    // 2.设置本地通知的内容
    // 2.1.设置通知发出的时间
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
    // 2.2.设置通知的内容
    localNote.alertBody =content;
    // 2.3.设置滑块的文字（锁屏状态下：滑动来“解锁”）
    localNote.alertAction = @"解锁";
    // 2.4.决定alertAction是否生效
    localNote.hasAction = YES;

    // 2.6.设置alertTitle
    localNote.alertTitle = title;
    // 2.7.设置有通知时的音效
    localNote.soundName = @"buyao.wav";
    // 2.8.设置应用程序图标右上角的数字
    localNote.applicationIconBadgeNumber = 0;

//    // 2.9.设置额外信息
//    localNote.userInfo = @{@"type" : @1};

    // 3.调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}

+(void)sendFlightChangeNotificationWithContent:(NSString *)content
{

    [self sendLocalNotificationWithTitle:@"航班变更" content:content];

}

@end
