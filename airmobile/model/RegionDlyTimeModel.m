//
//  RegionDlyTimeModel.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RegionDlyTimeModel.h"

@implementation RegionDlyTimeModel

-(instancetype)initWithRegion:(NSString *)  region
                        count:(int)         count
                         time:(CGFloat)     time
{
    self = [super init];
    if(self){
        _region     = region;
        _count      = count;
        _time       = time;
    }
    return self;
}

@end
