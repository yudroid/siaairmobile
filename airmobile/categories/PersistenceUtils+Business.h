//
//  PersistenceUtils+Business.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/4.
//  Copyright © 2016年 杨泉林. All rights reserved.
//  本类中插入、更新方法认为不会有sql注入未做验证
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
 查找最新的几条聊天记录

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
 查询用户列表手机端使用，如果不存在缓存用户列表，下次查询可以展示

 @return <#return value description#>
 */
+(NSArray<DeptInfoModel *> *)loadUserListGroupByDept;


/**
 聊天记录操作：1.判断聊天记录是否存在，如果存在更新name和time字段
            2.如果不存在将聊天记录插入到记录列表中
            3.如果更新的聊天记录为工作组聊天，调整工作组信息；原有人员删除，重新写入人员

 @param chat 创建新的聊天记录

 @return 聊天记录信息
 */
+(NSDictionary *)saveOrUpdateChat:(id)chat;


/**
 根据chatid更新name time信息

 @param chatId 聊天id
 */
+(void)updateChatName:name chatId:(int)chatId;


/**
 根据chatid更新time字段

 @param chatId 聊天记录本地id
 */
+(void)updateUnReadCountAndTime:(int)count chatid:(int)chatId;


/**
 插入聊天消息到数据表中

 @param message <#message description#>
 */
+(void)insertNewChatMessage:(NSDictionary *)message needid:(BOOL)need success:(void (^)())success;


/**
 首次登陆的时候同步用户消息

 @param messages <#messages description#>
 */
+(void)syncUserMessages:(NSArray<NSDictionary *> *)messages;

/**
 首次登陆的时候工作组消息
 
 @param messages <#messages description#>
 */
+(void)syncGroupMessages:(NSArray<NSDictionary *> *)messages;

/**
 插入系统消息

 @param message <#message description#>
 */
+(void)insertNewSysMessage:(NSDictionary *)message;

/**
 首次登陆的时候同步系统消息
 
 @param messages <#messages description#>
 */
+(void)syncSysMessages:(NSArray<NSDictionary *> *)messages;




/**
 查询系统消息列表，根据type

 @param type <#type description#>
 @param start <#start description#>
 @return <#return value description#>
 */
+(NSArray<NSDictionary *> *)findSysMsgListByType:(NSString *)type start:(long)start;


/**
 查询系统消息列表，根据type

 @param type <#type description#>
 @param start <#start description#>
 @param num <#num description#>
 @return <#return value description#>
 */
+(NSArray<NSDictionary *> *)findSysMsgListByType:(NSString *)type start:(int)start num:(int)num;


/**
 更新消息状态
 
 @param msgId <#msgId description#>
 */
+(void)updateSysMessageRead:(long)msgId;

@end
