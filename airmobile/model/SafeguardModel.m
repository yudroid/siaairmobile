//
//  SafeguardModel.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "SafeguardModel.h"

@implementation SafeguardModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"safeName"]) {
        _name = value;
    }
    return;
}

@end
