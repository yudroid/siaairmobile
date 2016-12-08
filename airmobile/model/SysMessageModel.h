//
//  SysMessageModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/12/8.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface SysMessageModel : RootModel

@property (nonatomic,assign)    long        msgid;
@property (nonatomic,copy)      NSString    *type;
@property (nonatomic,copy)      NSString    *content;
@property (nonatomic,copy)      NSString    *title;
@property (nonatomic,copy)      NSString    *status;
@property (nonatomic,copy)      NSString    *createtime;
@property (nonatomic,copy)      NSString    *todeptids;
@property (nonatomic,assign)    long        todept;
@property (nonatomic,copy)      NSString    *readtime;

@end
