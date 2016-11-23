//
//  SeatStatusModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/14.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"
#import "CraftseatCntModel.h"

@interface SeatStatusModel : RootModel

@property (nonatomic,assign) int seatNum;// 机位总数
@property (nonatomic,assign) int seatUsed;// 机位使用数
@property (nonatomic,assign) int seatFree;// 机位空闲数
@property (nonatomic,assign) int nextIn;// 下小时进港
@property (nonatomic,assign) int nextOut;// 下小时出港

@property (nonatomic,copy) CraftseatCntModel *usedDetail;// 机位使用的详细信息

@end
