//
//  SafeguardModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface SafeguardModel : RootModel

@property (nonatomic, assign)   long        id;             //保障环节ID
@property (nonatomic, assign)   long        fid;            //航班ID
@property (nonatomic, assign)   int         isAD;           //进出港标志
@property (nonatomic, copy)     NSString    *name;          //名称
@property (nonatomic, copy)     NSString    *startTime;     //计划开始时间
@property (nonatomic, copy)     NSString    *endTime;       //结束时间
@property (nonatomic, copy)     NSString    *status;        //状态
@property (nonatomic, copy)     NSString    *dispatchPeople;//保障人员
@property (nonatomic, copy)     NSString    *tip;           //备注
@property (nonatomic, copy)     NSString    *realStartTime; //实际开始时间
@property (nonatomic, copy)     NSString    *realEndTime;   //实际结束时间

-(NSString *)startTimeAndEndTime;


@end
