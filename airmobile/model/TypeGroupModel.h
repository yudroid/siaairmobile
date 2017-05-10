//
//  TypeGroupModel.h
//  airmobile
//
//  Created by xuesong on 17/4/11.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootModel.h"

@interface TypeGroupModel :RootModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *subType;

@end
