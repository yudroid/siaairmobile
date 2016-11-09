//
//  DeptInfoModel.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/8.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "DeptInfoModel.h"

@implementation DeptInfoModel

-(NSMutableArray *) userArray
{
    if(_userArr == nil){
        _userArr = [NSMutableArray array];
    }
    return _userArr;
}
@end
