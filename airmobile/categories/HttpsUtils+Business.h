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

#pragma mark 消息部分 发送消息 发送群组消息 加载用户 保存工作组信息 获取工作组信息

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


/**
 查询所有用户
 */
+(void)loadAllUsers;


/**
 保存工作组

 @param groupInfo <#groupInfo description#>
 @param success <#success description#>
 */
+(void)saveGroupInfo:(NSDictionary *)groupInfo success:(void (^) (id)) success;


/**
 获取工作组信息

 @param groupId <#groupId description#>
 */
+(void)getGroupInfo:(long)groupId;

#pragma mark 航班列表 航班详情 航班保障详情 航班特殊详情

/**
 根据条件查询航班列表信息

 @param conditions 查询条件：flightNum：搜索的内容（模糊查询） screenRegion:区域筛选 screenModel：性质筛选 screenState：状态筛选 startSize：分页的起始页 allSize：每页的数据
 @param success 成功处理
 @param failue 异常处理
 */
+(void)queryFlightList:(NSDictionary *)conditions success:(void(^)(id))success failure:(void (^)(NSError *))failue;


/**
 获取航班的详细信息

 @param flightId <#flightId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightDetail:(int)flightId success:(void (^)(id))success failure:(void (^)(id))failure;

/**
 航班保障环节的详情

 @param flightId <#flightId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getDispatchDetail:(int)flightId success:(void (^)(id))success failure:(void (^)(id))failure;

/**
 航班特殊保障环节的详情

 @param flightId <#flightId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getSpecialDetail:(int)flightId success:(void (^)(id))success failure:(void (^)(id))failure;

#pragma mark 首页摘要信息、小时分布、放行正常率、航延关键指标
/**
 获取首页的摘要信息 /ov/summary

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getSummaryInfo:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 航班近10天放行正常率  /ov/fltFDR

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightTenDayRatio:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 今年航班放行正常率 /ov/fltFMR

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightYearRatio:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 航班延误指标 /fltLD

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightDelayTarget:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 计划进港航班小时分布 /flt/planArrFltPerHour

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getPlanArrHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 实际进港航班小时分布 /flt/realArrFltPerHour

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getRealArrHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 计划出港航班小时分布 /flt/depFltPerHour

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getPlanDepHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 实际出港航班小时分布 /flt/realDepFltPerHour

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getRealDepHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;

#pragma mark 首页航班汇总、异常原因分类、延误时长、小时分布

/**
 获取航班信息汇总 /ov/fltCnt

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightStatusInfo:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 航班异常原因分类 /flt/delayReasonSort

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightAbnReason:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 航班区域延误时间 /flt/delayAreaSort

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getRegionDlyTime:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;

#pragma mark 首页旅客页面 旅客摘要 旅客预测 隔离区内旅客小时分布 隔离区内旅客区域分布 机上等待旅客信息

/**
 获取旅客的摘要信息 /psn/inOutPsn

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getPassengerSummary:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 获取旅客预测信息 /psn/willInOutPsn

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getPassengerForecast:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 获取隔离区内旅客信息 /psn/glqRelatedPsn

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getSafetyPassenger:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 机上旅客等待信息 /psn/planeWaitSort

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getPassengerOnboard:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 进港旅客小时分布 /psn/arrPsnPerHour

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getArrPsnHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 出港旅客小时分布 /psn/depPsnPerHour

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getDepPsnHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 隔离区内旅客小时分布 /psn/glqPsnPerHour

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getSafetyPsnHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 旅客区域分布 /psn/glqNearPsn
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getGlqNearPsn:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
+(void)getGlqFarPsn:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;

/**
 高峰旅客日排名 /psn/peakPnsDays
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getPeakPnsDays:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;

#pragma mark 首页资源 机位使用信息

/**
 当前占用 当前占用、剩余机位、占用比 /rs/craftSeatTakeUpInfo

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getCraftSeatTakeUpInfo:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 机位占用预测 <1小时到港：10 <1小时出港：15 下小时机位占用：-5  /rs/willCraftSeatTakeUp

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getWillCraftSeatTakeUp:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 机位类型占用详情 /rs/craftSeatTypeTakeUpSort

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getCraftSeatTypeTakeUpSort:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;

//+(void)getSummaryInfo:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;
//
//+(void)getSummaryInfo:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;

@end
