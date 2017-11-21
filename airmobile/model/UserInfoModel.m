//
//  UserInfoModel.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/4.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel


-(void)setNilValueForKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _id = 0;
    }else if([key isEqualToString:@"deptId"]){
        _deptId = 0;
    }
}



@end
