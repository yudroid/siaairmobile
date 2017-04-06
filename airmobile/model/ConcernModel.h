//
//  ConcernModel.h
//  airmobile
//
//  Created by xuesong on 17/3/1.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConcernModel : NSObject

@property (nonatomic, strong) NSString *flightNo;

-(instancetype)initWithFlightNo:(NSString *)flightNo;

+(NSArray<NSString *>*)allConcernModel;
+(void)addConcernModel:(NSString *)flightNo;
+(void)removeConcernModel:(NSString *)flightNo;

+(BOOL)isconcern:(NSString *)flightNo;//是否包含该航班

+(void)removeAll;//移除所有

@end
