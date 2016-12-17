//
//  GlobalHelper.m
//  KaiYa
//
//  Created by WangShiran on 16/2/15.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "GlobalHelper.h"
#import "DateUtils.h"

static GlobalHelper *helper=nil;

@implementation GlobalHelper

+(GlobalHelper*)sharedHelper
{
    if(!helper)
    {
        helper=[[GlobalHelper alloc] init];
        //[helper setIsToday:true];//默认是今天
    }
    return helper;
}

- (void)setFlightDate:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    fltDate = [date  dateByAddingTimeInterval: interval-5*60*60];
    NSString *today = [DateUtils convertToString:[DateUtils getNow] format:@"yyyy-MM-dd"];
    _todayFlag = [today isEqualToString:[self getFlightDateStr]];
}

- (NSDate *)getFlightDate
{
    if (fltDate==nil) {
        NSDate *date = [DateUtils getNow];
        fltDate = [date dateByAddingTimeInterval: -5*60*60];
        _todayFlag = true;
    }
    
    return fltDate;
}

- (NSString *)getFlightDateStr
{
    NSString *str = [DateUtils convertToString:[self getFlightDate] format:@"yyyy-MM-dd"];
    return str;
}

- (BOOL) isToday
{
    return _todayFlag;
}

- (void) setIsToday:(Boolean) isToday
{
    _todayFlag = isToday;
}

- (Airport *)getLocalAirport
{
    if(localAirport==nil || localAirport.iata == nil){
        localAirport = [[Airport alloc] init];
        localAirport.iata= @"TAO";
        localAirport.cn = @"青岛";
        localAirport.region = @"国内";
        localAirport.first = @"Q";
    }
    return localAirport;
}
@end
