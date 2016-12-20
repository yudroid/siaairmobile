//
//  PersistenceUtils+Business.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/4.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PersistenceUtils+Business.h"
#import "HttpsUtils+Business.h"
#import "AppDelegate.h"

@implementation PersistenceUtils (Business)

/**
 *  初始化数据库
 */
+(void) initTable{
    [self commonSqlProcess:^(sqlite3* database){
        //IF NOT EXISTS才创建表，所以这是可以重复执行的
        //NSString* createSql = @"CREATE TABLE IF NOT EXISTS TABLENAME(Id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT NOT NULL, Age INTEGER)";
        
        NSString *chatInfoTable = @"CREATE TABLE IF NOT EXISTS ChatInfo (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,chatid integer,name nvarchar(128),type integer(1),userid integer,time datetime,unread integer(5) DEFAULT(0),describe nvarchar(256),remark nvarchar(128));";
        int result = sqlite3_exec(database, [chatInfoTable UTF8String], NULL, NULL, NULL);
        if (result == SQLITE_OK) {
            NSLog(@"成功创建表   #会话记录表#   %@",@"chatInfoTable");
        }

        NSString *groupInfoTable = @"CREATE TABLE IF NOT EXISTS GroupInfo (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,chatid integer,userid integer NOT NULL,username nvarchar(64),userinfo nvarchar(256),remark nvarchar(128),CONSTRAINT 'GroupInfo_FK1' FOREIGN KEY ('chatid') REFERENCES 'ChatInfo' ('id') ON DELETE CASCADE ON UPDATE CASCADE);";
        result = sqlite3_exec(database, [groupInfoTable UTF8String], NULL, NULL, NULL);
        if (result == SQLITE_OK) {
            NSLog(@"成功创建表   #工作组信息表#   %@",@"groupInfoTable");
        }
        
        NSString *chatMsgTable = @"CREATE TABLE IF NOT EXISTS ChatMessage (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,chatid integer NOT NULL,content nvarchar(1024),senduserid integer NOT NULL,username nvarchar(50),time datetime NOT NULL,status integer(1),CONSTRAINT 'ChatMessage_FK1' FOREIGN KEY ('chatid') REFERENCES 'ChatInfo' ('id') ON DELETE CASCADE ON UPDATE CASCADE);";
        result = sqlite3_exec(database, [chatMsgTable UTF8String], NULL, NULL, NULL);
        if (result == SQLITE_OK) {
            NSLog(@"成功创建表   #会话消息记录表#   %@",@"chatMsgTable");
        }
       
        NSString *userInfoTable = @"CREATE TABLE IF NOT EXISTS userinfo (userid integer PRIMARY KEY AUTOINCREMENT NOT NULL,username nvarchar(50),phone nvarchar(20),deptid integer,deptname nvarchar(128),station nvarchar(128),remark nvarchar(128));";
        result = sqlite3_exec(database, [userInfoTable UTF8String], NULL, NULL, NULL);
        if (result == SQLITE_OK) {
            NSLog(@"成功创建表   #用户信息表#   %@",@"userInfoTable");
        }
        
        NSString *sysMsgTable = @"CREATE TABLE IF NOT EXISTS SysMessage (msgid integer NOT NULL PRIMARY KEY AUTOINCREMENT, type integer(2,0) NOT NULL, content nvarchar(1024,0),title nvarchar(100,0), createtime datetime NOT NULL, readtime date NOT NULL, status integer(1,0), todeptids nvarchar(500,0), todept integer(20,0), userid integer);";

        result = sqlite3_exec(database, [sysMsgTable UTF8String], NULL, NULL, NULL);
        if (result == SQLITE_OK) {
            NSLog(@"成功创建表   #系统消息事件表#   %@",@"sysMsgTable");
//            private Long id;
//            private String type;
//            private String content;
//            private String title;
//            private String createTime;
//            private String status;
//            private String toDeptIds;
//            private Long toDept;
        }

        NSString *basisInfoEventTable = @"CREATE TABLE IF NOT EXISTS BasisInfoEvent (basisid integer PRIMARY KEY AUTOINCREMENT NOT NULL,username nvarchar(50),event_type long,dispatch_type long,event_level long,event text,content text);";
        result = sqlite3_exec(database, [basisInfoEventTable UTF8String], NULL, NULL, NULL);
        if (result == SQLITE_OK) {
            NSLog(@"成功创建表   #基础数据事件表#   %@",@"userInfoTable");
        }

        NSString *basisInfoDictionaryTable = @"CREATE TABLE IF NOT EXISTS BasisInfoDictionary (basisidid integer PRIMARY KEY AUTOINCREMENT NOT NULL,type text,code text,content text)";
        result = sqlite3_exec(database, [basisInfoDictionaryTable UTF8String], NULL, NULL, NULL);
        if (result == SQLITE_OK) {
            NSLog(@"成功创建表   #基础数据字典表#   %@",@"userInfoTable");
        }
        
    }];

}

