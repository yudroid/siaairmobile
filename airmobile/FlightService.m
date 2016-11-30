//
//  FlightService.m
//  airmobile
//
//  Created by xuesong on 16/11/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightService.h"
#import "FlightModel.h"
#import "FlightDetailModel.h"
#import "SafeguardModel.h"
#import "AbnormalModel.h"




@implementation FlightService
{
    NSArray<FlightModel *>      *flightArray;
    FlightDetailModel           *flightDetailModel;
    NSArray<SafeguardModel *>   *safeguardArray;
    AbnormalModel               *abnormalModel;
}
singleton_implementation(FlightService);

-(void)startService
{
    flightArray         = [[NSArray alloc]init];
    safeguardArray      = [[NSArray alloc]init];
    flightDetailModel   = [[FlightDetailModel alloc]init];
    abnormalModel       = [[AbnormalModel alloc]init];
    [super startService:^{

    }];
}


-(NSArray<FlightModel *> *)getFlightArray
{
    FlightModel * flightModel = [[FlightModel alloc]init];
    flightModel.fNum    = @"CA1516";
    flightModel.fName   = @"国航";
    flightModel.model   = @"A380";
    flightModel.seat    = @"远";
    flightModel.sTime   = @"1:50";
    flightModel.mTime   = @"3:20";
    flightModel.eTime   = @"5:05";
    flightModel.sCity   = @"广东";
    flightModel.mCity   = @"深圳";
    flightModel.eCity   = @"青岛";
    flightModel.rangeSate = @"";
    flightModel.region  = @"国内";
    flightModel.fState  = @"正常";
    flightModel.special = @"0";

    FlightModel * flightModel1 = [[FlightModel alloc]init];
    flightModel1.fNum       = @"CA121";
    flightModel1.fName      = @"青岛航";
    flightModel1.model      = @"A390";
    flightModel1.seat       = @"近";
    flightModel1.sTime      = @"1:50";
    flightModel1.mTime      = @"3:20";
    flightModel1.eTime      = @"5:05";
    flightModel1.sCity      = @"广东";
    flightModel1.mCity      = @"深圳";
    flightModel1.eCity      = @"青岛";
    flightModel1.rangeSate  = @"";
    flightModel1.region     = @"国外";
    flightModel1.fState     = @"异常";
    flightModel1.special    = @"1";

    FlightModel * flightModel2 = [[FlightModel alloc]init];
    flightModel2.fNum       = @"CA1516";
    flightModel2.fName      = @"国航";
    flightModel2.model      = @"A380";
    flightModel2.seat       = @"远";
    flightModel2.sTime      = @"1:50";
    flightModel2.mTime      = @"3:20";
    flightModel2.eTime      = @"5:05";
    flightModel2.sCity      = @"广东";
    flightModel2.mCity      = @"深圳";
    flightModel2.eCity      = @"青岛";
    flightModel2.rangeSate  = @"";
    flightModel2.region     = @"国内";
    flightModel2.fState     = @"正常";
    flightModel2.special    = @"0";

    FlightModel * flightModel3 = [[FlightModel alloc]init];
    flightModel3.fNum       = @"CA1516";
    flightModel3.fName      = @"国航";
    flightModel3.model      = @"A380";
    flightModel3.seat       = @"远";
    flightModel3.sTime      = @"1:50";
    flightModel3.mTime      = @"3:20";
    flightModel3.eTime      = @"5:05";
    flightModel3.sCity      = @"广东";
    flightModel3.mCity      = @"深圳";
    flightModel3.eCity      = @"青岛";
    flightModel3.rangeSate  = @"";
    flightModel3.region     = @"国内";
    flightModel3.fState     = @"正常";
    flightModel3.special    = @"0";
    FlightModel * flightModel4 = [[FlightModel alloc]init];

    flightModel4.fNum       = @"CA1516";
    flightModel4.fName      = @"国航";
    flightModel4.model      = @"A380";
    flightModel4.seat       = @"远";
    flightModel4.sTime      = @"1:50";
    flightModel4.mTime      = @"3:20";
    flightModel4.eTime      = @"5:05";
    flightModel4.sCity      = @"广东";
    flightModel4.mCity      = @"深圳";
    flightModel4.eCity      = @"";
    flightModel4.rangeSate  = @"";
    flightModel4.region     = @"国内";
    flightModel4.fState     = @"正常";
    flightModel4.special    = @"0";


    flightArray = @[flightModel,flightModel1,flightModel2,flightModel3,flightModel4];

    return flightArray;
}

