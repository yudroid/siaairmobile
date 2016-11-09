//
//  MessageModel.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/4.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

-(instancetype) initWithId:(long)rid content:(NSString *)content fromId:(long)fromId toId:(long)toId type:(int)type status:(int)status
{
    self = [super init];
    if(self){
        _id = rid;
        _fromId = fromId;
        _toId = toId;
        _type = type;
        _handleStatus = status;
        _content = content;
    }
    return self;
}

-(NSDictionary *) toUserMsgNSDictionary
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:[NSNumber numberWithLong:_id] forKey:@"id"];
    [dic setObject:[NSNumber numberWithLong:_fromId] forKey:@"fromId"];
    [dic setObject:[NSNumber numberWithLong:_toId] forKey:@"toId"];
    [dic setObject:[NSNumber numberWithInt:_handleStatus] forKey:@"handleStatus"];
    [dic setObject:[NSNumber numberWithInt:_type] forKey:@"type"];
    if(_content !=nil){
        [dic setObject:_content forKey:@"content"];
    }
    return dic;
}

-(NSDictionary *) toGroupMsgNSDictionary
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:[NSNumber numberWithLong:_id] forKey:@"id"];
    [dic setObject:[NSNumber numberWithLong:_fromId] forKey:@"sendUserId"];
    [dic setObject:[NSNumber numberWithLong:_toId] forKey:@"workgroupId"];
    if(_content !=nil){
        [dic setObject:_content forKey:@"content"];
    }
    return dic;
}
@end
