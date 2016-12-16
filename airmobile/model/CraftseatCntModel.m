//
//  CraftseatCntModel.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "CraftseatCntModel.h"

@implementation CraftseatCntModel

-(void) updateCraftSeatTakeUpInfo:(id)data
{
    if([self isNull:data])
        return;
    _allCount       = [[data objectForKey:@"allCount"]      intValue];
    _currentTakeUp  = [[data objectForKey:@"currentTakeUp"] intValue];
    _unusable       = [[data objectForKey:@"unusable"]      intValue];
    _longTakeUp     = [[data objectForKey:@"longTakeUp"]    intValue];
    _todayFltTakeUp = [[data objectForKey:@"todayFltTakeUp"]intValue];
    _idle           = [[data objectForKey:@"idle"]          intValue];
    _passNight      = [[data objectForKey:@"passNight"]     intValue];
    _takeUpRatio    = [[data objectForKey:@"takeUpRatio"]   floatValue];
}

-(void) updateCraftSeatTypeTakeUp:(id)data
{
    if(![data isKindOfClass:[NSArray class]])
        return;
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        SeatUsedModel *model = [[SeatUsedModel alloc]initWithDictionary:dic];
        [mutableArray addObject:model];
    }
    _seatUsed = [mutableArray copy];

}

@end
