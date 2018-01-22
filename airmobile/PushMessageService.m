//
//  MessageService.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/2.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PushMessageService.h"
#import "PersistenceUtils+Business.h"
#import "ConcernModel.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UILocalNotification+Business.h"
#import "AppDelegate.h"

//#define wsuserurl @"ws://219.134.93.113:8087/acs/usermsg"  //用户消息
//#define wsgroupurl @"ws://219.134.93.113:8087/acs/workgroupmsg"//群组消息
//#define wssysurl @"ws://219.134.93.113:8087/acs/alertmsg"//系统消息

//#define wsuserurl @"ws://192.168.163.126:8080/acs/usermsg"
//#define wsgroupurl @"ws://192.168.163.126:8080/acs/workgroupmsg"
//#define wssysurl @"ws://192.168.163.126:8080/acs/alertmsg"

//#define wsuserurl @"ws://192.168.163.153:8080/acs/usermsg"
//#define wsgroupurl @"ws://192.168.163.153:8080/acs/workgroupmsg"
//#define wssysurl @"ws://192.168.163.153:8080/acs/alertmsg"

//#define wsuserurl1  @"ws://192.168.163.132:8088/acs/websocketmsg/1/usermsg"
//#define wsgroupurl1 @"ws://192.168.163.132:8088/acs/websocketmsg/1/workgroupmsg"
//#define wssysurl1   @"ws://192.168.163.132:8088/acs/websocketmsg/1/alertmsg"
//#define wsabnurl1   @"ws://192.168.163.132:8088/acs/websocketmsg/1/abnevent"//异常事件消息

//#define wsuserurl2  @"ws://192.168.163.132:8088/acs/websocketmsg/2/usermsg"
//#define wsgroupurl2 @"ws://192.168.163.132:8088/acs/websocketmsg/2/workgroupmsg"
//#define wssysurl2   @"ws://192.168.163.132:8088/acs/websocketmsg/2/alertmsg"
//#define wsabnurl2   @"ws://192.168.163.132:8088/acs/websocketmsg/2/abnevent"//异常事件消息

#define usertype  @"usermsg"//用户消息
#define grouptype @"workgroupmsg"//群组消息
#define systype   @"alertmsg"//变更消息
#define abntype   @"abnevent"//异常事件消息
////
//#define wsuserurl2  @"ws://219.134.93.113:8087/acs/websocketmsg/2/usermsg"
//#define wsgroupurl2 @"ws://219.134.93.113:8087/acs/websocketmsg/2/workgroupmsg"
//#define wssysurl2   @"ws://219.134.93.113:8087/acs/websocketmsg/2/alertmsg"
//#define wsabnurl2   @"ws://219.134.93.113:8087/acs/websocketmsg/2/abnevent"//异常事件消息

//#define wsuserurl @"ws://192.168.163.72:8080/acs/usermsg"  //用户消息
//#define wsgroupurl @"ws://192.168.163.72:8080/acs/workgroupmsg"//群组消息
//#define wssysurl @"ws://192.168.163.72:8080/acs/alertmsg"//系统消息


@implementation PushMessageService
{
    long _clientId;
    long _userId;
    long _toId;
    BOOL _group;
}

singleton_implementation(PushMessageService);



-(void)resetDialogParam:(long)clientId
                 userId:(long)userId
                   toId:(long)toId
                   type:(BOOL)type
{
    _clientId   = clientId;
    _toId       = toId;
    _group      = type;

}


- (void)didReceiveMessage:(id)message
{
    // usermessage --- "{"content":"Yang","createTime":"2016-11-10 15:17:06","fromId":65,"handleStatus":0,"id":65,"toId":66}"
    // groupmessage --- "{"content":"Yang also","createTime":"2016-04-10 15:40:20","sendUserId":65,"sendUserName":"杨泉林","workgroupId":619,"workgroupTitle":"成员: admin 张宇","workgroupUserIds":"1,66"}"
    // sysmessage --- "toDept toDeptIds"

    NSLog(@"Received \"%@\"", message);

    if (_userId == 0) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _userId = appDelegate.userInfoModel.id;
        if (_userId == 0) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            _userId = [userDefaults doubleForKey:@"USERID"];
        }
    }

    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];

    NSString *msgType = [dic objectForKey:@"type"]; //= [webSocket.url absoluteString];

