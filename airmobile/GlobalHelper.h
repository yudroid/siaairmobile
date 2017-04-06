//
//  GlobalHelper.h
//  KaiYa
//
//  Created by WangShiran on 16/2/15.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Airport.h"
#import "TypeModel.h"

@interface GlobalHelper : NSObject{
    BOOL _todayFlag;
    NSDate *fltDate;
    Airport *localAirport;// 本站信息
}


+(GlobalHelper*)sharedHelper;

@property (nonatomic,assign)ListType listType;

- (Airport *)getLocalAirport;
- (void)setFlightDate:(NSDate *)date;
- (NSDate *)getFlightDate;

- (NSString *)getFlightDateStr;

- (BOOL)isToday;
- (void) setIsToday:(Boolean) isToday;

@end
