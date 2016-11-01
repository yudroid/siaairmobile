//
//  UserNessageModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface UserNessageModel : RootModel

@property (nonatomic, assign) long id;//主键
@property (nonatomic, copy) NSString *content;//内容
@property (nonatomic, copy) NSDate *createTime;//产生时间
@property (nonatomic, assign) long fromId;//消息产生者
@property (nonatomic, assign) long toId;//消息发送者
@property (nonatomic, assign) NSInteger handleStatus;//处理状态
@property (nonatomic, copy) NSDate *receiveTime;//接收时间
@property (nonatomic, assign) NSInteger version;//版本号

@end
