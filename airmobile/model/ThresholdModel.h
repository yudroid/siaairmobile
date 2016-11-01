//
//  ThresholdModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface ThresholdModel : RootModel

@property (nonatomic, assign) long  id;//id
@property (nonatomic, copy) NSString *name ;//阈值名称
@property (nonatomic, copy) NSString *descriptionInfo;//阈值描述
@property (nonatomic, assign) float max;//最大值
@property (nonatomic, assign) float min;//最小值
@property (nonatomic, assign) int version;//版本号

@end
