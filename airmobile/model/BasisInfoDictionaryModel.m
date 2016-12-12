//
//  BasisInfoDictionaryModel.m
//  airmobile
//
//  Created by xuesong on 16/12/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "BasisInfoDictionaryModel.h"

@implementation BasisInfoDictionaryModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"basisidid"]) {
        _id = [value intValue];
    }
}

@end
