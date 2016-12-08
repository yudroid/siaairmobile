//
//  HttpsUtils+Business.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/11.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "HttpsUtils+Business.h"
#import "StringUtils.h"
#import <AdSupport/ASIdentifierManager.h>
#import "UserInfoModel.h"
#import "PersistenceUtils+Business.h"
#import "ThreadUtils.h"

/**
 *  保存用户名
 */
static NSString* __userName = @"";
/**
 *  保存密码
 */
static NSString* __password = @"";


NSString * const base                       = @"http://192.168.163.29";
NSString * const loginUrl                   = @"/acs/login/mobile";
NSString * const logoutUrl                  = @"/acs/login/logout";
NSString * const userMsgSendUrl             = @"/acs/um/m";// 发送用户消息
NSString * const groupMsgSendUrl            = @"/acs/wm/m";// 发送工作组消息
//NSString * const 
NSString * const userlistUrl                = @"/acs/wacs/user/SelectAllDeptListForIphone";
NSString * const groupSaveUrl               = @"/acs/wacs/group/save";
NSString * const flightListUrl              = @"/acs/m/flightList";// 航班列表
NSString * const flightDetailUrl            = @"/acs/m/flightDetail";// 航班详情列表
NSString * const dispatchDetailsUrl         = @"/acs/m/getDispatchsByFlightId";// 航班保障环节列表
NSString * const specialDetailsUrl          = @"/acs/wacs/MobileSpecial/queryMobileSpecialList";// 特殊保障列表
NSString * const dispatchAbnsUrl            = @"/acs/m/getExceptionByFlightDispatchId";//获取异常历史列表
NSString * const saveDispatchAbnStart = @"/acs/wacs/MobileSpecial/MobileSaveSpecialABNDispatch";//上报开始(航班ID/环节ID/用户ID/事件ID/要求/是否是特殊航班);
NSString * const saveDispatchAbnEnd = @"/acs/wacs/MobileSpecial/MobileUpdateSpecialABNDispatchCompelete";//上报结束(异常ID/用户ID);
NSString * const saveDispatchNormal = @"/acs/wacs/MobileSpecial/MobileSaveSpecialNormalDispatch";//特殊保障上报正常(航班id/环节ID/用户ID),返回结果是时间（时：分）
// 首页
NSString * const ovSummaryUrl               = @"/acs/ov/summary";
NSString * const ovFltFDRlUrl               = @"/acs/ov/fltFDR";
NSString * const ovFltFMRUrl                = @"/acs/ov/fltFMR";
NSString * const ovFltLDUrl                 = @"/acs/ov/fltLD";
NSString * const planArrFltPerHourUrl       = @"/acs/bmap/flt/arrFltPerHour";
NSString * const realArrFltPerHourUrl       = @"/acs/bmap/flt/arrFltPerHour";
NSString * const depFltPerHourUrl           = @"/acs/bmap/flt/depFltPerHour";
NSString * const realDepFltPerHourUrl       = @"/acs/bmap/flt/depFltPerHour";
NSString * const ovFltCntUrl                = @"/acs/ov/fltCnt";
NSString * const delayReasonSortUrl         = @"/acs/bmap/flt/delayReasonSort";
NSString * const delayAreaSortUrl           = @"/acs/bmap/flt/delayAreaSort";
NSString * const inOutPsnUrl                = @"/acs/bmap/psn/inOutPsn";
NSString * const willInOutPsnUrl            = @"/acs/bmap/psn/willInOutPsn";
NSString * const glqRelatedPsnUrl           = @"/acs/bmap/psn/glqRelatedPsn";
NSString * const planeWaitSortUrl           = @"/acs/bmap/psn/planeWaitSort";
NSString * const arrPsnPerHourUrl           = @"/acs/bmap/psn/arrPsnPerHour";
NSString * const depPsnPerHourUrl           = @"/acs/bmap/psn/depPsnPerHour";
NSString * const glqPsnPerHourUrl           = @"/acs/bmap/psn/glqPsnPerHour";
NSString * const glqNearPsnUrl              = @"/acs/bmap/psn/glqNearPsn";
NSString * const glqFarPsnUrl              = @"/acs/bmap/psn/glqFarPsn";
NSString * const peakPnsDaysUrl             = @"/acs/bmap/psn/peakPnsDays";
NSString * const craftSeatTakeUpInfoUrl     = @"/acs/bmap/rs/craftSeatTakeUpInfo";
NSString * const willCraftSeatTakeUpUrl     = @"/acs/bmap/rs/willCraftSeatTakeUp";
NSString * const craftSeatTypeTakeUpSortUrl = @"/acs/bmap/rs/craftSeatTypeTakeUpSort";
// 功能
NSString * const dutyTableByDayUrl = @"/acs/dms/airportScheduling/getDutyBySpeDay";// 员工值班表，按天的
NSString * const phoneRecordUrl = @"/acs/wacs/user/SelectAllDeptListForIphone";// 通讯录
// 我的
NSString * const signInUrl= @"/acs/m/signIn";//签到
NSString * const signOutUrl = @"/acs/m/signOut";//签退
NSString * const isSignedUrl = @"/acs/m/signStatus";//获取签到状态 1已经签退 2签到未签退 3未签到
NSString * const logOutUrl = @"/acs/login/mobileLogout";//注销
NSString * const loadDictDataUrl = @"/acs/wacs/MobileFirstLoading/queryMobileDict";//获取基础字典数据
NSString * const loadEventUrl = @"/acs/wacs/MobileFirstLoading/queryMobileEvent";//获取事件数据
NSString * const updatePwdUrl = @"/acs/login/updatePwd";//修改密码

