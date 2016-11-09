//
//  PersistenceUtils.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/4.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface PersistenceUtils : NSObject

#pragma mark -File&Directory

/**
 *  获取本程序的/Documents目录
 *
 *  @return <#return value description#>
 */
+(NSString*) getDirectoryOfDocuments;


/**
 *  文件或目录是否存在
 *
 *  @param filePath <#filePath description#>
 *
 *  @return <#return value description#>
 */
+(BOOL) fileExist:(NSString*) filePath;


/**
 *  将Dictionary写到文件中，如果文件存在，内容被覆盖,文件编码utf8
 *
 *  @param dictionary <#dictionary description#>
 *  @param fileName   f在ios中应该是/Documents目录或子目录下的文件
 */
+(void) writeDictionary:(NSDictionary*) dictionary toFile:(NSString*)  fileName;

/**
 *  read file
 *
 *  @param fileName <#fileName description#>
 *
 *  @return <#return value description#>
 */
+(NSDictionary*) readDictionaryFromFile:(NSString*) fileName;



#pragma mark -sqlite3


/*
 sqlite3提供了C/C++接口
 Cora Data是apple提供的ORM框架
 sqlite3创建的数据库默认是UTF-8编码的
 
 */

/**
 *  执行sql  用于插入、删除、修改
 *
 *  @param sql <#sql description#>
 */
+(void) executeNoQuery:(NSString*) sql;

/**
 *  执行sql  用于插入、删除、修改 对于有?号占位符的sql语句
 *
 *  @param sql <#sql description#>
 */
+(void) executeNoQuery2:(NSString*) sql;

/**
 *  执行查询sql
 *
 *  @param sql <#sql description#>
 */
+(NSArray *) executeQuery:(NSString*) sql;

/**
 *  处理sql，
 *
 *  @param action 实际处理的代码，不需要关心数据库的打开关闭，而专注于业务
 */
+(void) commonSqlProcess:(void(^)(sqlite3*)) action;


/**
 *  获取sql执行使用的DB文件
 *
 *
 *  @return <#return value description#>
 */
+(NSString*) getSqlDb;

/**
 *  @author yangql, 16-02-23 20:02:51
 *
 *  @brief 执行批量插入操作
 *
 *  @param sqlArray sql的数组
 */
+(void) executeInsertBatch:(NSArray *) sqlArray;


@end
