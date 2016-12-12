//
//  AbnormalModel.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AbnormalModel.h"

@implementation AbnormalModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"sTime"]){
        _startTime = value;
    }else if ([key isEqualToString:@"eTime"]){
        _endTime = value;
    }
}



@end
