//
//  PassengerAreaModel.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/28.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PassengerAreaModel.h"

@implementation PassengerAreaModel

-(instancetype)initWithRegion:(NSString *)region count:(int)count isFar:(BOOL)isFar
{
    self = [super init];
    if(self){
        _region = region;
        _count = count;
        _isFar = isFar;
    }
    return self;
}
@end
