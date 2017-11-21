////
////  PushMessageService.m
////  airmobile
////
////  Created by xuesong on 2017/11/21.
////  Copyright © 2017年 杨泉林. All rights reserved.
////
//
//#import "PushMessageService.h"
//#import "PersistenceUtils+Business.h"
//#import "AppDelegate.h"
//
//@implementation PushMessageService
//
//
//+ (void)didReceiveMessage:(id)message
//{
//    // usermessage --- "{"content":"Yang","createTime":"2016-11-10 15:17:06","fromId":65,"handleStatus":0,"id":65,"toId":66}"
//    // groupmessage --- "{"content":"Yang also","createTime":"2016-04-10 15:40:20","sendUserId":65,"sendUserName":"杨泉林","workgroupId":619,"workgroupTitle":"成员: admin 张宇","workgroupUserIds":"1,66"}"
//    // sysmessage --- "toDept toDeptIds"
//
//    NSLog(@"Received \"%@\"", message);
//
//    //获取用户ID
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//
//    long userId = appDelegate.userInfoModel.id;
//
//    NSString *urlString = [webSocket.url absoluteString];
//    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                        options:NSJSONReadingMutableContainers
//                                                          error:&err];
//    if(dic == nil){
//        return;
//    }
//
//
//    if([urlString isEqualToString:wsuserurl1]
//       //       ||[urlString isEqualToString:wsuserurl2]
//       ){
//        if(![[dic allKeys] containsObject:@"createTime"]){
//            return;
//        }
//        long toId   = [[dic objectForKey:@"toId"] longLongValue];
//        long fromId = [[dic objectForKey:@"fromId"] longLongValue];
//        if(toId != userId || fromId == userId){
//            return;
//        }
//        NSMutableDictionary *msgDict = [NSMutableDictionary dictionary];
//        [msgDict setValue:[NSNumber numberWithLong:fromId]  forKey:@"chatid"];// 源头
//        [msgDict setValue:[dic objectForKey:@"content"]     forKey:@"content"];
//        [msgDict setValue:[NSNumber numberWithLong:fromId]  forKey:@"userid"];
//        [msgDict setValue:[NSNumber numberWithLong:0]       forKey:@"type"];
//        [msgDict setValue:[dic objectForKey:@"createTime"]       forKey:@"createTime"];
//        [msgDict setValue:[dic objectForKey:@"flag"] forKey:@"flag"];
//
//
//        [PersistenceUtils insertNewChatMessage:msgDict
//                                        needid:YES
//                                       success:^{
//                                           if(_chatDelegate != nil){
//                                               [_chatDelegate refreshDialogData];
//                                           }
//
//                                           if(_chatListDelegate != nil){
//                                               [_chatListDelegate refreshChatInfoList];
//                                           }
//                                       }];
//    }else if([urlString isEqualToString:wsgroupurl1]
//             //             ||[urlString isEqualToString:wsgroupurl2]
//             ){
//        if(![[dic allKeys] containsObject:@"createTime"]){
//            return;
//        }
//
//        NSDictionary *msgDict = [self dicToMsDic:dic];
//
//        [PersistenceUtils insertNewChatMessage:msgDict needid:YES success:^{
//            if(_chatDelegate != nil){
//                [_chatDelegate refreshDialogData];
//            }
//            if(_chatListDelegate != nil){
//                [_chatListDelegate refreshChatInfoList];
//            }
//        }];
//    }else if([urlString isEqualToString:wssysurl1]
//             //             ||[urlString isEqualToString:wssysurl2]
//             ){
//
//        if(![[dic allKeys] containsObject:@"createTime"] || ![[dic allKeys] containsObject:@"type"]){
//            return;
//        }
//        if (![[dic objectForKey:@"type"] containsString:@"FLIGHT"]) {
//
//            NSMutableDictionary *msgDict = [self toMessageDic:dic];
//            [PersistenceUtils insertNewSysMessage:msgDict];
//            NSString *type = [dic objectForKey:@"type"];
//            if(_curTabBarView != nil && type!=nil && ![type containsString:@"FLIGHT"]){
//                [_curTabBarView setHasNewMessage:YES];
//            }
//        }else{
//            if([[dic objectForKey:@"type"] containsString:@"FTSS"]){
//                NSString *msgContent  = [dic objectForKey:@"content"];
//                for (NSDictionary *dic in [ConcernModel allConcernModel]) {
//                    if ([msgContent containsString:dic[@"key"]]) {
//
//                        //声音提示
//                        [self voice];
//
//                        //消息存储
//                        NSMutableDictionary *msgDict = [self toMessageDic:dic];
//                        [PersistenceUtils insertNewSysMessage:msgDict];
//                        NSString *type = [dic objectForKey:@"type"];
//                        if(_curTabBarView != nil && type!=nil && ![type containsString:@"FLIGHT"]){
//                            [_curTabBarView setHasNewMessage:YES];
//                        }
//
//                        //发送本地通知
//                        [UILocalNotification sendFlightChangeNotificationWithContent:msgContent];
//                        UIApplicationState state = [UIApplication sharedApplication].applicationState;
//                        if(state == UIApplicationStateBackground){
//
//                        }
//                    }
//                }
//            }else{
//                NSMutableDictionary *msgDict = [self toMessageDic:dic];
//                [PersistenceUtils insertNewSysMessage:msgDict];
//                NSString *type = [dic objectForKey:@"type"];
//                if(_curTabBarView != nil && type!=nil && ![type containsString:@"FLIGHT"]){
//                    [_curTabBarView setHasNewMessage:YES];
//                }
//            }
//        }
//
//
//
//
//        //处理航班关注
//        if([[dic objectForKey:@"type"] containsString:@"FTSS"]){
//            NSString *content = [dic objectForKey:@"content"] ;
//            if (![content isEqualToString:@"前方起飞"]) {
//                if ([content containsString:@"起飞"]||[content containsString:@"取消"]) {
//                    for (NSDictionary *dic in [ConcernModel allConcernModel]) {
//                        if ([content containsString:dic[@"key"]]) {
//                            [ConcernModel removeConcernModel:dic[@"key"]];
//                        }
//                    }
//                }else{
//                    if ([content containsString:@"到达"]) {
//                        for (NSDictionary *dic in [ConcernModel allConcernModel]) {
//                            if ([content containsString:dic[@"key"]]&&((NSNumber*)dic[@"value"]).integerValue == 1)             {
//                                [ConcernModel removeConcernModel:dic[@"key"]];
//                            }
//
//                        }
//                    }
//                }
//            }
//        }
//
//    }
//    else if([urlString isEqualToString:wsabnurl1]
//            //            ||[urlString isEqualToString:wsabnurl2]
//            ){
//
//        long msgId = [[dic objectForKey:@"id"] longLongValue];
//        //        long todept = [[dic objectForKey:@"toDept"] isEqual:[NSNull null]]?0:[[dic objectForKey:@"toDept"] longLongValue];
//        NSMutableDictionary *msgDict = [NSMutableDictionary dictionary];
//        [msgDict setValue:[NSNumber numberWithLong:msgId]        forKey:@"id"];// 主键
//        [msgDict setValue:@"abnevent"        forKey:@"type"];
//        NSString *content = [NSString stringWithFormat:@"%@ %@ %@",[dic objectForKey:@"oneName"]?:@"",[dic objectForKey:@"twoName"]?:@"",[dic objectForKey:@"eventDesc"]?:@""];
//        [msgDict setValue:content   forKey:@"content"];
//        [msgDict setValue:[dic objectForKey:@"oneName"]?:@""    forKey:@"title"];
//        [msgDict setValue:[dic objectForKey:@"submitDate"]    forKey:@"createTime"];
//        [msgDict setValue:@""    forKey:@"status"];
//        [msgDict setValue:@""        forKey:@"toDeptIds"];
//        [msgDict setValue:@""      forKey:@"toDept"];
//
//
//        [PersistenceUtils insertNewSysMessage:msgDict];
//        NSString *type = [msgDict objectForKey:@"type"];
//        if(_curTabBarView != nil && type!=nil && ![type containsString:@"FLIGHT"]){
//            [_curTabBarView setHasNewMessage:YES];
//        }
//
//    }
//
//}
//
//
//
//
//@end

