//
//  KeySafegurdModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface KeySafegurdModel : RootModel

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *safeName;//环节名称
@property (nonatomic, assign) int tag;//tag:0 未检查 1:正常 2：异常
@property (nonatomic, copy) NSString *normalTime;//上报正常的时间

@end
