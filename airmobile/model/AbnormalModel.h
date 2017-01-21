//
//  AbnormalModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface AbnormalModel : RootModel


@property (nonatomic ,assign)   NSInteger   id;
@property (nonatomic ,copy)     NSString    *model;         //异常类型
@property (nonatomic ,copy)     NSString    *event;         //异常事件
@property (nonatomic ,copy)     NSString    *level;         //事件级别
@property (nonatomic ,copy)     NSString    *ask;           // 要求
@property (nonatomic ,assign)   NSInteger   userID;         //上报人员ID
@property (nonatomic ,assign)   NSInteger   flightID;       //异常发生所在航班ID
@property (nonatomic ,assign)   NSInteger   safeguardID;    //异常发生所在环节ID
@property (nonatomic ,assign)   Boolean     isKey;          //是否为特殊航班
@property (nonatomic ,copy)     NSString    *startTime;     //上报开始时间
@property (nonatomic ,copy)     NSString    *endTime;       //上报结束时间
@property (nonatomic ,copy)     NSString    *imagePath;     //图片路径
@end
