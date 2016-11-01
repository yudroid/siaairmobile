//
//  PassenCntModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface PassenCntModel : RootModel

@property (nonatomic, assign) int glqOutsidePsnCnt;//隔离区外人数
@property (nonatomic, assign) int glqInPsnCnt;//隔离区内人数
@property (nonatomic, assign) int planeWaitPsnCnt;//机上等待人数

@end