-(FlightDetailModel *)getFlightDetailModel
{
    flightDetailModel.fNum              = @"CA9999";
    flightDetailModel.fDate             = @"11月24日";
    flightDetailModel.terminal          = @"T2";
    flightDetailModel.gate              = @"50(近)";
    flightDetailModel.baggage           = @"99";
    flightDetailModel.model             = @"A880";
    flightDetailModel.region            = @"国际";
    flightDetailModel.airLine           = @"北京-深圳-青岛";
    flightDetailModel.sTime             = @"10:41";
    flightDetailModel.eTime             = @"10:41";
    flightDetailModel.preorderNum       = @"AC9998";
    flightDetailModel.preorderState     = @"正常";
    return flightDetailModel;
}

-(NSArray<SafeguardModel *>* )getSafeguardArray
{

    SafeguardModel *model = [[SafeguardModel alloc]init];
    model.id                = 111;
    model.fid               = 222;
    model.isAD              = 0;
    model.name              = @"客舱清洁";
    model.startTime         = @"1:15";
    model.endTime           = @"2:15";
    model.status            = @"正常";
    model.dispatchPeople    = @"保障人员，保障人员，保障人员，保障人员，保障人员，保障人员，";
    model.tip               = @"备注";
    model.realStartTime     = @"11:11";
    model.realStartTime     = @"12:12";
    safeguardArray          = @[model];
    SafeguardModel *model1 = [[SafeguardModel alloc]init];
    model1.id                = 111;
    model1.fid               = 222;
    model1.isAD              = 0;
    model1.name              = @"上架";
    model1.startTime         = @"1:15";
    model1.endTime           = @"2:15";
    model1.status            = @"异常";
    model1.dispatchPeople    = @"保障人员";
    model1.tip               = @"备注";
    model1.realStartTime     = @"11:11";
    model1.realStartTime     = @"12:12";
    safeguardArray          = @[model,model1];
    return safeguardArray;
}
-(NSArray<SafeguardModel *>* )getSpecialSafeguardArray
{

    SafeguardModel *model = [[SafeguardModel alloc]init];
    model.id                = 111;
    model.fid               = 222;
    model.isAD              = 0;
    model.name              = @"客舱清洁";
    model.startTime         = @"1:15";
    model.endTime           = @"2:15";
    model.status            = @"正常";
    model.dispatchPeople    = @"保障人员，保障人员，保障人员，保障人员，保障人员，保障人员，";
    model.tip               = @"备注";
    model.realStartTime     = @"11:11";
    model.realStartTime     = @"12:12";
    safeguardArray          = @[model];
    SafeguardModel *model1 = [[SafeguardModel alloc]init];
    model1.id                = 111;
    model1.fid               = 222;
    model1.isAD              = 0;
    model1.name              = @"上架";
    model1.startTime         = @"1:15";
    model1.endTime           = @"2:15";
    model1.status            = @"异常";
    model1.dispatchPeople    = @"保障人员";
    model1.tip               = @"备注";
    model1.realStartTime     = @"11:11";
    model1.realStartTime     = @"12:12";
    safeguardArray          = @[model,model1];
    return safeguardArray;
}

-(AbnormalModel *)getAbnormalModel
{
    abnormalModel.id            = 123;
    abnormalModel.model         = @"异常类型";
    abnormalModel.event         = @"异常事件";
    abnormalModel.ask           = @"要求";
    abnormalModel.userID        = 123;
    abnormalModel.safeguardID   = 456;
    abnormalModel.flightID      = 1234;
    abnormalModel.isKey         = YES;
    abnormalModel.startTime     = @"12:12";
    abnormalModel.endTime       = @"13:13";
    return abnormalModel;
}
@end
