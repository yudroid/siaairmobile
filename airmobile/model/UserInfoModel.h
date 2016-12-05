//
//  UserInfoModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/4.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property(nonatomic,copy)   NSString    *aptitude;
@property(nonatomic,copy)   NSString    *className;
@property(nonatomic,assign) long        deptId;
@property(nonatomic,copy)   NSString    *deptName;
@property(nonatomic,assign) int         flag;
@property(nonatomic,assign) long        id;
@property(nonatomic,copy)   NSString    *jobNumber;
@property(nonatomic,copy)   NSString    *name;
@property(nonatomic,copy)   NSString    *password;
@property(nonatomic,copy)   NSString    *phone;
@property(nonatomic,copy)   NSString    *post;
@property(nonatomic,copy)   NSString    *rule;
@property(nonatomic,copy)   NSString    *seat;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary ;
@end
