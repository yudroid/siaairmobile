//
//  FlightDetailModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/23.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface FlightDetailModel : RootModel

@property(nonatomic,assign)  int id;//id
@property(nonatomic,copy)  NSString *fNum;          //航班号
@property(nonatomic,copy)  NSString *fDate;         //航班日期
@property(nonatomic,copy)  NSString *terminal;      //候机楼
@property(nonatomic,copy)  NSString *gate;          //登机口
@property(nonatomic,copy)  NSString *baggage;       //行李转盘
@property(nonatomic,copy)  NSString *model;         //机型
@property(nonatomic,copy)  NSString *region;        //区域属性
@property(nonatomic,copy)  NSString *airLine;       //航线(北京-深圳-青岛)
@property(nonatomic,copy)  NSString *sTime;         //进港时间
@property(nonatomic,copy)  NSString *eTime;         //出港时间
@property(nonatomic,copy)  NSString *preorderNum;   //前序航班号
@property(nonatomic,copy)  NSString *preorderState; //前序航班状态

@end
