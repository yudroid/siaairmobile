//
//  PersistenceUtils+Business.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/4.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PersistenceUtils.h"
#import "DeptInfoModel.h"
#import "UserInfoModel.h"


@interface PersistenceUtils (Business)

+(void) initTable;

/**
 查询最近的聊天记录按照事先倒序

 @param start 开始位置
 @param num   显示数量

 @return 聊天记录列表
 */
+(NSArray<NSDictionary *> *)findChatList:(int)start num:(int)num;

/**
 根据工作组id查找工作组人员

 @param groupId 工作组ID

 @return 工作组人员
 */
+(NSArray<NSDictionary *> *)findUserListByGroupId:(long)groupId;

/**

 @param chatId 会话ID
 @param start  开始位置
 @param num    查询数量

 @return 记录数
 */
+(NSArray<NSDictionary *> *)findMsgListByChatId:(long)chatId start:(int)start num:(int)num;


/**
 <#Description#>

 @param chatId <#chatId description#>
 @param start  <#start description#>

 @return <#return value description#>
 */
+(NSArray<NSDictionary *> *)findMsgListByChatId:(long)chatId start:(long)start;


/**
 存储用户列表

 @param userList <#userList description#>
 */
+(void) saveUserList:(id)userList;


/**
 查询用户列表手机端使用

 @return <#return value description#>
 */
+(NSArray<DeptInfoModel *> *)loadUserListGroupByDept;


@end
