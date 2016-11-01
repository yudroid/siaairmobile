//
//  CraftseatCntModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface CraftseatCntModel : RootModel

//进港
@property (nonatomic, assign) int allCount;//机位总数
@property (nonatomic, assign) int unusable;//不可用机位数
@property (nonatomic, assign) int longTakeUp;//长期占用数
@property (nonatomic, assign) int todayFltTakeUp;//今日停场（即今日计划航班占用机位数）
@property (nonatomic, assign) int idle;//空闲机位数
@property (nonatomic, assign) int passNight;//过夜航班数
//当前占用
@property (nonatomic, assign) int currentTakeUp;//当前占用数=longTakeUp+todayFltTakeUp
@property (nonatomic, assign) float takeUpRatio;//当前占用数/机位总数

@end
