//
//  Constants.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/12/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "Constants.h"

const long OV = 10000000;//首页
const long OV_WHOLE = 10100000;//总体
const long OV_WHOLE_ALLHOUR = 10101000;//计划总数
const long OV_WHOLE_RELEASED = 10102000;//放行率
const long OV_WHOLE_STATUS = 10103000;//预警级别
const long OV_FLIGHT = 10200000;//航班
const long OV_FLIGHT_DEPHOUR = 10201000;//出港航班
const long OV_FLIGHT_DEPABN = 10202000;//出港异常
const long OV_FLIGHT_ARRHOUR = 10203000;//进港航班
const long OV_FLIGHT_ARRABN = 10204000;//进港异常
const long OV_PASSENGER = 10300000;//旅客
const long OV_PASSENGER_HOUR = 10301000;//小时分布
const long OV_PASSENGER_SAFTY = 10302000;//隔离区
const long OV_PASSENGER_TOPFIVE = 10303000;//高峰旅客
const long OV_CRAFTSEAT = 10400000;//机位
const long OV_CRAFTSEAT_MAIN = 10401000;//主机位
const long OV_CRAFTSEAT_BRANCH = 10402000;//子机位

const long FL = 20000000;//详情
const long FL_DETAIL = 20100000;//航班详情
const long FL_SPETIAL = 20101000;//特殊环节
const long FL_SPETIAL_REPORTNOR = 20101010;//上报正常
const long FL_SPETIAL_REPROTABN = 20101020;//上报异常
const long FL_NORMAL = 20102000;//普通环节
const long FL_NORMAL_REPORTNOR = 20102010;//上报正常
const long FL_NORMAL_REPORTABN = 20102020;//上报异常
const long FL_ALLDISPATCH = 20103000;//监察权限

const long MSG = 30000000;//消息
const long MSG_WORNING = 30100000;//指令消息
const long MSG_WORNING_REPLY = 30101000;//回复
const long MSG_WORNING_CONFIRM = 30102000;//确认
const long MSG_FLIGHT = 30200000;//航班事件消息
const long MSG_DIALOG = 30300000;//会话消息

const long FUNC = 40000000;//值班
const long FUNC_ADDRESS = 40100000;//通讯录
const long FUNC_DUTYTABLE = 40200000;//值班表
const long FUNC_TODAYDUTY = 40300000;//当日值班表
const long FUNC_TARGET = 40400000;//生产指标
const long FUNC_YYQK = 40500000;//运营情况
const long FUNC_TQXX = 40600000;//天气信息
const long FUNC_ZBHX = 40700000;//周边航线

const long SET = 50000000;//设置
const long SET_MSGFILTER = 50100000; //消息过滤
const long SET_VERSION   = 50200000; //版本检测
const long SET_SYNCBASE  = 50300000; //更新基础数据
const long SET_USERMANAGE= 50400000; //用户管理
const long SET_FUNCTION  = 50500000; //功能说明
const long SET_USERMANAGE_HEADER = 50401000; // 头像
const long SET_USERMANAGE_CLEARMESSAGE = 50402000; // 消息清除
const long SET_USERMANAGE_PASSWORD = 50403000;// 修改密码



@implementation Constants

@end
