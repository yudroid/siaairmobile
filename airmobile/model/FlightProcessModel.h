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
@property(nonatomic,copy)  NSString * fltDate;          //航班日期
@property(nonatomic,copy)  NSString * fltNo;            //航班号
@property(nonatomic,copy)  NSString * route;            //航线 例如：北京-青岛-釜山
@property(nonatomic,copy)  NSString * airline;          //航空公司
@property(nonatomic,copy)  NSString * airlineIata;      //航空公司二字码 例如：MU
@property(nonatomic,copy)  NSString * craftModel;       //机型
@property(nonatomic,copy)  NSString * craftNo;          //机号
@property(nonatomic,copy)  NSString * stand;            //机位
@property(nonatomic,copy)  NSString * task;             //任务类型  例如：正班、补班
@property(nonatomic,copy)  NSString * gate;             //登机口
@property(nonatomic,strong)  NSDate * prePlanTakeoff;   //前站计划起飞时间
@property(nonatomic,strong)  NSDate * preAlterTakeoff;  //前站变更起飞时间
@property(nonatomic,strong)  NSDate * preRealTakeoff;   //前站真实起飞时间
@property(nonatomic,strong)  NSDate * planArr;          //计划到达时间
@property(nonatomic,strong)  NSDate * alterArr;         //变更到达时间
@property(nonatomic,strong)  NSDate * realArr;          //实际到达时间
@property(nonatomic,strong)  NSDate * planTakeoff;      //计划起飞时间
@property(nonatomic,strong)  NSDate * alterTakeoff;     //变更起飞时间
@property(nonatomic,strong)  NSDate * realTakeoff;      //实际起飞时间
@property(nonatomic,strong)  NSDate * nextPlanArr;      //下站计划到达时间
@property(nonatomic,strong)  NSDate * nextAlterArr;     //下站变更到达时间
@property(nonatomic,strong)  NSDate * nextRealArr;      //下站实际到达时间
@property(nonatomic,copy)  NSString * arrStatus;        //进港状态
@property(nonatomic,copy)  NSString * depStatus;        //出港状态
@property(nonatomic,copy)  NSString * arrAbn;           //进港异常状态
@property(nonatomic,copy)  NSString * depAbn;           //出港异常状态
@property(nonatomic,strong)  NSDate * cabinOpenTime;    //
@property(nonatomic,strong)  NSDate * cabinCloseTime;   //
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
