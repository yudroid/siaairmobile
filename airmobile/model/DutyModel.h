//
//  DutyModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface DutyModel : RootModel


@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *userName; //姓名
@property (nonatomic, copy) NSString *section;  //部门
@property (nonatomic, copy) NSString *duty;     //职责
@property (nonatomic, copy) NSString *phone;    //电话
@property (nonatomic, copy) NSString *date;     //值班日期




@end
