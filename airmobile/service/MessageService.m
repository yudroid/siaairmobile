//
//  MessageService.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/2.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "MessageService.h"
#import "PersistenceUtils+Business.h"
//#define wsuserurl @"ws://219.134.93.113:8087/acs/usermsg"
//#define wsgroupurl @"ws://219.134.93.113:8087/acs/workgroupmsg"
//#define wssysurl @"ws://219.134.93.113:8087/acs/alertmsg"

#define wsuserurl @"ws://192.168.163.69:80/acs/usermsg"
#define wsgroupurl @"ws://192.168.163.69:80/acs/workgroupmsg"
#define wssysurl @"ws://192.168.163.69:80/acs/alertmsg"

@implementation MessageService
{
    SRWebSocket *userWebSocket;
    SRWebSocket *groupWebSocket;
    SRWebSocket *sysWebSocket;
    long _clientId;
    long _userId;
    long _toId;
    BOOL _group;
}

singleton_implementation(MessageService);

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
    _userId     = userId;
    _toId       = toId;
    _group      = type;
//    if(userWebSocket == nil){
//        [self regiestWebSocket];
//    }
    if(!type){
        [userWebSocket send:[NSString stringWithFormat:@"register:%li",_clientId]];
    }
}

-(void)refreshMessage
{
    
}

-(void) regiestWebSocket
{
    userWebSocket.delegate = nil;
    [userWebSocket close];
    userWebSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wsuserurl]]];
    userWebSocket.delegate = self;
    NSLog(@"Opening Connection...");
    [userWebSocket open];
    
    groupWebSocket.delegate = nil;
    [groupWebSocket close];
    groupWebSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wsgroupurl]]];
    groupWebSocket.delegate = self;
    NSLog(@"Opening Connection...");
    [groupWebSocket open];
    
    sysWebSocket.delegate = nil;
    [sysWebSocket close];
    sysWebSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wssysurl]]];
    sysWebSocket.delegate = self;
    NSLog(@"Opening Connection...");
    [sysWebSocket open];
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
    
    if([urlString isEqualToString:wsuserurl]){
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
        
        [PersistenceUtils insertNewChatMessage:msgDict
                                        needid:YES
                                       success:^{
                if(_chatDelegate != nil){
                    [_chatDelegate refreshDialogData];
                }
            }];
    }else if([urlString isEqualToString:wsgroupurl]){
        if(![[dic allKeys] containsObject:@"createTime"]){
            return;
        }
        long toId   = [[dic objectForKey:@"workgroupId"] longLongValue];
        long fromId = [[dic objectForKey:@"sendUserId"] longLongValue];
        if(fromId == _userId){
            return;
        }
        NSMutableDictionary *msgDict = [NSMutableDictionary dictionary];
        [msgDict setValue:[NSNumber numberWithLong:toId]        forKey:@"chatid"];// 源头
        [msgDict setValue:[dic objectForKey:@"content"]         forKey:@"content"];
        [msgDict setValue:[NSNumber numberWithLong:fromId]      forKey:@"userid"];
        [msgDict setValue:[dic objectForKey:@"sendUserName"]    forKey:@"username"];
        [msgDict setValue:[NSNumber numberWithLong:1]           forKey:@"type"];
        [msgDict setValue:[dic objectForKey:@"createTime"]       forKey:@"createTime"];
        
        [PersistenceUtils insertNewChatMessage:msgDict needid:YES success:^{
            if(_chatDelegate != nil){
                [_chatDelegate refreshDialogData];
            }
        }];
    }else if([urlString isEqualToString:wssysurl]){
        
        if(![[dic allKeys] containsObject:@"createTime"]){
            return;
        }
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
        
        [PersistenceUtils insertNewSysMessage:msgDict];

    }
 
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"Websocket Connected");
    [webSocket send:[NSString stringWithFormat:@"register:%li",_userId]];
    
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
