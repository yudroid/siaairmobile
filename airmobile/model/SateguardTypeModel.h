//
//  SateguardTypeModel.h
//  airmobile
//
//  Created by xuesong on 17/4/11.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootModel.h"

@interface SateguardTypeModel : RootModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *flagSuervise;
@property (nonatomic, copy) NSString *falgSpecial;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;


@end