//    [UILocalNotification sendLocalNotificationWithTitle:[dic objectForKey:@"type"] content:[dic objectForKey:@"content"]];

    if([msgType isEqualToString:usertype]){
        if(![[dic allKeys] containsObject:@"createTime"]){
            return;
        }
        long toId   = [[dic objectForKey:@"toId"] longLongValue];
        long fromId = [[dic objectForKey:@"fromId"] longLongValue];
        if(toId != _userId || fromId == _userId){
            return;
        }
        NSMutableDictionary *msgDict = [NSMutableDictionary dictionary];
        [msgDict setValue:[NSNumber numberWithLong:fromId]  forKey:@"chatid"];// 源头
        [msgDict setValue:[dic objectForKey:@"content"]     forKey:@"content"];
        [msgDict setValue:[NSNumber numberWithLong:fromId]  forKey:@"userid"];
        [msgDict setValue:[NSNumber numberWithLong:0]       forKey:@"type"];
        [msgDict setValue:[dic objectForKey:@"createTime"]  forKey:@"createTime"];
        [msgDict setValue:[dic objectForKey:@"flag"]        forKey:@"flag"];

        [PersistenceUtils insertNewChatMessage:msgDict
                                        needid:YES
                                       success:^{
                                           if(_chatDelegate != nil){
                                               [_chatDelegate refreshDialogData];
                                           }
                                           if(_chatListDelegate != nil){
                                               [_chatListDelegate refreshChatInfoList];
                                           }
                                           [_curTabBarView setHasNewMessage:YES];
                                       }];
    }else if([msgType isEqualToString:grouptype]
             //             ||[urlString isEqualToString:wsgroupurl2]
             ){
        if(![[dic allKeys] containsObject:@"createTime"]){
            return;
        }

        NSDictionary *msgDict = [self dicToMsDic:dic];

        [PersistenceUtils insertNewChatMessage:msgDict needid:YES success:^{
            if(_chatDelegate != nil){
                [_chatDelegate refreshDialogData];
            }
            if(_chatListDelegate != nil){
                [_chatListDelegate refreshChatInfoList];
            }
        }];
    }else if([msgType isEqualToString:systype]
             //             ||[urlString isEqualToString:wssysurl2]
             ){

        if(![[dic allKeys] containsObject:@"createTime"] || ![[dic allKeys] containsObject:@"type"]){
            return;
        }
        if (![[dic objectForKey:@"type"] containsString:@"FLIGHT"]) {

            NSMutableDictionary *msgDict = [self toMessageDic:dic];
            [PersistenceUtils insertNewSysMessage:msgDict];
            NSString *type = [dic objectForKey:@"type"];
            if(_curTabBarView != nil && type!=nil && ![type containsString:@"FLIGHT"]){
                [_curTabBarView setHasNewMessage:YES];
            }
        }else{
            if([[dic objectForKey:@"type"] containsString:@"FTSS"]){
                NSString *msgContent  = [dic objectForKey:@"content"];
                for (NSDictionary *dic in [ConcernModel allConcernModel]) {
                    if ([msgContent containsString:dic[@"key"]]) {

                        //声音提示
                        [self voice];

                        //消息存储
                        NSMutableDictionary *msgDict = [self toMessageDic:dic];
                        [PersistenceUtils insertNewSysMessage:msgDict];
                        NSString *type = [dic objectForKey:@"type"];
                        if(_curTabBarView != nil && type!=nil && ![type containsString:@"FLIGHT"]){
                            [_curTabBarView setHasNewMessage:YES];
                        }

                        //发送本地通知
                        [UILocalNotification sendFlightChangeNotificationWithContent:msgContent];
                        UIApplicationState state = [UIApplication sharedApplication].applicationState;
                        if(state == UIApplicationStateBackground){

                        }
                    }
                }
            }else{
                NSMutableDictionary *msgDict = [self toMessageDic:dic];
                [PersistenceUtils insertNewSysMessage:msgDict];
                NSString *type = [dic objectForKey:@"type"];
                if(_curTabBarView != nil && type!=nil && ![type containsString:@"FLIGHT"]){
                    [_curTabBarView setHasNewMessage:YES];
                }
            }
        }




        //处理航班关注
        if([[dic objectForKey:@"type"] containsString:@"FTSS"]){
            NSString *content = [dic objectForKey:@"content"] ;
            if (![content isEqualToString:@"前方起飞"]) {
                if ([content containsString:@"起飞"]||[content containsString:@"取消"]) {
                    for (NSDictionary *dic in [ConcernModel allConcernModel]) {
                        if ([content containsString:dic[@"key"]]) {
                            [ConcernModel removeConcernModel:dic[@"key"]];
                        }
                    }
                }else{
                    if ([content containsString:@"到达"]) {
                        for (NSDictionary *dic in [ConcernModel allConcernModel]) {
                            if ([content containsString:dic[@"key"]]&&((NSNumber*)dic[@"value"]).integerValue == 1)             {
                                [ConcernModel removeConcernModel:dic[@"key"]];
                            }

                        }
                    }
                }
            }
        }

    }
    else if([msgType isEqualToString:abntype]
            //            ||[urlString isEqualToString:wsabnurl2]
            ){

        long msgId = [[dic objectForKey:@"id"] longLongValue];
        //        long todept = [[dic objectForKey:@"toDept"] isEqual:[NSNull null]]?0:[[dic objectForKey:@"toDept"] longLongValue];
        NSMutableDictionary *msgDict = [NSMutableDictionary dictionary];
        [msgDict setValue:[NSNumber numberWithLong:msgId]        forKey:@"id"];// 主键
        [msgDict setValue:@"abnevent"        forKey:@"type"];
        NSString *content = [NSString stringWithFormat:@"%@ %@ %@",[dic objectForKey:@"oneName"]?:@"",[dic objectForKey:@"twoName"]?:@"",[dic objectForKey:@"eventDesc"]?:@""];
        [msgDict setValue:content   forKey:@"content"];
        [msgDict setValue:[dic objectForKey:@"oneName"]?:@""    forKey:@"title"];
        [msgDict setValue:[dic objectForKey:@"submitDate"]    forKey:@"createTime"];
        [msgDict setValue:@""    forKey:@"status"];
        [msgDict setValue:@""        forKey:@"toDeptIds"];
        [msgDict setValue:@""      forKey:@"toDept"];


        [PersistenceUtils insertNewSysMessage:msgDict];
        NSString *type = [msgDict objectForKey:@"type"];
        if(_curTabBarView != nil && type!=nil && ![type containsString:@"FLIGHT"]){
            [_curTabBarView setHasNewMessage:YES];
        }

    }

}

