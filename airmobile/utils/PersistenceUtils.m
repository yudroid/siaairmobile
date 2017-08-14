//
//  PersistenceUtils.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/4.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PersistenceUtils.h"

@implementation PersistenceUtils

#pragma mark -File&Directory

/**
 *  获取本程序的/Documents目录
 *
 *  @return <#return value description#>
 */
+(NSString*) getDirectoryOfDocuments{
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //[paths[0] stringByAppendingPathComponent:@"theFile.txt"];//构建在/Documents下的theFile.txt路径。
    return paths[0];
}




/**
 *  文件或目录是否存在
 *
 *  @param filePath <#filePath description#>
 *
 *  @return <#return value description#>
 */
+(BOOL) fileExist:(NSString*) filePath{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

/**
 *  将Dictionary写到文件中，如果文件存在，内容被覆盖,文件编码utf8
 *
 *  @param dictionary <#dictionary description#>
 *  @param fileName   f在ios中应该是/Documents目录或子目录下的文件
 */
+(void) writeDictionary:(NSDictionary*) dictionary toFile:(NSString*)  fileName{
    [dictionary writeToFile:fileName atomically:YES];
}

/**
 *  read file
 *
 *  @param fileName <#fileName description#>
 *
 *  @return <#return value description#>
 */
+(NSDictionary*) readDictionaryFromFile:(NSString*) fileName{
    return [NSDictionary dictionaryWithContentsOfFile:fileName];
}

#pragma mark -sqlite3


/**
 *  执行sql 用于插入、删除、修改
 *
 *  @param sql sql语句中无参数
 */
+(void) executeNoQuery:(NSString*) sql{
    [self commonSqlProcess:^(sqlite3* database){
        int result = sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL);
        if (result == SQLITE_OK) {
            //执行成功
        }
    }];
}

/**
 *  执行sql  用于插入、删除、修改 对于有?号占位符的sql语句
 *
 *  @param sql <#sql description#>
 */
+(void) executeNoQuery2:(NSString*) sql{
    [self commonSqlProcess:^(sqlite3* database){
        sqlite3_stmt* statement;
        //第三个参数，当为负时，表示sql字符串的长度直到\0结束的位置
        int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, NULL);
        
        if (result == SQLITE_OK) {
            //在此位置准备占位符
            //第二个参数：要设置的占位符索引，从1开始计数，
            //第三个参数：替换的值
            sqlite3_bind_int(statement, 1, 235);
            sqlite3_bind_text(statement, 2, [sql UTF8String], -1, NULL);
        }
        
        //#define SQLITE_DONE        101  /* sqlite3_step() has finished executing */
        if(sqlite3_step(statement) == SQLITE_DONE)
        {
            //执行成功
        }
        
        sqlite3_finalize(statement);
        
    }];
}

/**
 *  执行查询sql， sql语句中可以用?来作为占位符
 *
 *  @param sql <#sql description#>
 */
+(NSArray *) executeQuery:(NSString*) sql{
    //NSString* query = @"SELECT Id,Name,Age FROM TABLENAME";
    
    NSMutableArray *rows=[NSMutableArray array];//数据行
    [self commonSqlProcess:^(sqlite3* database){
        sqlite3_stmt* stmt;
        //第三个参数，当为负时，表示sql字符串的长度直到\0结束的位置
        
        int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil);
        
        if(result != SQLITE_OK){
            //Destroy A Prepared Statement Object
            sqlite3_finalize(stmt);//statement为NULL是无害的
            return;
        }
        
        //在此位置准备占位符
        //第二个参数：要设置的占位符索引，从1开始计数，
        //第三个参数：替换的值
        sqlite3_bind_int(stmt, 1, 235);
        sqlite3_bind_text(stmt, 2, [sql UTF8String], -1, NULL);
        
        //step计算sql语句
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //has another row ready
            //int rowNum = sqlite3_column_int(statement, 0);
            //NSString* name = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            int columnCount= sqlite3_column_count(stmt);
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            for (int i=0; i<columnCount; i++) {
                const char *name= sqlite3_column_name(stmt, i);//取得列名
                const unsigned char *value= sqlite3_column_text(stmt, i);//取得某列的值
                if(value==nil || value==NULL) {
                    continue;
                }
                dic[[[NSString stringWithUTF8String:name] lowercaseString]]=[NSString stringWithUTF8String:(const char *)value];
            }
            [rows addObject:dic];
            
        }
        
        //Destroy A Prepared Statement Object
        sqlite3_finalize(stmt);
        
    }];
    return rows;
}

/**
 *  @author yangql, 16-02-24 10:02:45
 *
 *  @brief 批量执行插入语句
 *
 *  @param sqlArray <#sqlArray description#>
 */
+ (void)executeInsertBatch:(NSArray *) sqlArray
{
    [self commonSqlProcess:^(sqlite3* database){
        NSMutableString *sql = [NSMutableString stringWithString:@"BEGIN;"];
        for (NSString *temp in sqlArray) {
            [sql appendString:temp];
        }
        [sql appendString:@"COMMIT;"];
        sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL);
    }];
}

/**
 *  处理sql，
 *
 *  @param action 实际处理的代码，不需要关心数据库的打开关闭，而专注于业务
 */
+(void) commonSqlProcess:(void(^)(sqlite3*)) action{
    sqlite3* database;
    const char* dbPath = [[self getSqlDb] UTF8String];
    //如果数据库存在，打开数据库，如果数据库不存在，新建一个
    int openResult = sqlite3_open(dbPath, &database);
    
    if (openResult != SQLITE_OK) {
        //打开连接失败  关闭连接，注：sqlite3_close可以接收NULL
        sqlite3_close(database);
        return;
    }
    @try{
        if (action) {
            //实际的处理
            action(database);
        }
    }
    @finally{
        
    }
    sqlite3_close(database);
}

/**
 *  获取sql执行使用的DB文件
 *
 *
 *  @return <#return value description#>
 */
+(NSString*) getSqlDb{
    NSString* docPath = [self getDirectoryOfDocuments];
    //[string UTF8String]   [NSString stringWithUTF8String:dbPath]; [[NSString alloc] initWithUTF8String:dbPath]来在NSString和const char*之间进行转换
    return [docPath stringByAppendingPathComponent:@"qdcares.db"];
}

@end
