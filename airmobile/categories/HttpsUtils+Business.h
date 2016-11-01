//
//  HttpsUtils+Business.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/11.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "HttpsUtils.h"

@interface HttpsUtils (Business)

/**
 *  限制多设备登录
 *  当deviceId="0"时不进行多设备登录限制
 *  返回 1 登录成功  2 登录失败，用户名不存在 3登录失败，密码输入错误 4 用户被禁用 5已在其他设备登录，登录失败
 *
 *  @param userName <#userName description#>
 *  @param pwd      <#pwd description#>
 *  @param success  <#success description#>
 *  @param failure  <#failure description#>
 */
+(void) loginUser:(NSString*) userName pwd: (NSString*) pwd deviceInfo:(NSString*) deviceInfo success:(void (^) (id)) success failure:(void (^) (NSError*)) failure;

/**
 *  @author yangql, 16-05-12 13:05:52
 *
 *  @brief 登录成功后绑定uuid
 *
 *  @param userName userName 用户账号
 *  @param deviceId deviceId 设备uuid
 */
+ (void)binding:(NSString *) userName uuid:(NSString *) deviceId;

/**
 *  设置用户名
 *
 *  @param userName <#userName description#>
 */
+(void) setUserName:(NSString*) userName;

/**
 *  设置密码
 *
 *  @param password <#password description#>
 */
+(void) setPassword:(NSString*) password;


/**
 *  航班列表
 *
 *  @parm <#parm#> <#description#>
 *
 */
+(void)flightListSuccess:(void(^)(id))success failure:(void (^)(NSError *))failue;


@end