#pragma mark 消息查询、存储、删除
+(NSArray<NSDictionary *> *)findChatListByUserId:(int)userId start:(int)start num:(int)num;
{
    NSString *sql = [NSString stringWithFormat:@"select * from ChatInfo t where t.userid=%i order by t.time desc LIMIT %i OFFSET %i",userId,num,start];
    NSArray *result = [self executeQuery:sql];

    return result;
}

+(NSArray<NSDictionary *> *)findUserListByGroupId:(long)groupId
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM GroupInfo t WHERE t.chatid=%li",groupId];
    NSArray *result = [self executeQuery:sql];
    return result;
}

/**
 <#Description#>

 @param chatId 本地聊天记录id localid
 @param start <#start description#>
 @param num <#num description#>
 @return <#return value description#>
 */
+(NSArray<NSDictionary *> *)findMsgListByChatId:(long)chatId start:(int)start num:(int)num
{
    NSString *sql = [NSString stringWithFormat:@"select * from (select * from ChatMessage t where t.chatid=%li order by t.time desc limit %i offset %i) order by time",chatId,num,start];
    NSArray *result = [self executeQuery:sql];
    return result;
}

+(NSArray<NSDictionary *> *)findMsgListByChatId:(long)chatId start:(long)start
{
    NSString *sql = [NSString stringWithFormat:@"select * from ChatMessage t where t.chatid=%li and t.id>%li order by t.time",chatId,start];
    NSArray *result = [self executeQuery:sql];
    return result;
}

+(void) saveUserList:(id)deptList
{
    if(deptList == nil){
        return;
    }
    
    NSString *deleteSql = @"DELETE FROM USERINFO;";
    [PersistenceUtils executeNoQuery:deleteSql];
    
    NSMutableArray<NSString *> *sqlArray = [[NSMutableArray<NSString *> alloc]init];
    NSString *sql = @"INSERT INTO USERINFO (userid,username,phone,deptid,deptname,station,remark) VALUES('%i','%@','%@','%i','%@','%@','%@');";
    
    NSString *deptName;
    int deptId;
    for(id dept in deptList){
        deptName = [dept objectForKey:@"departmentName"];
        deptId = [[dept objectForKey:@"id"] intValue];
        id userList = [dept objectForKey:@"users"];
        for(id item in userList){
            //创建sql语句
            [sqlArray addObject:[NSString stringWithFormat:sql,[[item objectForKey:@"id"] intValue],[item objectForKey:@"name"],
                                 [item objectForKey:@"phone"],deptId,deptName,@"",@""]];
        }
    }
    
    [self executeInsertBatch:sqlArray];

}