@implementation HttpsUtils (Business)

/**
 *  限制多设备登录
 *  当deviceInfo="0"时不进行多设备登录限制，格式-　设备ID：MAC地址：系统：手机号
 *  返回 1 登录成功  2 登录失败，用户名不存在 3登录失败，密码输入错误 4 用户被禁用 5已在其他设备登录，登录失败 6 账号已过期 7 MAC地址不匹配
 *
 *  @param userName userName description
 *  @param pwd      pwd description
 *  @param success  success description
 *  @param failure  failure description
 */
+(void) loginUser:(NSString*) userName pwd: (NSString*) pwd deviceInfo:(NSString*) deviceInfo success:(void (^) (id)) success failure:(void (^) (NSError*)) failure{

    NSDictionary *params = [NSDictionary dictionaryWithObjects:@[userName,pwd] forKeys:@[@"username",@"password"]];
    
    [HttpsUtils post:loginUrl params:params success:^(id responseObj) {
        UserInfoModel *user = [[UserInfoModel alloc]initWithDictionary:responseObj];
//        [user setValuesForKeysWithDictionary:responseObj];
        success(user);
    }  failure:failure];
}


/**
 *  添加一条日志
 *
 *  @param logs    日志
 *  @param logType 日志类型
 */
+ (void) addLog:(NSString*) logs type:(NSString*) logType{
    
     NSLog(@"%@",logs);
//    @try {
//        if ([StringUtils isNullOrEmpty:logs]) {
//            return;
//        }
//        
//        if ([StringUtils isNullOrEmpty:logType]) {
//            logType = @"Info";
//        }
//        
//        NSString* userName = __userName;
//        
//        if ([StringUtils isNullOrEmpty:userName]) {
//            userName = @"UnknownUser";
//        }
//        
//        NSString* device = [DeviceInfoUtil deviceVersions];
//        
//        if([StringUtils isNullOrEmpty:device]){
//            device = @"UnknownDevice";
//        }
//        
//        NSString* deviceId = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//        
//        if([StringUtils isNullOrEmpty:deviceId]){
//            deviceId = @"UnknownDeviceId";
//        }
//        
//        if ([logs length]>=9100) {
//            //截断，不能太长
//            logs = [logs substringWithRange:NSMakeRange(0, 9000)];
//        }
//        
//        
//        //NSString* runParam = @"NoRunParam";
//        
//        NSMutableDictionary* params = [NSMutableDictionary new];
//        NSLog(@"log length = %li",[logs length]);
//        [params setObject:userName forKey:@"user"];
//        [params setObject:logType forKey:@"logType"];
//        [params setObject:logs forKey:@"log"];
//        [params setObject:device forKey:@"deviceType"];
//        [params setObject:deviceId forKey:@"deviceId"];
//        [params setObject:@"NoRunParam" forKey:@"runParam"];
//        
//        //NSString *url = [NSString stringWithFormat:@"app/devicelog/%@/%@/%@/%@/%@/%@",[StringUtils urlEncoding:userName],[StringUtils urlEncoding:logType],[StringUtils urlEncoding:logs],[StringUtils urlEncoding:device],[StringUtils urlEncoding:deviceId],runParam];
//        NSString *url = @"geese/app/devicelog";
//        [HttpsUtils postString:url params:params success:^(id responseObj) {
//            NSLog(@"%@",responseObj);
//        } failure:nil];
//        
//    } @catch (NSException *exception) {
//        NSLog(@"%@",exception);
//    }
    
}

