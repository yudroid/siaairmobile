//
//  MessageModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/4.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,assign) long id;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,assign) long fromId;
@property (nonatomic,copy) NSString *fromName;
@property (nonatomic,assign) long toId;
@property (nonatomic,copy) NSString *toName;
@property (nonatomic,assign) int handleStatus;
@property (nonatomic,copy) NSString *receiveTime;
@property (nonatomic,assign) int type;

-(instancetype) initWithId:(long)rid content:(NSString *)content fromId:(long)fromId toId:(long)toId type:(int)type status:(int)status;
-(NSDictionary *) toUserMsgNSDictionary;

-(NSDictionary *) toGroupMsgNSDictionary;

@end