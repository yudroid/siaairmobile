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
    if (_realStartTime && ![_realStartTime isEqualToString:@""]) {
        start = _realStartTime;
    }else{
        start = _startTime;
    }

    NSString *end = @"";
    if (_realEndTime && ![_realEndTime isEqualToString:@""]) {
        end = _realEndTime;
    }else{
        end = _endTime;
    }
    start =[DateUtils convertToString:[DateUtils convertToDate:start format:@"yyyy-MM-dd HH:mm"]  format:@"HH:mm"] ?:@"";
    end =[DateUtils convertToString:[DateUtils convertToDate:end format:@"yyyy-MM-dd HH:mm"]  format:@"HH:mm"]?:@"" ;
    return [NSString stringWithFormat:@"%@-%@",start,end];
}


@end
