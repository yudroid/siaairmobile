//
//  MessageService.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/2.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "MessageService.h"
#import "PersistenceUtils+Business.h"
#import "ConcernModel.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UILocalNotification+Business.h"

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

#define wsuserurl1  @"ws://219.134.93.113:8087/acs/websocketmsg/1/usermsg"
#define wsgroupurl1 @"ws://219.134.93.113:8087/acs/websocketmsg/1/workgroupmsg"
#define wssysurl1   @"ws://219.134.93.113:8087/acs/websocketmsg/1/alertmsg"
#define wsabnurl1   @"ws://219.134.93.113:8087/acs/websocketmsg/1/abnevent"//异常事件消息
////
//#define wsuserurl2  @"ws://219.134.93.113:8087/acs/websocketmsg/2/usermsg"
//#define wsgroupurl2 @"ws://219.134.93.113:8087/acs/websocketmsg/2/workgroupmsg"
//#define wssysurl2   @"ws://219.134.93.113:8087/acs/websocketmsg/2/alertmsg"
//#define wsabnurl2   @"ws://219.134.93.113:8087/acs/websocketmsg/2/abnevent"//异常事件消息

//#define wsuserurl @"ws://192.168.163.72:8080/acs/usermsg"  //用户消息
//#define wsgroupurl @"ws://192.168.163.72:8080/acs/workgroupmsg"//群组消息
//#define wssysurl @"ws://192.168.163.72:8080/acs/alertmsg"//系统消息


@implementation MessageService
{
    SRWebSocket *userWebSocket1;
    SRWebSocket *groupWebSocket1;
    SRWebSocket *sysWebSocket1;
    SRWebSocket *abnWebSocket1;

//    SRWebSocket *userWebSocket2;
//    SRWebSocket *groupWebSocket2;
//    SRWebSocket *sysWebSocket2;
//    SRWebSocket *abnWebSocket2;

    long _clientId;
    long _userId;
    long _toId;
    BOOL _group;
}

singleton_implementation(MessageService);

-(void)setUserId:(int)userId
{
    _userId = userId;
}

-(void)startService
{
    [self regiestWebSocket];
    [super startService:^{
        [self refreshMessage];
    }];
}

-(void)resetDialogParam:(long)clientId
                 userId:(long)userId
                   toId:(long)toId
                   type:(BOOL)type
{
    _clientId   = clientId;
    _toId       = toId;
    _group      = type;

}

-(void)refreshMessage
{
    
}

-(void) regiestWebSocket
{
    userWebSocket1.delegate = nil;
    [userWebSocket1 close];
    userWebSocket1 = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wsuserurl1]]];
    userWebSocket1.delegate = self;
    NSLog(@"Opening Connection...");
    [userWebSocket1 open];

//    userWebSocket2.delegate = nil;
//    [userWebSocket2 close];
//    userWebSocket2 = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wsuserurl2]]];
//    userWebSocket2.delegate = self;
//    NSLog(@"Opening Connection...");
//    [userWebSocket2 open];

    groupWebSocket1.delegate = nil;
    [groupWebSocket1 close];
    groupWebSocket1 = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wsgroupurl1]]];
    groupWebSocket1.delegate = self;
    NSLog(@"Opening Connection...");
    [groupWebSocket1 open];


//    groupWebSocket2.delegate = nil;
//    [groupWebSocket2 close];
//    groupWebSocket2 = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wsgroupurl2]]];
//    groupWebSocket2.delegate = self;
//    NSLog(@"Opening Connection...");
//    [groupWebSocket2 open];


    sysWebSocket1.delegate = nil;
    [sysWebSocket1 close];
    sysWebSocket1 = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wssysurl1]]];
    sysWebSocket1.delegate = self;
    NSLog(@"Opening Connection...");
    [sysWebSocket1 open];