/**
 *  @author yangql, 16-05-12 13:05:52
 *
 *  @brief 登录成功后绑定uuid
 *
 *  @param userName userName 用户账号
 *  @param deviceId deviceId 设备uuid
 */
+ (void)binding:(NSString *)userName uuid:(NSString *)deviceId
{
    NSString* segment = [NSString stringWithFormat:@"geese/app/bindmac/%@/%@",userName,deviceId];
    [HttpsUtils getString:segment params:nil success:^(id resp){
        // 绑定成功记录下信息
        [DefaultHelper setString:@"1" forKey:@"Goose.LOGINFIRSTTIME"];
    } failure:^(NSError* error){
        [self addLog:[NSString stringWithFormat: @"用户%@绑定设备%@失败:%@",userName,deviceId,error] type:@"Error"];
    }];
}

/**
 *  设置用户名
 *
 *  @param userName <#userName description#>
 */
+(void) setUserName:(NSString*) userName{
    __userName = userName;
}

/**
 *  设置密码
 *
 *  @param password <#password description#>
 */
+(void) setPassword:(NSString*) password{
    __password = password;
}


+(void)sendUserMessage:(MessageModel *)message success: (void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils postString:userMsgSendUrl params:[message toUserMsgNSDictionary]  success:success failure:failure];
}

+(void)sendGroupMessage:(MessageModel *)message success: (void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils postString:groupMsgSendUrl params:[message toGroupMsgNSDictionary]  success:success failure:failure];
}

