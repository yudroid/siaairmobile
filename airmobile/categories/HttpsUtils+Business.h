//
//  HttpsUtils+Business.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/11.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "HttpsUtils.h"
#import "MessageModel.h"

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
 根据条件查询航班列表信息

 @param conditions 查询条件：flightNum：搜索的内容（模糊查询） screenRegion:区域筛选 screenModel：性质筛选 screenState：状态筛选 startSize：分页的起始页 allSize：每页的数据
 @param success 成功处理
 @param failue 异常处理
 */
+(void)queryFlightList:(NSDictionary *)conditions success:(void(^)(id))success failure:(void (^)(NSError *))failue;



/**
 发送个人消息

 @param message 消息内容
 @param success 成功回调
 @param failure 失败回调
 */
+(void)sendUserMessage:(MessageModel *)message success: (void (^)(id))success failure:(void (^)(id))failure;

/**
 发送工作组消息
 
 @param message 消息内容
 @param success 成功回调
 @param failure 失败回调
 */
+(void)sendGroupMessage:(MessageModel *)message success: (void (^)(id))success failure:(void (^)(id))failure;

+(void)loadAllUsers;

+(void)saveGroupInfo:(NSDictionary *)groupInfo success:(void (^) (id)) success;

+(void)getGroupInfo:(long)groupId;


/**
 <#Description#>

 @param flightId <#flightId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightDetail:(int)flightId success:(void (^)(id))success failure:(void (^)(id))failure;

+(void)getDispatchDetail:(int)flightId success:(void (^)(id))success failure:(void (^)(id))failure;

+(void)getSpecialDetail:(int)flightId success:(void (^)(id))success failure:(void (^)(id))failure;

@end
