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
        }else{
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
