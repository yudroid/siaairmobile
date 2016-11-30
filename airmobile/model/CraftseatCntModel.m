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
    if(_seatUsed==nil)
        _seatUsed = [NSMutableArray array];
    if([self isNull:data])
        return;
    int index = 0;
    for(NSDictionary *item in data){
        SeatUsedModel *model = nil;
        if([_seatUsed count]<index+1){
            model = [SeatUsedModel new];
            [_seatUsed addObject:model];
        }else{
            model = [_seatUsed objectAtIndex:index];
        }
        // hour:类别名称 count:占用数 ratio：剩余数
        model.type =  [item objectForKey:@"hour"];
        model.free = [[item objectForKey:@"ratio"] intValue];
        model.used = [[item objectForKey:@"count"] intValue];
        index ++;
    }
}

@end