-(void)voice{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL voice =((NSNumber *)[defaults objectForKey:@"MessageVoice"]).boolValue;
    if( !voice){
        //震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    else if( voice){
        SystemSoundID soundId = 0;
        NSString* path = [[NSBundle mainBundle] pathForResource:@"msg" ofType:@"wav"];
        if (path) {
            AudioServicesCreateSystemSoundID((__bridge  CFURLRef)[NSURL fileURLWithPath:path], &soundId);
            AudioServicesPlaySystemSound(soundId);
        }
    }

}

-(NSMutableDictionary *)dicToMsDic:(NSDictionary *)dic
{
    long toId   = [[dic objectForKey:@"workgroupId"] longLongValue];
    long fromId = [[dic objectForKey:@"sendUserId"] longLongValue];
    if(fromId == _userId){
        return nil;
    }
    NSMutableDictionary *msgDict = [NSMutableDictionary dictionary];
    [msgDict setValue:[NSNumber numberWithLong:toId]        forKey:@"chatid"];// 源头
    [msgDict setValue:[dic objectForKey:@"content"]         forKey:@"content"];
    [msgDict setValue:[NSNumber numberWithLong:fromId]      forKey:@"userid"];
    [msgDict setValue:[dic objectForKey:@"sendUserName"]    forKey:@"username"];
    [msgDict setValue:[NSNumber numberWithLong:1]           forKey:@"type"];
    [msgDict setValue:[dic objectForKey:@"createTime"]       forKey:@"createTime"];
    [msgDict setValue:[dic objectForKey:@"workgroupTitle"] forKey:@"workgroupTitle"];
    return msgDict;



}
//将接受的Dic转为存储数据库的Dic
-(NSMutableDictionary *)toMessageDic:(NSDictionary *)dic{
    long msgId = [[dic objectForKey:@"id"] longLongValue];
    long todept = [[dic objectForKey:@"toDept"] isEqual:[NSNull null]]?0:[[dic objectForKey:@"toDept"] longLongValue];
    NSMutableDictionary *msgDict = [NSMutableDictionary dictionary];
    [msgDict setValue:[NSNumber numberWithLong:msgId]        forKey:@"id"];// 主键
    [msgDict setValue:[dic objectForKey:@"type"]         forKey:@"type"];
    [msgDict setValue:[dic objectForKey:@"content"]    forKey:@"content"];
    [msgDict setValue:[dic objectForKey:@"title"]    forKey:@"title"];
    [msgDict setValue:[dic objectForKey:@"createTime"]    forKey:@"createTime"];
    [msgDict setValue:[dic objectForKey:@"status"]    forKey:@"status"];
    [msgDict setValue:[dic objectForKey:@"toDeptIds"]        forKey:@"toDeptIds"];
    [msgDict setValue:[NSNumber numberWithLong:todept]      forKey:@"toDept"];
    return msgDict;
}



@end
