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


@property (nonatomic, assign) int willOnehourInFlt;
@property (nonatomic, assign) int willOnehourOutFlt;
@property (nonatomic, assign) int nextHourTakeUp;
@property (nonatomic, assign) int normalCnt;
@property (nonatomic, assign) int parentCnt;
@property (nonatomic, assign) int childCnt;
@property (nonatomic, assign) int unusableCnt;
@property (nonatomic, assign) int normalTakeUpCnt;
@property (nonatomic, assign) int parentTakeUpCnt;
@property (nonatomic, assign) int childTakeUpCnt;
@property (nonatomic, assign) int passNightCnt;
@property (nonatomic, assign) int longNormalTakeUpCnt;
@property (nonatomic, assign) int longParentTakeUpCnt;
@property (nonatomic, assign) int longChildTakeUpCnt;


@property (nonatomic,assign) int nextIn;// 下小时进港
@property (nonatomic,assign) int nextOut;// 下小时出港

@property (nonatomic,strong) CraftseatCntModel *usedDetail;// 机位使用的详细信息

-(void) updateCraftSeatTakeUpInfo:(id)data;

-(void) updateWillCraftSeatTakeUp:(id)data;

-(void) updateCraftSeatTypeTakeUp:(id)data;

@end