+(NSArray<DeptInfoModel *> *)loadUserListGroupByDept
{
    NSMutableArray<DeptInfoModel *> *result = [[NSMutableArray alloc] init];
    NSString *sql= @"SELECT * FROM USERINFO ORDER BY DEPTID,USERID";
    
    NSArray *rows= [PersistenceUtils executeQuery:sql];
    
    if(rows ==nil || [rows count]==0){
        [HttpsUtils loadAllUsers];
        return result;
    }
    NSMutableDictionary<NSString *,DeptInfoModel *> *deptDict = [[NSMutableDictionary alloc] init];
    UserInfoModel *userInfo;
    DeptInfoModel *dept;
    for(NSDictionary *user in rows){
        NSString *deptId = [user objectForKey:@"deptid"];
        dept = [deptDict objectForKey:deptId];
        if(dept == nil){
            dept = [[DeptInfoModel alloc] init];
            [deptDict setObject:dept forKey:deptId];
        }
        dept.deptName = [user objectForKey:@"deptname"];
        dept.deptId = [deptId longLongValue];
        userInfo = [[UserInfoModel alloc] init];
        userInfo.id = [[user objectForKey:@"userid"] intValue];
        userInfo.name = [user objectForKey:@"username"];
        userInfo.phone = [user objectForKey:@"phone"];
        userInfo.deptId = dept.deptId;
        userInfo.deptName = dept.deptName;
        [dept.userArray addObject:userInfo];
    }
    
    [result addObjectsFromArray:[deptDict allValues]];
    return result;
}

+(NSDictionary *)saveOrUpdateChat:(id)chat
{

    if(![chat isKindOfClass:[NSDictionary class]]){
        return nil;
    }
    int type = 0;
    NSString *single = nil;
    if([[chat allKeys] containsObject:@"single"]){
        single = [chat objectForKey:@"single"];
    }
    if(single==nil){
        type = 1;
    }
    int chatId = 0;
    NSString *name = @"";
    if(type==0){
        chatId = [[chat objectForKey:@"userId"] intValue];
        name = [chat objectForKey:@"userName"];
    }else{
        chatId = [[chat objectForKey:@"id"] intValue];
        name = [chat objectForKey:@"groupname"];
    }
    // 查询判断语句
    NSDictionary *localChat =  [self getLocalChatIdByName:name type:type chatId:chatId];
    int localId = [[localChat objectForKey:@"id"] intValue];
    
    if(type==1 && localId>=0){
        NSString *insertGroupSql = @"delete from GroupInfo where chatid=%i;commit;insert into GroupInfo(chatid,userid,username) select %i,t.userid,t.username from userinfo t where t.userid in (%@)";
        NSString *userids = [chat objectForKey:@"groupusers"];
        [self executeNoQuery:[NSString stringWithFormat:insertGroupSql,localId,localId,userids]];
    }
    return  localChat;
}

+(void)updateChatName:name chatId:(int)chatId
{
    NSString *updateSql = @"update ChatInfo set name='%@',time=CURRENT_TIMESTAMP where chatid=%i and userid=%i;";
    [self executeNoQuery:[NSString stringWithFormat:updateSql,name,chatId,[self getLocalUserId]]];
}

+(void)updateUnReadCountAndTime:(int)count chatid:(int)chatId;
{
    NSString *updateSql = @"update ChatInfo set time=CURRENT_TIMESTAMP,unread=unread+%i where id=%i and userid=%i;";
    [self executeNoQuery:[NSString stringWithFormat:updateSql,count,chatId,[self getLocalUserId]]];
}


/**
 <#Description#>

 @param message <#message description#>
 @param need 是否需要查询本地的localID来存储消息
 @param success <#success description#>
 */
+(void)insertNewChatMessage:(NSDictionary *)message needid:(BOOL)need success:(void (^)())success;
{
    if(message==nil)
        return;
    if(need){
        int type = [[message objectForKey:@"type"] intValue];
        int chatId = [[message objectForKey:@"chatid"] intValue];
        NSString *name = @"";
        if(type==1){
            name = [message objectForKey:@"username"];
        }else{
            NSDictionary *userDic = [self getUserById:chatId];
            if(userDic==nil){
                return;
            }
            name = [userDic objectForKey:@"username"];
        }
        NSDictionary *localChat =  [self getLocalChatIdByName:name type:type chatId:chatId];
        int localId = [[localChat objectForKey:@"id"] intValue];
        int userid = [[message objectForKey:@"userid"] intValue];
        NSString *content = [message objectForKey:@"content"];
        NSString *createTime = [message objectForKey:@"createTime"];
        [self saveChatMessage:localId content:content userid:userid userName:name time:createTime];
    }else{
        int localid = [[message objectForKey:@"chatid"] intValue];
        int userid = [[message objectForKey:@"userid"] intValue];
        NSString *userName = [message objectForKey:@"username"];
        NSString *content = [message objectForKey:@"content"];
        NSString *createTime = [message objectForKey:@"createTime"];
        [self saveChatMessage:localid content:content userid:userid userName:userName time:createTime];
    }
    if(success!=nil){
        success();
    }
}

