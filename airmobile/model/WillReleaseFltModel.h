//
//  WillReleaseFltModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface WillReleaseFltModel : RootModel

@property (nonatomic, assign) long fltId;
@property (nonatomic, copy) NSString *fltNo;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *time;

@end
