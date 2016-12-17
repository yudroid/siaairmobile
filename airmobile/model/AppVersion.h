//
//  AppVersion.h
//  KaiYa
//
//  Created by 杨泉林研发部 on 16/3/11.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppVersion : NSObject
/**
 *  程序版本号，从1开始计数的整数，程序内部用来判断是否是新版本的，每次升级加1
 */
@property (strong,nonatomic) NSString *build;
/**
 *  显示给用户给的版本号，不用于程序判断是否是新版本，
 显示给用户的版本，尽量每次升级值不同
 建议 采用  主版本.副版本 格式
 */
@property(strong,nonatomic) NSString *version;

/**
 *  用来下载最新版本程序的地址
 */
@property(strong,nonatomic) NSString *url;

/**
 *  目前来说，给用户提示升级方式的信息，如果没有，不用填
 */
@property (strong,nonatomic) NSString* tip;


/**
 *  本次升级的内容
 */
@property(strong,nonatomic) NSString *describe;

@end
