//
//  SafeguardModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface SafeguardModel : RootModel

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *safeName;
@property (nonatomic, copy) NSString *safePeople;
@property (nonatomic, copy) NSString *sTime;
@property (nonatomic, copy) NSString *eTime;
@property (nonatomic, copy) NSString *state;

@end
