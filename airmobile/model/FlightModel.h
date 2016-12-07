//
//  FlightModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface FlightModel : RootModel

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *fNum;     //航班号
@property (nonatomic, copy) NSString *fName;    //航班名称
@property (nonatomic, copy) NSString *model;    //机型
@property (nonatomic, copy) NSString *seat;     //机位
@property (nonatomic, copy) NSString *sTime;    //前序航班城市时间
@property (nonatomic, copy) NSString *mInTime;  //本站到达时间
@property (nonatomic, copy) NSString *mOutTime; //本站起飞时间
@property (nonatomic, copy) NSString *eTime;    //后序航班城市时间
@property (nonatomic, copy) NSString *sCity;    //前序航班城市
@property (nonatomic, copy) NSString *mInCity;    //本站
@property (nonatomic, copy) NSString *mOutCity;    //本站
@property (nonatomic, copy) NSString *eCity;    //后序航班城市
@property (nonatomic, copy) NSString *rangeSate;
@property (nonatomic, copy) NSString *region;   //区域属性
@property (nonatomic, copy) NSString *fState;   //航班状态
@property (nonatomic, copy) NSNumber *special;  //是否特殊航班 0:普通 1：特殊


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
