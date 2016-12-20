//
//  specialModel.h
//  airmobile
//
//  Created by xuesong on 16/12/8.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootModel.h"

@interface SpecialModel :RootModel


@property (nonatomic, assign) int id;
@property (nonatomic, assign) int fid;
@property (nonatomic, copy)   NSString *safeName;
@property (nonatomic, assign) Boolean isAD;
@property (nonatomic, assign) int tag;
@property (nonatomic, assign) NSString *normalTime;
@property (nonatomic, strong) NSString *safeguardDepart;


@end
