//
//  SafeguardModel.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "SafeguardModel.h"
#import "DateUtils.h"

@implementation SafeguardModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dictionary];
        for (NSString *key in dic.allKeys) {
            id value = [dic objectForKey:key];
            if ([value isKindOfClass:[NSNull class]]) {
                [dic setObject:@"" forKey:key];
            }
        }


        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"safeName"]) {
        _name = value;
    }
    return;
}

-(NSString *)realStartTime
{
    if (!_realStartTime||[_realStartTime isEqualToString:@"(null)"] ) {
        return @"";
    }
    return _realStartTime;
}

-(NSString *)realEndTime
{
    if (!_realEndTime||[_realEndTime isEqualToString:@"(null)"] ) {
        return @"";
    }
    return _realEndTime;

}

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
    start =[DateUtils convertToString:[DateUtils convertToDate:start format:@"yyyy-MM-dd HH:mm:ss"]  format:@"HH:mm"] ?:@"";
    end =[DateUtils convertToString:[DateUtils convertToDate:end format:@"yyyy-MM-dd HH:mm:ss"]  format:@"HH:mm"]?:@"" ;
    return [NSString stringWithFormat:@"%@-%@",start,end];
}

@end
