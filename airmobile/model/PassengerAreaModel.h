//
//  PassengerAreaModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/28.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PassengerAreaModel : NSObject

@property (nonatomic,copy) NSString *region;
@property (nonatomic,assign) int count;
@property (nonatomic,assign) BOOL isFar;

-(instancetype)initWithRegion:(NSString *)region count:(int)count isFar:(BOOL)isFar;

@end
