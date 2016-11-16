//
//  SeatStatusModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/14.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"
#import "SeatUsedModel.h"

@interface SeatStatusModel : RootModel

@property (nonatomic,assign) int seatNum;
@property (nonatomic,assign) int seatUsed;
@property (nonatomic,assign) int seatFree;
@property (nonatomic,assign) int nextIn;
@property (nonatomic,assign) int nextOut;

@property (nonatomic,copy) SeatUsedModel *usedDetail;// 机位使用的详细信息

@end
