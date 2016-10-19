//
//  FlightProcessModel.h
//  airmobile
//
//  Created by xuesong on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightProcessModel : NSObject

@property(nonatomic,assign)  int index;
@property(nonatomic,copy)  NSString * flag;
@property(nonatomic,copy)  NSString * fltDate;
@property(nonatomic,copy)  NSString * fltNo;
@property(nonatomic,copy)  NSString * route;
@property(nonatomic,copy)  NSString * airline;
@property(nonatomic,copy)  NSString * airlineIata;
@property(nonatomic,copy)  NSString * craftModel;
@property(nonatomic,copy)  NSString * craftNo;
@property(nonatomic,copy)  NSString * stand;
@property(nonatomic,copy)  NSString * task;
@property(nonatomic,copy)  NSString * gate;
@property(nonatomic,strong)  NSDate * prePlanTakeoff;
@property(nonatomic,strong)  NSDate * preAlterTakeoff;
@property(nonatomic,strong)  NSDate * preRealTakeoff;
@property(nonatomic,strong)  NSDate * planArr;
@property(nonatomic,strong)  NSDate * alterArr;
@property(nonatomic,strong)  NSDate * realArr;
@property(nonatomic,strong)  NSDate * planTakeoff;
@property(nonatomic,strong)  NSDate * alterTakeoff;
@property(nonatomic,strong)  NSDate * realTakeoff;
@property(nonatomic,strong)  NSDate * nextPlanArr;
@property(nonatomic,strong)  NSDate * nextAlterArr;
@property(nonatomic,strong)  NSDate * nextRealArr;
@property(nonatomic,copy)  NSString * arrStatus;
@property(nonatomic,copy)  NSString * depStatus;
@property(nonatomic,copy)  NSString * arrAbn;
@property(nonatomic,copy)  NSString * depAbn;
@property(nonatomic,strong)  NSDate * cabinOpenTime;
@property(nonatomic,strong)  NSDate * cabinCloseTime;
//放轮挡时间
@property(nonatomic,strong)  NSDate * blockOnTime;
//撤轮挡时间
@property(nonatomic,strong)  NSDate * blockOffTime;
@property(nonatomic,copy)  NSString * region;

@property(nonatomic,copy)  NSString * ckic;
@property(nonatomic,strong)  NSDate * planBoardTime;
@property(nonatomic,strong)  NSDate * allowBoardTime;
@property(nonatomic,strong)  NSDate * realBoardTime;
//已登机旅客数
@property(nonatomic,assign)  int boardedCnt;
@property(nonatomic,assign)  int estimateWateTime;
@property(nonatomic,assign)  int wateTime;
@property(nonatomic,copy)  NSString * gosStatus;
@property(nonatomic,copy)  NSString * acrsl;

//CDM时间
@property(nonatomic,strong)  NSDate * eldt;
@property(nonatomic,strong)  NSDate * tldt;
@property(nonatomic,strong)  NSDate * ctot;
@property(nonatomic,strong)  NSDate * cobt;
@property(nonatomic,strong)  NSDate * tobt;
@property(nonatomic,strong)  NSDate * dobt;
@property(nonatomic,strong)  NSDate * aldt;
@property(nonatomic,strong)  NSDate * atot;
@property(nonatomic,strong)  NSDate * aibt;
@property(nonatomic,strong)  NSDate * aobt;
@property(nonatomic,strong)  NSDate * asbt;
@property(nonatomic,strong)  NSDate * ardt;
@property(nonatomic,strong)  NSDate * acct;
@property(nonatomic,strong)  NSDate * agct;
@property(nonatomic,strong)  NSDate * agot;
@property(nonatomic,strong)  NSDate * asrt;
@property(nonatomic,strong)  NSDate * asat;
@property(nonatomic,strong)  NSDate * axit;
@property(nonatomic,strong)  NSDate * axot;

@end
