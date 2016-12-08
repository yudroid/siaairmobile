//
//  DeptInfoModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/8.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface DeptInfoModel : RootModel

@property (nonatomic,assign)    long        deptId;
@property (nonatomic,copy)      NSString    *deptName;

@property (nonatomic,strong)    NSMutableArray<UserInfoModel *> *userArr;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSMutableArray *) userArray;
@end
