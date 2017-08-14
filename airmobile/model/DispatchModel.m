//
//  DispatchModel.m
//  airmobile
//
//  Created by xuesong on 17/4/12.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "DispatchModel.h"
#import "DateUtils.h"

@implementation DispatchModel


-(NSString *)startTimeAndEndTime
{
    NSString *start = @"";
    NSString *end = @"";
    if (_realStartTime && ![_realStartTime isEqualToString:@""]) {
        start = _realStartTime;
        end = _realEndTime;

    }else{
        start = _startTime;
        end = _endTime;
    }

    start =[DateUtils convertToString:[DateUtils convertToDate:start format:@"yyyy-MM-dd HH:mm"]  format:@"HH:mm"] ?:@"";
    end =[DateUtils convertToString:[DateUtils convertToDate:end format:@"yyyy-MM-dd HH:mm"]  format:@"HH:mm"]?:@"" ;
    return [NSString stringWithFormat:@"%@-%@",start,end];
}
-(NSDictionary *)startTimeAndEndTimeAndType
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (_realStartTime && ![_realStartTime isEqualToString:@""]) {
        [dic setObject:@"realTime" forKey:@"type"];
    }else{
        [dic setObject:@"planTime" forKey:@"type"];
    }

    [dic setObject:[self startTimeAndEndTime] forKey:@"time"];
    return [dic copy];
}

@end
