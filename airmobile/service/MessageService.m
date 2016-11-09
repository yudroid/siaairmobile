//
//  MessageService.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/2.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "MessageService.h"
#define wsurl @"ws://192.168.163.29/acs/usermsg"

@implementation MessageService
{
    SRWebSocket *srWebSocket;
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

-(void)resetDialogParam: (long)clientId userId: (long)userId toId: (long)toId type: (BOOL)type
{
    _clientId = clientId;
    _userId = userId;
    _toId = toId;
    _group = type;
    [srWebSocket send:[NSString stringWithFormat:@"register:%li",_clientId]];
}

-(void)refreshMessage
{
    
}

-(void) regiestWebSocket
{
    srWebSocket.delegate = nil;
    [srWebSocket close];
    srWebSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wsurl]]];
    srWebSocket.delegate = self;
    NSLog(@"Opening Connection...");
    [srWebSocket open];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSLog(@"Received \"%@\"", message);
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"Websocket Connected");
    [webSocket send:[NSString stringWithFormat:@"register:%li",_userId]];
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"id":@"2",@"clientid":@"yangql_2016",@"to":@""} options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [webSocket send:jsonString];
    
    [self sendMessage];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    webSocket = nil;
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    NSLog(@"WebSocket closed");
    
    webSocket = nil;
}

// Return YES to convert messages sent as Text to an NSString. Return NO to skip NSData -> NSString conversion for Text messages. Defaults to YES.
- (BOOL)webSocketShouldConvertTextFrameToString:(SRWebSocket *)webSocket
{
    return YES;
}

- (void)sendMessage{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"id":@"2",@"clientid":@"yangql_2016",@"to":@"wangdeyan2016",@"msg":@{@"type":@"0",@"content":@"发送的测试消息"}} options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [srWebSocket send:jsonString];
}

@end
