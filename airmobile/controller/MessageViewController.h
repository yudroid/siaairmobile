//
//  MessageViewController.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootViewController.h"
#import <SocketRocket/SRWebSocket.h>

@protocol MessageViewDelegate <NSObject>

@required
-(void)refreshChatInfoList;

@end

@interface MessageViewController : RootViewController<TabBarViewDelegate>

@end
