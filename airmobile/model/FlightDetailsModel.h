//
//  FlightDetailsModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface FlightDetailsModel : RootModel

@property (nonatomic, assign) int id;//id
@property (nonatomic, copy) NSString * fNum;//航班号
@property (nonatomic, copy) NSString * fDate;//航班日期
@property (nonatomic, copy) NSString * terminal;//候机楼
@property (nonatomic, copy) NSString * gate;//登机口
@property (nonatomic, copy) NSString * baggage;//行李转盘
@property (nonatomic, copy) NSString * model;//机型
@property (nonatomic, assign) int region;//区域属性
@property (nonatomic, copy) NSString * sCity;//前序
@property (nonatomic, copy) NSString * mCity;//本站
@property (nonatomic, copy) NSString * eCity;//后站
@property (nonatomic, copy) NSString * sTime;//进港时间
@property (nonatomic, copy) NSString * eTime;//出港时间

@property (nonatomic, copy) NSString * preorderNum;//前序航班号
@property (nonatomic, copy) NSString * preorderState;//前序航班状态

@end
