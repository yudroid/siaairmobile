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

/**
 *  保存用户名
 */
static NSString* __userName = @"";

/**
 *  保存密码
 */
static NSString* __password = @"";

@implementation HttpsUtils (Business)

/**
 *  限制多设备登录
 *  当deviceInfo="0"时不进行多设备登录限制，格式-　设备ID：MAC地址：系统：手机号
 *  返回 1 登录成功  2 登录失败，用户名不存在 3登录失败，密码输入错误 4 用户被禁用 5已在其他设备登录，登录失败 6 账号已过期 7 MAC地址不匹配
 *
 *  @param userName <#userName description#>
 *  @param pwd      <#pwd description#>
 *  @param success  <#success description#>
 *  @param failure  <#failure description#>
 */
+(void) loginUser:(NSString*) userName pwd: (NSString*) pwd deviceInfo:(NSString*) deviceInfo success:(void (^) (id)) success failure:(void (^) (NSError*)) failure{
    NSString* segment = [NSString stringWithFormat:@"geese/auth/login2/%@/%@/%@",userName,pwd,deviceInfo];
    [HttpsUtils getString:segment params:nil success:success failure:^(NSError* error){
        [self addLog:[NSString stringWithFormat: @"error:%@",error] type:@"Error"];
        if(failure){
            failure(error);
        }
    }];
}


/**
 *  添加一条日志
 *
 *  @param logs    日志
 *  @param logType 日志类型
 */
+ (void) addLog:(NSString*) logs type:(NSString*) logType{
    
    @try {
        if ([StringUtils isNullOrEmpty:logs]) {
            return;
        }
        
        if ([StringUtils isNullOrEmpty:logType]) {
            logType = @"Info";
        }
        
        NSString* userName = __userName;
        
        if ([StringUtils isNullOrEmpty:userName]) {
            userName = @"UnknownUser";
        }
        
        NSString* device = [DeviceInfoUtil deviceVersions];
        
        if([StringUtils isNullOrEmpty:device]){
            device = @"UnknownDevice";
        }
        
        NSString* deviceId = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
        
        if([StringUtils isNullOrEmpty:deviceId]){
            deviceId = @"UnknownDeviceId";
        }
        
        if ([logs length]>=9100) {
            //截断，不能太长
            logs = [logs substringWithRange:NSMakeRange(0, 9000)];
        }
        
        
        //NSString* runParam = @"NoRunParam";
        
        NSMutableDictionary* params = [NSMutableDictionary new];
        NSLog(@"log length = %li",[logs length]);
        [params setObject:userName forKey:@"user"];
        [params setObject:logType forKey:@"logType"];
        [params setObject:logs forKey:@"log"];
        [params setObject:device forKey:@"deviceType"];
        [params setObject:deviceId forKey:@"deviceId"];
        [params setObject:@"NoRunParam" forKey:@"runParam"];
        
        //NSString *url = [NSString stringWithFormat:@"app/devicelog/%@/%@/%@/%@/%@/%@",[StringUtils urlEncoding:userName],[StringUtils urlEncoding:logType],[StringUtils urlEncoding:logs],[StringUtils urlEncoding:device],[StringUtils urlEncoding:deviceId],runParam];
        NSString *url = @"geese/app/devicelog";
        [HttpsUtils postString:url params:params success:^(id responseObj) {
            NSLog(@"%@",responseObj);
        } failure:nil];
        
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    
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


+(void)flightListSuccess:(void(^)(id))success failure:(void (^)(NSError *))failue
{
    success(nil);
}


@end
