//
//  MessageService.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/2.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"
#import <SocketRocket/SocketRocket.h>
#import "ChatViewController.h"

@interface MessageService : BaseService<SRWebSocketDelegate>

singleton_interface(MessageService);

-(void)startService;

-(void)resetDialogParam:(long)clientId
                 userId:(long)userId
                   toId:(long)toId
                   type:(BOOL)type;

@property (nonatomic,weak) id<ChatViewDelegate> chatDelegate;

@end
