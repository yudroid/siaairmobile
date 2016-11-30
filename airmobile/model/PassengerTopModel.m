//
//  PassengerTopModel.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/28.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PassengerTopModel.h"

@implementation PassengerTopModel

-(instancetype)initWithDate:(NSString *)date
                      count:(int)       count
                      index:(int)       index{
    self = [super init];
    if(self){
        _date   = date;
        _count  = count;
        _index  = index;
    }
    return self;
}
@end
