//
//  Airport.m
//  KaiYa
//
//  Created by 杨泉林研发部 on 16/2/22.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "Airport.h"

@implementation Airport

- (Airport *)initCn:(NSString *)cn iata:(NSString *)iata region:(NSString *)region first:(NSString *)first
{
    if (self==[super init]) {
        self.cn = cn;
        self.iata = iata;
        self.region = region;
        self.first = first;
    }
    return self;
}

+ (Airport *)createCn:(NSString *)cn iata:(NSString *)iata region:(NSString *)region first:(NSString *)first
{
    return [[Airport alloc] initCn:cn iata:iata region:region first:first];
}

@end
