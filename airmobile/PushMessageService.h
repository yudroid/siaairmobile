//
//  PushMessageService.h
//  airmobile
//
//  Created by xuesong on 2017/11/21.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"

@interface PushMessageService :BaseSevice

singleton_interface(PushMessageService);

//-(void)startService;

-(void)resetDialogParam:(long)clientId
                 userId:(long)userId
                   toId:(long)toId
                   type:(BOOL)type;

@property (nonatomic,weak) id<ChatViewDelegate> chatDelegate;
@property (nonatomic,weak) id<MessageViewDelegate> chatListDelegate;
@property (nonatomic,strong) TabBarView *curTabBarView;

-(void)setUserId:(int)userId;

@end
