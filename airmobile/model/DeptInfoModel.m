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

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"users"]) {
        if ([value isKindOfClass:[NSArray class]]) {
            NSMutableArray *models = [NSMutableArray array];
            for (NSDictionary *dic in value) {
                UserInfoModel *model = [[UserInfoModel alloc]initWithDictionary:dic];
                [models addObject:model];
            }
            _userArr = models;
        }
    }else if([key isEqualToString:@"departmentName"]){
        _deptName = value;
    }
    return;
}
@end
