//
//  WillOneHourFltModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface WillOneHourFltModel : RootModel

//机位占用预测
@property (nonatomic, assign) int willOnehourInFlt;//未来1小时进港航班数
@property (nonatomic, assign) int willOnehourOutFlt;//未来1小时出港航班数
@property (nonatomic, assign) int nextHourTakeUp;//willOnehourInFlt-willOnehourOutFlt

@end