+(void)saveChatMessage:(int)localid content:(NSString *)content userid:(int)userid userName:(NSString *)userName time:(NSString *)receivedTime
{
    NSString *insertSql = @"INSERT INTO ChatMessage VALUES (?, %i, '%@', %i, '%@', '%@', 0);";
    [self executeNoQuery:[NSString stringWithFormat:insertSql,localid,content,userid,userName,receivedTime]];
    [self updateUnReadCountAndTime:1 chatid:localid];
}


/**
 获取本地的聊天记录ID，如果没有新建一条聊天记录id

 @param name <#name description#>
 @param type <#type description#>
 @param chatId <#chatId description#>
 @return <#return value description#>
 */
+(NSDictionary *)getLocalChatIdByName:(NSString *)name type:(int)type chatId:(int)chatId
{
    // 查询判断语句
    NSString *querySql = @"select * from ChatInfo t where t.chatid=%i and t.type=%i and t.userid=%i";
    NSArray *result = [self executeQuery:[NSString stringWithFormat:querySql,chatId,type,[self getLocalUserId]]];
    if(result==nil || [result count]==0){
        NSString *insertChatSql = @"INSERT INTO ChatInfo VALUES (?, %i, '%@', %i, %i, CURRENT_TIMESTAMP, 0, null, null);";
        [self executeNoQuery:[NSString stringWithFormat:insertChatSql,chatId,name,type,[self getLocalUserId]]];
    }else{
        [self updateChatName:name chatId:chatId];
    }
    result = [self executeQuery:[NSString stringWithFormat:querySql,chatId,type,[self getLocalUserId]]];
    if(result==nil || [result count]==0){
        return nil;
    }
    NSDictionary *dic = [result objectAtIndex:0];
    return dic;
}

+(NSDictionary *)getUserById:(int)userId
{
    // 查询判断语句
    NSString *querySql = @"select * from userinfo t where t.userid=%i";
    NSArray *result = [self executeQuery:[NSString stringWithFormat:querySql,userId]];
    if(result==nil || [result count]==0){
        return nil;
    }
    NSDictionary *dic = [result objectAtIndex:0];
    return dic;
}

/**
 首次登陆的时候同步用户消息
 
 @param messages <#messages description#>
 */
+(void)syncUserMessages:(NSArray<NSDictionary *> *)messages
{
    
}

/**
 首次登陆的时候工作组消息
 
 @param messages <#messages description#>
 */
+(void)syncGroupMessages:(NSArray<NSDictionary *> *)messages
{
    
}

/**
 首次登陆的时候同步系统消息
 
 @param messages <#messages description#>
 */
+(void)syncSysMessages:(NSArray<NSDictionary *> *)messages
{
    if(messages ==nil || [messages count]==0){
        return;
    }
    NSString *ids = nil;
    NSMutableArray *array = [NSMutableArray array];
    for(NSDictionary *message in messages){
        if(ids==nil){
            ids = [message objectForKey:@"id"];
        }else{
            ids = [NSString stringWithFormat:@"%@,%@",ids,[message objectForKey:@"id"]];
        }
    }
    
    NSString *querysql = @"select msgid from SysMessage t where msgid in (%@)";
    NSArray *exists = [self executeQuery:[NSString stringWithFormat:querysql, ids]];
    ids = nil;
    if(exists!=nil && [exists count]>0){
        for(NSDictionary * msg in exists){
            if(ids==nil){
                ids = [msg objectForKey:@"msgid"];
            }else{
                ids = [NSString stringWithFormat:@"%@,%@",ids,[msg objectForKey:@"msgid"]];
            }
        }
    }
    
    for(NSDictionary *message in messages){
        if(ids!=nil && [ids containsString:[NSString stringWithFormat:@"%@",[message objectForKey:@"id"]]])
            continue;
        [array addObject:[self getInsertSysMessageSql:message]];
    }
    // 批量插入
    [self executeInsertBatch:array];
}

