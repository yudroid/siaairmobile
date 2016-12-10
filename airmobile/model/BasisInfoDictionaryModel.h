//
//  BasisInfoDictionaryModel.h
//  airmobile
//
//  Created by xuesong on 16/12/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface BasisInfoDictionaryModel : RootModel


@property (nonatomic, assign) int id;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *content;

@end
