//
//  DutyModel.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "DutyModel.h"

@implementation DutyModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
        if ([self.section isEqualToString:@"值班领导"]) {
            self.sort = 1;
        }else if ([self.section isEqualToString:@"运行总监"]){
            self.sort = 2;
        }else if ([self.section isEqualToString:@"运行指挥中心"]){
            self.sort = 3;
        }else if ([self.section isEqualToString:@"飞行区管理部"]){
            self.sort = 4;
        }else if ([self.section isEqualToString:@"航站区管理部"]){
            self.sort = 5;
        }else if ([self.section isEqualToString:@"公共区管理部"]){
            self.sort = 6;
        }else if ([self.section isEqualToString:@"公安分局"]){
            self.sort = 7;
        }else if ([self.section isEqualToString:@"卓怿公司"]){
            self.sort = 8;
        }else if ([self.section isEqualToString:@"安全检查站"]){
            self.sort = 9;
        }else if ([self.section isEqualToString:@"航空护卫站"]){
            self.sort = 10;
        }else if ([self.section isEqualToString:@"地面服务公司"]){
            self.sort = 11;
        }else if ([self.section isEqualToString:@"机电设备保障部"]){
            self.sort = 12;
        }else if ([self.section isEqualToString:@"信息公司"]){
            self.sort = 13;
        }else if ([self.section isEqualToString:@"消防急救中心"]){
            self.sort = 14;
        }else if ([self.section isEqualToString:@"动力分公司"]){
            self.sort = 15;
        }else if ([self.section isEqualToString:@"航空货站"]){
            self.sort = 16;
        }else if ([self.section isEqualToString:@"快件中心"]){
            self.sort = 17;
        }else if ([self.section isEqualToString:@"运输公司"]){
            self.sort = 18;
        }else if ([self.section isEqualToString:@"维修公司"]){
            self.sort = 19;
        }else if ([self.section isEqualToString:@"国际货站"]){
            self.sort = 20;
        }
        else{
            self.sort = NSIntegerMax;
        }
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    return;
}


@end
