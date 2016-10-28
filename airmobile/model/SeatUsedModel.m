//
//  SeatUsedModel.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/28.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "SeatUsedModel.h"

@implementation SeatUsedModel

-(instancetype) initWithType:(NSString *)type free:(int)free used:(int)used
{
    self = [super init];
    if(self){
        _type = type;
        _free = free;
        _used = used;
    }
    return self;
}

- (CGFloat)getPercent
{
    if(_free+_used==0)
        return 0;
    return 1.0f*_used/(_free+_used);
}
@end
