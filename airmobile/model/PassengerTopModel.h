//
//  PassengerTopModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/28.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootModel.h"

@interface PassengerTopModel : RootModel

@property (nonatomic,copy)      NSString    *date;
@property (nonatomic,assign)    int         count;
@property (nonatomic,assign)    int         index;

-(instancetype)initWithDate:(NSString *)date
                      count:(int)       count
                      index:(int)       index;

@end
