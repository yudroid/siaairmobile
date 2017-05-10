//
//  ReleasedRatioModel.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ReleasedRatioModel.h"

@implementation ReleasedRatioModel

-(instancetype) initWithTime:(NSString *)time ratio:(CGFloat)ratio
{
    self = [super init];
    if(self){
        _time = time;
        _ratio = ratio;
    }
    return self;
}


-(void)setHour:(NSString *)hour
{
    _hour = hour;
    _time = hour;
}

@end
