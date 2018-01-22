//
//  PushMessageService.h
//  airmobile
//
//  Created by xuesong on 2017/11/21.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"
#import "ChatViewController.h"
#import "MessageViewController.h"
@class TabBarView;

@interface PushMessageService :BaseService

singleton_interface(PushMessageService);


-(void)resetDialogParam:(long)clientId
                 userId:(long)userId
                   toId:(long)toId
                   type:(BOOL)type;

@property (nonatomic,weak) id<ChatViewDelegate> chatDelegate;
@property (nonatomic,weak) id<MessageViewDelegate> chatListDelegate;
@property (nonatomic,strong) TabBarView *curTabBarView;

- (void)didReceiveMessage:(id)message;

@end
