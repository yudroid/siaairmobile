//
//  ChatViewController.h
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface ChatViewController : RootViewController

@property (nonatomic,assign) long chatId;
@property (nonatomic,assign) int chatTypeId;// 0表示个人 1表示工作组 1>0人多工作组
@property (nonatomic,assign) long localChatId;

@end
