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


/**
 获取用户最近的聊天消息

 @param userId <#userId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getUserMsgList:(int)userId success:(void(^)(id))success failure:(void (^)(NSError *))failure;


/**
 获取用户组消息

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getGroupMsgListSuccess:(void(^)(id))success failure:(void (^)(NSError *))failure;


/**
 返回的消息类型

     DELAY_HEAVY   航班大面积延误
     WARNING    航班预警
     FLIGHT    航班信息
     GUARD_1     一级警备
     GUARD_2     二级警备
     GUARD_3     三级警备
     COMMAND    指令
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getAlertMsgListSuccess:(void(^)(id))success failure:(void (^)(NSError *))failure;


/**
 聊天记录列表进行同步
 
 @param userId <#userId description#>
 */
+(void)sysChatInfoList:(int)userId;


/**
 获取组聊天记录列表

 @param chatId <#chatId description#>
 @param localId <#localId description#>
 */
+(void)getGroupChatMsgListByGroupId:(int)chatId localId:(int)localId;


/**
 用户聊天记录列表

 @param userId <#userId description#>
 @param chatId <#chatId description#>
 @param localId <#localId description#>
 */
+(void)getUserChatMsgListFrom:(int)userId to:(int)chatId localId:(int)localId;

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


/**
 获取保障环节的异常上班记录

 @param dispatchId 保障环节的异常ID
 @param type 保障环节、勤务环节类型 1是关键 0是普通
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getDispatchAbns:(int)dispatchId type:(int)type success:(void (^)(id))success failure:(void (^)(id))failure;

/**
 航班特殊保障环节的详情
 
 @param flightId <#flightId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)saveDispatchNormal:(int)flightId dispatchId:(int)dispatchId userId:(int)userId success:(void (^)(id))success failure:(void (^)(id))failure;

/**
 航班特殊保障环节的详情

 @param flightId <#flightId description#>
 @param dispatchId <#dispatchId description#>
 @param userId <#userId description#>
 @param eventId <#eventId description#>
 @param memo <#memo description#>
 @param flag <#flag description#>
 @param imgPath <#imgPath description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)saveDispatchAbnStart:(int)flightId dispatchId:(int)dispatchId userId:(int)userId eventId:(int)eventId memo:(NSString *)memo
                       flag:(int)flag imgPath:(NSString *)imgPath success:(void (^)(id))success failure:(void (^)(id))failure;

/**
 航班特殊保障环节的详情

 @param dispatchAbnId <#dispatchAbnId description#>
 @param userId <#userId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)saveDispatchAbnEnd:(int)dispatchAbnId userId:(int)userId success:(void (^)(id))success failure:(void (^)(id))failure;

#pragma mark 功能页面 值班表 通讯录

/**
 获取当日保障列表

 @param day <#day description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getDutyTableByDay:(NSString *)day success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 获取通讯录列表

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getContactList:(void (^)(id))success failure:(void (^)(id))failure;


#pragma mark 我的 签到 签退 修改密码 同步基础数据 同步异常事件 退出 更新密码


/**
 签到

 @param userId <#userId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)signIn:(int)userId success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 签退

 @param userId <#userId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)signOut:(int)userId success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 签到状态

 @param userId <#userId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)isSigned:(int)userId success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 退出登录

 @param userId <#userId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)logOut:(int)userId success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 更新密码

 @param jobno <#jobno description#>
 @param pwd <#pwd description#>
 @param newpwd <#newpwd description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)updatePwd:(NSString *)jobno pwd:(NSString *)pwd newpwd:(NSString *)newpwd success:(void (^)(id))success failure:(void (^)(id))failure;

/**
 加载事件数据

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)loadEventsSuccess:(void (^)(id))success failure:(void (^)(id))failure;
//进度条
+(void)loadEventsProgress:(void (^) (float))progress
                  Success:(void (^)(id))success
                  failure:(void (^)(id))failure;


/**
 加载基础数据

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)loadDictDatasSuccess:(void (^)(id))success failure:(void (^)(id))failure;

+(void)loadDictDatasProgress:(void (^) (float))progress
                     Success:(void (^)(id))success
                     failure:(void (^)(id))failure;

#pragma mark 首页摘要信息、小时分布、放行正常率、航延关键指标
/**
 获取首页的摘要信息 /ov/summary

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getSummaryInfo:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 航班放行正常率 天数 --最近10天 /ov/fltFDR

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getTenDaySuccess:(void (^)(id))success failure:(void (^)(id))failure;


/**
 放行正常率  阈值

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)releaseRatioThresholdSuccess:(void (^)(id))success failure:(void (^)(id))failure;


/**
 航班近10天放行正常率  /ov/fltFDR

 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightTenDayRatio:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure;


/**
 航班放行正常率 月数 --最近19个月 /ov/fltFDR

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightYearSuccess:(void (^)(id))success failure:(void (^)(id))failure;

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
 出港 阈值

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)fltDepFltTargetSuccess:(void (^)(id))success failure:(void (^)(id))failure;


/**
 进港速率

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)fltArrFltTargetSuccess:(void (^)(id))success failure:(void (^)(id))failure;
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

#pragma mark -生产指标

/**
 *  年度航班指标
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void) yearFltSuccess:(void (^) (id)) success failure:(void (^) (NSError*)) failure;

/**
 *  年度货邮指标
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void) yearCmSuccess:(void (^) (id)) success failure:(void (^) (NSError*)) failure;


/**
 *  年度旅客指标
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void) yearPsnSuccess:(void (^) (id)) success failure:(void (^) (NSError*)) failure;

/**
 *  月度航班指标
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void) monthFltSuccess:(void (^) (id)) success failure:(void (^) (NSError*)) failure;

/**
 *  月度货邮指标
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void) monthCmSuccess:(void (^) (id)) success failure:(void (^) (NSError*)) failure;


/**
 *  月度旅客指标
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */


