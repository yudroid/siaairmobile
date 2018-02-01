//
//  Constants.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/12/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const long OV;
extern const long OV_WHOLE;
extern const long OV_WHOLE_ALLHOUR;
extern const long OV_WHOLE_RELEASED;
extern const long OV_WHOLE_STATUS;
extern const long OV_FLIGHT;
extern const long OV_FLIGHT_DEPHOUR;
extern const long OV_FLIGHT_DEPABN;
extern const long OV_FLIGHT_ARRHOUR;
extern const long OV_FLIGHT_ARRABN;
extern const long OV_PASSENGER;
extern const long OV_PASSENGER_HOUR;
extern const long OV_PASSENGER_SAFTY;
extern const long OV_PASSENGER_TOPFIVE;
extern const long OV_CRAFTSEAT;
extern const long OV_CRAFTSEAT_MAIN;
extern const long OV_CRAFTSEAT_BRANCH;

extern const long FL;
extern const long FL_DETAIL;
extern const long FL_SPETIAL;
extern const long FL_SPETIAL_REPORTNOR;
extern const long FL_SPETIAL_REPROTABN;
extern const long FL_NORMAL;
extern const long FL_NORMAL_REPORTNOR;
extern const long FL_NORMAL_REPORTABN;
extern const long FL_OTHER_REPORTABN;
extern const long FL_ALLDISPATCH;

extern const long MSG;
extern const long MSG_WORNING;
extern const long MSG_WORNING_REPLY;
extern const long MSG_WORNING_CONFIRM;
extern const long MSG_FLIGHT;
extern const long MSG_DIALOG;

extern const long FUNC;
extern const long FUNC_ADDRESS;
extern const long FUNC_DUTYTABLE;
extern const long FUNC_TODAYDUTY;
extern const long FUNC_TARGET;
extern const long FUNC_YYQK;
extern const long FUNC_TQXX;
extern const long FUNC_ZBHX;
extern const long FUNC_HBGZ;
extern const long FUNC_ZSK;//知识库
extern const long FUNC_YXJB;//运行简报
extern const long FUNC_JJFXHB;
extern const long FUNC_NDYXQK;

extern const long SET;
extern const long SET_MSGFILTER;
extern const long SET_VERSION;
extern const long SET_SYNCBASE;
extern const long SET_FUNCTION;
extern const long SET_USERMANAGE;  //用户管理
extern const long SET_USERMANAGE_HEADER; // 头像
extern const long SET_USERMANAGE_CLEARMESSAGE; // 头像
extern const long SET_USERMANAGE_PASSWORD;// 修改密码

@interface Constants : NSObject

@end
