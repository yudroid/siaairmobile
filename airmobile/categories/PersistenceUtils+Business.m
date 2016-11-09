//
//  PersistenceUtils+Business.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/4.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PersistenceUtils+Business.h"
#import "HttpsUtils+Business.h"

@implementation PersistenceUtils (Business)

/**
 *  初始化数据库
 */
+(void) initTable{
    [self commonSqlProcess:^(sqlite3* database){
        //IF NOT EXISTS才创建表，所以这是可以重复执行的
        //NSString* createSql = @"CREATE TABLE IF NOT EXISTS TABLENAME(Id INTEGER PRIMARY KEY AUTOINCREMENT, Name TEXT NOT NULL, Age INTEGER)";
        
        NSString *chatInfoTable = @"CREATE TABLE IF NOT EXISTS ChatInfo (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,chatid integer,name nvarchar(128),type integer(1),time datetime,unread integer(5) DEFAULT(0),describe nvarchar(256),remark nvarchar(128));";
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
        
        NSString *sysMsgTable = @"CREATE TABLE IF NOT EXISTS SysMessage (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,type integer(2) NOT NULL,content nvarchar(1024),status integer(1),time datetime NOT NULL);";
        result = sqlite3_exec(database, [sysMsgTable UTF8String], NULL, NULL, NULL);
        if (result == SQLITE_OK) {
            NSLog(@"成功创建表   #系统消息事件表#   %@",@"sysMsgTable");
        }
        
    }];
    [self initTableData];
}


+(void) initTableData
{
    NSMutableArray *chatList = [[NSMutableArray alloc] init];
    [chatList addObject:@"INSERT INTO ChatInfo VALUES (20, 66, '张宇', 0, '2016-11-06 12:22:00', 0, null, null);"];
    [chatList addObject:@"INSERT INTO ChatInfo VALUES (2, 10205, '青岛凯亚深圳项目组', 1, '2016-11-06 12:30:00', 0, null, null);"];

    [self executeInsertBatch:chatList];
    
    NSMutableArray *chatMsgList = [[NSMutableArray alloc] init];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (1, 20, '代码提交了吗？', 66, '张宇', '2016-11-06 12:30:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (2, 20, '还没，稍等', 65, '杨泉林', '2016-11-06 12:40:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (3, 20, '加快，要发布了', 66, '张宇', '2016-11-06 12:50:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (4, 20, '代码提交了吗？', 66, '张宇', '2016-11-06 12:55:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (5, 20, '还没，稍等', 65, '杨泉林', '2016-11-06 12:55:03', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (6, 20, '加快，要发布了', 66, '张宇', '2016-11-06 12:56:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (7, 20, '代码提交了吗？', 66, '张宇', '2016-11-06 12:57:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (8, 20, '还没，稍等', 65, '杨泉林', '2016-11-06 12:58:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (9, 20, '加快，要发布了', 66, '张宇', '2016-11-06 12:58:10', null);"];
    
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (51, 2, '代码提交了吗？', 66, '张宇', '2016-11-06 12:30:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (52, 2, '还没，稍等', 65, '杨泉林', '2016-11-06 12:40:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (53, 2, '加快，要发布了', 66, '张宇', '2016-11-06 12:50:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (54, 2, '代码提交了吗？', 66, '张宇', '2016-11-06 12:55:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (55, 2, '还没，稍等', 65, '杨泉林', '2016-11-06 12:55:03', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (56, 2, '加快，要发布了', 66, '张宇', '2016-11-06 12:56:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (57, 2, '代码提交了吗？', 66, '张宇', '2016-11-06 12:57:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (58, 2, '还没，稍等', 65, '杨泉林', '2016-11-06 12:58:00', null);"];
    [chatMsgList addObject:@"INSERT INTO ChatMessage VALUES (59, 2, '加快，要发布了', 66, '张宇', '2016-11-06 12:58:10', null);"];
    
    
    [self executeInsertBatch:chatMsgList];
    
    NSMutableArray *groupList = [[NSMutableArray alloc] init];
    [groupList addObject:@"INSERT INTO GroupInfo VALUES (1, 3, 1, '杨泉林', null, null);"];
    [groupList addObject:@"INSERT INTO GroupInfo VALUES (2, 3, 2, '蓝蓝', null, null);"];
    [groupList addObject:@"INSERT INTO GroupInfo VALUES (3, 3, 3, '宝宝', null, null);"];
    [groupList addObject:@"INSERT INTO GroupInfo VALUES (4, 11, 4, '贝贝', null, null);"];
    [groupList addObject:@"INSERT INTO GroupInfo VALUES (5, 11, 5, '莹莹', null, null);"];
    [groupList addObject:@"INSERT INTO GroupInfo VALUES (6, 11, 6, '盈盈', null, null);"];
    [groupList addObject:@"INSERT INTO GroupInfo VALUES (7, 12, 7, '芳芳', null, null);"];
    [groupList addObject:@"INSERT INTO GroupInfo VALUES (8, 12, 5, '萱萱', null, null);"];
    [self executeInsertBatch:groupList];
    
}

#pragma mark 消息查询、存储、删除
+(NSArray<NSDictionary *> *)findChatList:(int)start num:(int)num;
{
    NSString *sql = [NSString stringWithFormat:@"select * from ChatInfo t order by t.time desc LIMIT %i OFFSET %i",num,start];
    NSArray *result = [self executeQuery:sql];

    return result;
}

+(NSArray<NSDictionary *> *)findUserListByGroupId:(long)groupId
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM GroupInfo t WHERE t.chatid=%li",groupId];
    NSArray *result = [self executeQuery:sql];
    return result;
}

+(NSArray<NSDictionary *> *)findMsgListByChatId:(long)chatId start:(int)start num:(int)num
{
    NSString *sql = [NSString stringWithFormat:@"select * from (select * from ChatMessage t where t.chatid=%li order by t.time desc limit %i offset %i) order by time",chatId,num,start];
    NSArray *result = [self executeQuery:sql];
    return result;
}

+(NSArray<NSDictionary *> *)findMsgListByChatId:(long)chatId start:(long)start
{
    NSString *sql = [NSString stringWithFormat:@"select * from ChatMessage t where t.chatid=%li and t.id=%li order by t.time",chatId,start];
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

@end
