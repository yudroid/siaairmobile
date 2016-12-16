//
//  SeatUsedModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/28.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootModel.h"

@interface SeatUsedModel : RootModel

/*
类别=sizetype;
正常机位个数=normalCnt;
主机位个数=parentCnt;
子机位个数=childCnt;
正常机位占用个数=normalTakeUpCnt;
父机位占用个数=parentTakeUpCnt;
子机位占用个数=childTakeUpCnt;
 */

@property (nonatomic, strong) NSString *sizetype; 
@property (nonatomic, assign) NSInteger normalCnt;
@property (nonatomic, assign) NSInteger parentCnt;
@property (nonatomic, assign) NSInteger childCnt;
@property (nonatomic, assign) NSInteger normalTakeUpCnt;
@property (nonatomic, assign) NSInteger parentTakeUpCnt;
@property (nonatomic, assign) NSInteger childTakeUpCnt;

@end
