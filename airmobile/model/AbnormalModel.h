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
@property (nonatomic ,assign)   NSInteger   event;         //异常事件ID
@property (nonatomic ,copy)     NSString    *memo;         //说明描述
@property (nonatomic ,assign)   NSInteger   userID;         //上报人员ID
@property (nonatomic ,assign)   NSInteger   flightID;       //异常发生所在航班ID
@property (nonatomic ,assign)   NSInteger   safeguardID;    //异常发生所在环节ID
@property (nonatomic ,assign)   NSString    *arriveTime;    //到位时间
@property (nonatomic ,assign)   Boolean     isKey;          //是否为特殊航班
@property (nonatomic ,copy)     NSString    *pathList;     //图片路径
@end
