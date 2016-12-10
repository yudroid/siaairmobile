//
//  SeatStatusModel.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/14.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "SeatStatusModel.h"

@implementation SeatStatusModel

-(void) updateCraftSeatTakeUpInfo:(id)data
{
    if([self isNull:data])
        return;
    NSLog(@"%@",data);
    _seatNum  = [[data objectForKey:@"allCount"]  intValue];// 机位总数
    _seatUsed = [[data objectForKey:@"currentTakeUp"] intValue];// 机位使用数
    _seatFree = [[data objectForKey:@"idle"] intValue];// 机位空闲数
    _nextIn = [[data objectForKey:@"willOnehourInFlt"] intValue];// 机位使用数
    _nextOut = [[data objectForKey:@"willOnehourOutFlt"] intValue];// 机位空闲数
    if(_usedDetail == nil)
        _usedDetail = [CraftseatCntModel new];
    [_usedDetail updateCraftSeatTakeUpInfo:data];
}

-(void) updateWillCraftSeatTakeUp:(id)data
{
    if([self isNull:data])
        return;
    _nextIn  = [[data objectForKey:@"nextIn"]  intValue];// 下小时进港
    _nextOut = [[data objectForKey:@"nextOut"] intValue];// 下小时出港
}

-(void) updateCraftSeatTypeTakeUp:(id)data
{
    if(_usedDetail == nil)
        _usedDetail = [CraftseatCntModel new];
    [_usedDetail updateCraftSeatTypeTakeUp:data];
}

@end
