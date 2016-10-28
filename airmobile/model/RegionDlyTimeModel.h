//
//  RegionDlyTimeModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegionDlyTimeModel : NSObject

@property (nonatomic,copy) NSString *region;
@property (nonatomic,assign) int count;
@property (nonatomic,assign) int time;

-(instancetype)initWithRegion:(NSString *)region count:(int)count time:(CGFloat)time;

@end