//    sysWebSocket2.delegate = nil;
//    [sysWebSocket2 close];
//    sysWebSocket2 = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wssysurl2]]];
//    sysWebSocket2.delegate = self;
//    NSLog(@"Opening Connection...");
//    [sysWebSocket2 open];


    abnWebSocket1.delegate = nil;
    [abnWebSocket1 close];
    abnWebSocket1 = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wsabnurl1]]];
    abnWebSocket1.delegate = self;
    NSLog(@"Opening Connection...");
    [abnWebSocket1 open];

//    abnWebSocket2.delegate = nil;
//    [abnWebSocket2 close];
//    abnWebSocket2 = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wsabnurl2]]];
//    abnWebSocket2.delegate = self;
//    NSLog(@"Opening Connection...");
//    [abnWebSocket2 open];

}

-(void)stopService
{
    [super stopService];
    [userWebSocket1 close];
    [groupWebSocket1 close];
    [sysWebSocket1 close];
    [abnWebSocket1 close];

//    [userWebSocket2 close];
//    [groupWebSocket2 close];
//    [sysWebSocket2 close];
//    [abnWebSocket2 close];
//    
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    // usermessage --- "{"content":"Yang","createTime":"2016-11-10 15:17:06","fromId":65,"handleStatus":0,"id":65,"toId":66}"
    // groupmessage --- "{"content":"Yang also","createTime":"2016-04-10 15:40:20","sendUserId":65,"sendUserName":"杨泉林","workgroupId":619,"workgroupTitle":"成员: admin 张宇","workgroupUserIds":"1,66"}"
    // sysmessage --- "toDept toDeptIds"
    
    NSLog(@"Received \"%@\"", message);

    NSString *urlString = [webSocket.url absoluteString];
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(dic == nil){
        return;
    }


    if([urlString isEqualToString:wsuserurl1]
//       ||[urlString isEqualToString:wsuserurl2]
       ){
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
        [msgDict setValue:[dic objectForKey:@"createTime"]       forKey:@"createTime"];
        [msgDict setValue:[dic objectForKey:@"flag"] forKey:@"flag"];
    

        [PersistenceUtils insertNewChatMessage:msgDict
                                        needid:YES
                                       success:^{
                if(_chatDelegate != nil){
                    [_chatDelegate refreshDialogData];
                }
                                           
                if(_chatListDelegate != nil){
                     [_chatListDelegate refreshChatInfoList];
                }
            }];
    }else if([urlString isEqualToString:wsgroupurl1]
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
    }else if([urlString isEqualToString:wssysurl1]
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
    else if([urlString isEqualToString:wsabnurl1]
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

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"Websocket Connected------webSocket %@",webSocket);
    NSString *urlString = [webSocket.url absoluteString];
    if([urlString isEqualToString:wsuserurl1]
//       ||[urlString isEqualToString:wsuserurl2]
       ){
        [webSocket send:[NSString stringWithFormat:@"register:%li",_userId]];
    }
    
    //    NSError *error;
    //
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"id":@"2",@"clientid":@"yangql_2016",@"to":@""} options:NSJSONWritingPrettyPrinted error:&error];
    //
    //    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //
    //    [webSocket send:jsonString];
    
    //    [self sendMessage];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    webSocket = nil;
}
- (void)webSocket:(SRWebSocket *)   webSocket
 didCloseWithCode:(NSInteger)       code
           reason:(NSString *)      reason
         wasClean:(BOOL)            wasClean
{
    NSLog(@"WebSocket closed");
    
    webSocket = nil;
}

// Return YES to convert messages sent as Text to an NSString. Return NO to skip NSData -> NSString conversion for Text messages. Defaults to YES.
- (BOOL)webSocketShouldConvertTextFrameToString:(SRWebSocket *)webSocket
{
    return YES;
}

//- (void)sendMessage{

//    NSError *error;
//
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"id":@"2",@"clientid":@"yangql_2016",@"to":@"wangdeyan2016",@"msg":@{@"type":@"0",@"content":@"发送的测试消息"}} options:NSJSONWritingPrettyPrinted error:&error];
//
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    [srWebSocket send:jsonString];
//}

@end
