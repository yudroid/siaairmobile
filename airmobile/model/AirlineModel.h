//
//  AirlineModel.h
//  airmobile
//
//  Created by xuesong on 17/3/27.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootModel.h"

@interface AirlineModel : RootModel

@property (nonatomic, strong) NSString *nameChn;//航空公司名称
@property (nonatomic, strong) NSString *nametw;//二字码
@property (nonatomic, strong) NSString *first;//第一个汉字的拼音首字母 用于排序

@end