/**
 *  @author yangql, 16-03-07 20:03:59
 *
 *  @brief 功能页面-航班查询-查询航班列表
 *
 *  @param url     按照航班号或航站查询列表
 *  @param success 成功返回航班列表
 *  @param failure <#failure description#>
 */
+ (void)seekFlightList:(NSString *)url success:(void (^)(id))success failure:(void (^)(NSError *))failure;



+(void) monthPsnSuccess:(void (^) (id)) success failure:(void (^) (NSError*)) failure;

/**
 头像上传
 */
+(void)headImageUploadSuccess:(void (^)(id))success
                      failure:(void (^)(id))failure;



/**
 版本检测

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)versionCheckSuccess:(void (^)(id))success
                   failure:(void (^)(id))failure;


/**
 异常上报上传图片

 @param image 图片
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)unusualImageUploadImage:(UIImage *)image
                       Success:(void (^)(id))success
                       failure:(void (^)(id))failure;

#pragma mark -查询航站列表
/**
 *  @author yangql, 16-02-23 12:02:34
 *
 *  @brief 查询航站信息
 *
 *  @param success 查询成功后缓存航站信息
 *  @param failure 失败记录日志
 */
+(void) airportQuerySucess:(void (^)(id))success
                   failure:(void (^)(NSError *))failure;

/**
 获取server ip列表

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void) serverIpListSucess:(void (^)(id))success
                   failure:(void (^)(NSError *))failure;


/**
 航空公司列表

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)airlineListSucess:(void (^)(id))success
                 failure:(void (^)(NSError *))failure;


/**
 运行简报-日报

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)mobileDayLogSucess:(void (^)(id))success
               failure:(void (^)(NSError *))failure;

/**
 运行简报-周报

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)mobileWeekLogSucess:(void (^)(id))success
                  failure:(void (^)(NSError *))failure;
/**
 运行简报-月报

 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)mobileMonthLogSucess:(void (^)(id))success
                  failure:(void (^)(NSError *))failure;
@end
