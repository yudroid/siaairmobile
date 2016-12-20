//
//  BasisInfoEventModel.h
//  airmobile
//
//  Created by xuesong on 16/12/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface BasisInfoEventModel : RootModel



@property (nonatomic ,assign) int basisid;
@property (nonatomic ,assign) int event_type;
@property (nonatomic ,assign) int dispatch_type;
@property (nonatomic ,assign) int event_level;
@property (nonatomic ,strong) NSString *event;
@property (nonatomic ,strong) NSString *content;


@end