+(void)loadAllUsers
{
    [HttpsUtils post:userlistUrl params:nil success:^(id responseObj) {
        [ThreadUtils dispatch:^{
            [PersistenceUtils saveUserList:responseObj];
        }];
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)saveGroupInfo:(NSDictionary *)groupInfo success:(void (^) (id)) success
{
    [HttpsUtils post:groupSaveUrl params:groupInfo success:^(id responseObj) {
        NSLog(@"%@",responseObj);
        if(success){
            success(responseObj);
        }
    } failure:^(NSError * error) {
        
    }];
}

+(void)getGroupInfo:(long)groupId
{
    
}

#pragma mark 航班 列表查询 航班明细 保障环节列表 重点保障环节列表 环节异常记录列表 报告正常 报告异常开始结束

+(void)queryFlightList:(NSDictionary *)conditions success:(void(^)(id))success failure:(void (^)(NSError *))failue
{
    [HttpsUtils get:flightListUrl params:conditions success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failue];
}

+(void)getFlightDetail:(int)flightId success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:flightDetailUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}

+(void)getDispatchDetail:(int)flightId success:(void (^)(id))success failure:(void (^)(id))failure
{
    NSString *temp = [NSString stringWithFormat:@"%@?flightId=%i",dispatchDetailsUrl,flightId];
    [HttpsUtils get:temp params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}

+(void)getSpecialDetail:(int)flightId success:(void (^)(id))success failure:(void (^)(id))failure
{
    NSString *temp = [NSString stringWithFormat:@"%@/%i",specialDetailsUrl,flightId];
    [HttpsUtils get:temp params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}

/**
 获取保障环节的异常上班记录
 
 @param dispatchId 保障环节的异常ID
 @param type 保障环节、勤务环节类型
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getDispatchAbns:(int)dispatchId type:(int)type success:(void (^)(id))success failure:(void (^)(id))failure
{
    
}

/**
 航班特殊保障环节的详情
 
 @param flightId <#flightId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)saveDispatchNormal:(int)flightId success:(void (^)(id))success failure:(void (^)(id))failure
{
    
}

/**
 航班特殊保障环节的详情
 
 @param flightId <#flightId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)saveDispatchAbnStart:(int)flightId success:(void (^)(id))success failure:(void (^)(id))failure
{
    
}

/**
 航班特殊保障环节的详情
 
 @param flightId <#flightId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)saveDispatchAbnEnd:(int)flightId success:(void (^)(id))success failure:(void (^)(id))failure
{
    
}

#pragma mark 首页摘要信息、小时分布、放行正常率、航延关键指标
/**
 获取首页的摘要信息 /ov/summary
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getSummaryInfo:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:ovSummaryUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 航班近10天放行正常率  /ov/fltFDR
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightTenDayRatio:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:ovFltFDRlUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 今年航班放行正常率 /ov/fltFMR
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightYearRatio:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:ovFltFMRUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 航班延误指标 /fltLD
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightDelayTarget:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:ovFltLDUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 计划进港航班小时分布 /flt/planArrFltPerHour
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getPlanArrHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:planArrFltPerHourUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 实际进港航班小时分布 /flt/realArrFltPerHour
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getRealArrHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure{
    [HttpsUtils get:realArrFltPerHourUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 计划出港航班小时分布 /flt/depFltPerHour
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getPlanDepHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:depFltPerHourUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 实际出港航班小时分布 /flt/realDepFltPerHour
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getRealDepHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:realDepFltPerHourUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}

#pragma mark 首页航班汇总、异常原因分类、延误时长、小时分布

/**
 获取航班信息汇总 /ov/fltCnt
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightStatusInfo:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:ovFltCntUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 航班异常原因分类 /flt/delayReasonSort
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getFlightAbnReason:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:delayReasonSortUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 航班区域延误时间 /flt/delayAreaSort
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getRegionDlyTime:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:delayAreaSortUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}

#pragma mark 首页旅客页面 旅客摘要 旅客预测 隔离区内旅客小时分布 隔离区内旅客区域分布 机上等待旅客信息

/**
 获取旅客的摘要信息 /psn/inOutPsn
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getPassengerSummary:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:inOutPsnUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 获取旅客预测信息 /psn/willInOutPsn
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getPassengerForecast:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:willInOutPsnUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 获取隔离区内旅客信息 /psn/glqRelatedPsn
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getSafetyPassenger:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:glqRelatedPsnUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 机上旅客等待信息 /psn/planeWaitSort
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getPassengerOnboard:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:planeWaitSortUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 进港旅客小时分布 /psn/arrPsnPerHour
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getArrPsnHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:arrPsnPerHourUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 出港旅客小时分布 /psn/depPsnPerHour
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getDepPsnHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:depPsnPerHourUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 隔离区内旅客小时分布 /psn/glqPsnPerHour
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getSafetyPsnHours:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:glqPsnPerHourUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}

/**
 旅客区域分布 /psn/glqNearPsn
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getGlqNearPsn:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:glqNearPsnUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}
+(void)getGlqFarPsn:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:glqFarPsnUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 高峰旅客日排名 /psn/peakPnsDays
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getPeakPnsDays:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:peakPnsDaysUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}

#pragma mark 首页资源 机位使用信息

/**
 当前占用 当前占用、剩余机位、占用比 /rs/craftSeatTakeUpInfo
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getCraftSeatTakeUpInfo:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:craftSeatTakeUpInfoUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 机位占用预测 <1小时到港：10 <1小时出港：15 下小时机位占用：-5  /rs/willCraftSeatTakeUp
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getWillCraftSeatTakeUp:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:willCraftSeatTakeUpUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}


/**
 机位类型占用详情 /rs/craftSeatTypeTakeUpSort
 
 @param date <#date description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getCraftSeatTypeTakeUpSort:(NSString *)date success:(void (^)(id))success failure:(void (^)(id))failure
{
    [HttpsUtils get:craftSeatTypeTakeUpSortUrl params:nil success:^(id responseObj) {
        if(success){
            success(responseObj);
        }
    } failure:failure];
}

#pragma mark 功能页面 值班表 通讯录

/**
 获取当日保障列表
 
 @param day <#day description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getDutyTableByDay:(NSString *)day success:(void (^)(id))success failure:(void (^)(id))failure
{
    
}


/**
 获取通讯录列表
 
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)getContactList:(void (^)(id))success failure:(void (^)(id))failure
{
    
}


#pragma mark 我的 签到 签退 修改密码 同步基础数据 同步异常事件 退出 更新密码


/**
 签到
 
 @param userId <#userId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)signIn:(int)userId success:(void (^)(id))success failure:(void (^)(id))failure
{
    
}


/**
 签退
 
 @param userId <#userId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)signOut:(int)userId success:(void (^)(id))success failure:(void (^)(id))failure
{
    
}


/**
 签到状态
 
 @param userId <#userId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)isSigned:(int)userId success:(void (^)(id))success failure:(void (^)(id))failure
{
    
}


/**
 退出登录
 
 @param userId <#userId description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)logOut:(int)userId success:(void (^)(id))success failure:(void (^)(id))failure
{
    
}


/**
 更新密码
 
 @param userId <#userId description#>
 @param pwd <#pwd description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)updatePwd:(int)userId pwd:(NSString *)pwd success:(void (^)(id))success failure:(void (^)(id))failure
{
    
}

/**
 加载事件数据
 
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)loadEventsSuccess:(void (^)(id))success failure:(void (^)(id))failure
{
    
}


/**
 加载基础数据
 
 @param success <#success description#>
 @param failure <#failure description#>
 */
+(void)loadDictDatasSuccess:(void (^)(id))success failure:(void (^)(id))failure
{
    
}

@end
