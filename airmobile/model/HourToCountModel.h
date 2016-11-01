//
//  HourToCountModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface HourToCountModel : RootModel

@property (nonatomic, copy) NSString *hour;//小时
@property (nonatomic, assign) int count;//数量
@property (nonatomic, assign) float ratio;//百分比

@end