+(void)insertNewSysMessage:(NSDictionary *)message
{
    [self executeNoQuery:[self getInsertSysMessageSql:message]];
}

+(NSString *)getInsertSysMessageSql:(NSDictionary *)message
{
    int msgid = [[message objectForKey:@"id"] intValue];
    int toDept = [[message objectForKey:@"toDept"] isEqual:[NSNull null]]?0:[[message objectForKey:@"toDept"] intValue];
    NSString *type = [message objectForKey:@"type"];
    NSString *content = [message objectForKey:@"content"];
    NSString *title = [message objectForKey:@"title"];
    NSString *createTime = [message objectForKey:@"createTime"];
    NSString *status = [message objectForKey:@"status"];
    NSString *todeptIds = [message objectForKey:@"toDeptIds"];
    NSString *insertSql = @"INSERT INTO SysMessage VALUES (%i, '%@', '%@', '%@', '%@', '%@', '%@', %i, null, %i);";
    return [NSString stringWithFormat:insertSql,msgid,type,content,title,createTime,status,todeptIds,toDept,[self getLocalUserId]];
}

+(NSArray<NSDictionary *> *)findSysMsgListByType:(NSString *)type start:(long)start
{
    NSString *sql = nil;
    if([type isEqualToString:@"FLIGHT"]){
        sql = [NSString stringWithFormat:@"select * from SysMessage t where t.type='%@' and t.id>%li and t.userid=%i order by t.createtime",type,start,[self getLocalUserId]];
    }else{
        sql = [NSString stringWithFormat:@"select * from SysMessage t where t.type!='%@' and t.id>%li and t.userid=%i order by t.createtime",type,start,[self getLocalUserId]];
    }
    NSArray *result = [self executeQuery:sql];
    return result;
}

+(NSArray<NSDictionary *> *)findSysMsgListByType:(NSString *)type start:(int)start num:(int)num
{
    NSString *sql = nil;
    if([type isEqualToString:@"FLIGHT"]){
        sql = [NSString stringWithFormat:@"select * from SysMessage t where t.type='%@' and t.userid=%i order by t.createtime desc limit %i offset %i",type,[self getLocalUserId],num,start];
    }else{
        sql = [NSString stringWithFormat:@"select * from SysMessage t where t.type!='%@' and t.userid=%i order by t.createtime desc limit %i offset %i",type,[self getLocalUserId],num,start];
    }
    NSArray *result = [self executeQuery:sql];
    return result;
}


+(void)insertBasisInfoDictionaryWithDictionary:(NSDictionary *)dictionary
{
    int id = [[dictionary objectForKey:@"id"] intValue];
    NSString *code = [dictionary objectForKey:@"code"];
    NSString *content = [dictionary objectForKey:@"content"];
    NSString *type = [dictionary objectForKey:@"type"];
    NSString *insertSql = @"INSERT INTO BasisInfoDictionary VALUES (%i, '%@', '%@', '%@');";
    [self executeNoQuery:[NSString stringWithFormat:insertSql,id,type,code,content]];
    
}

