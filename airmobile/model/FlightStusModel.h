//
//  FlightStusModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface FlightStusModel : RootModel

@property (nonatomic, assign) int executeNormal;
@property (nonatomic, assign) int executeExec;
@property (nonatomic, assign) int unExecuteNormal;
@property (nonatomic, assign) int unExecuteExec;
@property (nonatomic, assign) int cancel;

@end
