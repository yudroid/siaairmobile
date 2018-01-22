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
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"deptSortFlag"] &&[value isKindOfClass:[NSNumber class]]) {

            self.sort = ((NSNumber *)value).integerValue;

    }else{
        self.sort = NSIntegerMax;
    }
    return;
}


@end
