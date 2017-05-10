//
//  SateguardTypeModel.m
//  airmobile
//
//  Created by xuesong on 17/4/11.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "SateguardTypeModel.h"

@implementation SateguardTypeModel

-(void)setType:(NSString *)type
{
    if (type == nil||[type isKindOfClass:[NSNull class]]) {
        _type = @"";
    }else{
        _type = type;

    }

}

@end