+(NSArray *)findBasisInfoDictionaryWithType:(NSString *)type
{
    NSString *sql = [NSString stringWithFormat:@"select * from BasisInfoDictionary where type = '%@';",type];
    NSArray *result = [self executeQuery:sql];
    return result;
}
+(NSArray *)findBasisInfoDictionaryWithid:(int)Id
{
    NSString *sql = [NSString stringWithFormat:@"select * from BasisInfoDictionary where basisidid = %i;",Id];
    NSArray *result = [self executeQuery:sql];
    return result;
}
+(void)insertBasisInfoEventWithDictionary:(NSDictionary *)dictionary
{
    int id = [[dictionary objectForKey:@"id"] intValue];
    NSString *username = [dictionary objectForKey:@"username"];
    int event_type = [[dictionary objectForKey:@"event_type"] intValue];
    int dispatch_type = [[dictionary objectForKey:@"dispatch_type"] intValue];
    int event_level = [[dictionary objectForKey:@"event_level"] intValue];
    NSString *event = [dictionary objectForKey:@"event"];
    NSString *content = [dictionary objectForKey:@"content"];
    NSString *insertSql = @"INSERT INTO BasisInfoEvent VALUES (%i, '%@', %i, %i, %i, '%@','%@');";
    [self executeNoQuery:[NSString stringWithFormat:insertSql,id,username,event_type,dispatch_type,event_level,event,content]];

}

+(NSArray *)findBasisInfoEventWithEventId:(int)eventId dispatchId:(int)dispatchId eventLevel:(int)eventLevel
{
    NSString *sql = [NSString stringWithFormat:@"select * from BasisInfoEvent where event_type = %i and dispatch_type = %i and event_level = %i",eventId,dispatchId,eventLevel];
    NSArray *result = [self executeQuery:sql];
    return result;
}

+(NSArray *)findBasisInfoEventWithEventId:(int)eventId
{
    NSString *sql = [NSString stringWithFormat:@"select * from BasisInfoEvent where basisid = %i",eventId];
    NSArray *result = [self executeQuery:sql];
    return result;
}

/**
 更新消息状态

 @param msgId <#msgId description#>
 */
+(void)updateSysMessageRead:(long)msgId
{
    [self executeNoQuery:[NSString stringWithFormat:@"update SysMessage set readtime=CURRENT_TIMESTAMP where msgid=%li",msgId]];
}

+(int)getLocalUserId
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return (int)delegate.userInfoModel.id;
}
//+(void) updateAllMessage:(NSArray*) array{
//    if(array == nil || [array count] == 0){
//        return;
//    }
//    
//    
//    [self commonSqlProcess:^(sqlite3* database){
//        
//        for(MessageItem* messageItem in array){
//            sqlite3_stmt* statement;
//            NSString* sql = @"select Id from DT_MESSAGE where AssoId = ?";
//            
//            sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
//            
//            //设置占位符
//            sqlite3_bind_int(statement, 1, messageItem.assoId);
//            
//            int count = 0;//执行语句返回的结果数
//            while (sqlite3_step(statement) == SQLITE_ROW) {
//                count++;
//            }
//            
//            sqlite3_finalize(statement);
//            
//            if (count == 0) {
//                //数据库中没有，新插入到数据库中
//                sqlite3_stmt* insertStmt;
//                sql = @"insert into DT_MESSAGE(AssoId,MessageType,Sender,Title,Content,CreateTime,IsRead) values(?,?,?,?,?,?,?)";
//                
//                sqlite3_prepare_v2(database, [sql UTF8String], -1, &insertStmt, nil);
//                
//                //设置占位符
//                sqlite3_bind_int(insertStmt, 1, messageItem.assoId);
//                sqlite3_bind_text(insertStmt, 2, [[StringUtils trim:messageItem.msgType] UTF8String], -1, NULL);
//                sqlite3_bind_text(insertStmt, 3, [[StringUtils trim:messageItem.sender] UTF8String], -1, NULL);
//                sqlite3_bind_text(insertStmt, 4, [[StringUtils trim:messageItem.title] UTF8String], -1, NULL);
//                sqlite3_bind_text(insertStmt, 5, [[StringUtils trim:messageItem.content] UTF8String], -1, NULL);
//                sqlite3_bind_text(insertStmt, 6, [messageItem.createTime UTF8String], -1, NULL);
//                sqlite3_bind_int(insertStmt, 7, 0);
//                
//                sqlite3_step(insertStmt);
//                sqlite3_finalize(insertStmt);
//            }
//            
//        }
//        
//        
//    }];
//}

@end
