//
//  SimpleFlight.h
//  KaiYa
//
//  Created by 杨泉林研发部 on 16/3/8.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleFlight : NSObject

/**
 *  保留id，将来用作数据库id
 */
@property long dbId;

@property long id;
@property (strong,nonatomic) NSString *flightNo;
/**
 *  新增airline
 */
@property (strong,nonatomic) NSString *airline;
@property (strong,nonatomic) NSString *isArr;
@property (strong,nonatomic) NSString *region;
@property (strong,nonatomic) NSString *aircraft;
@property (strong,nonatomic) NSString *seat;
@property (strong,nonatomic) NSString *startAirport;
@property (strong,nonatomic) NSString *midAirport;
@property (strong,nonatomic) NSString *endAirport;
@property (strong,nonatomic) NSString *planTakeOff;
@property (strong,nonatomic) NSString *takeOff;
@property (strong,nonatomic) NSString *nativeTakeOff;
@property (strong,nonatomic) NSString *nativeLanding;
@property (strong,nonatomic) NSString *planLanding;
@property (strong,nonatomic) NSString *landing;
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSString *statusCode;
@property (strong,nonatomic) NSString *craftSeat;
@property (strong,nonatomic) NSString *via;
@property (strong,nonatomic) NSString *viaIATA;
@property (strong,nonatomic) NSString *viaPort;
@property (strong,nonatomic) NSString *viaPlanTakeOff;
@property (strong,nonatomic) NSString *viaPlanLanding;
@property (strong,nonatomic) NSString *viaRealTakeOff;
@property (strong,nonatomic) NSString *viaRealLanding;
@property (strong,nonatomic) NSString *delayTime;
@property (strong,nonatomic) NSString *isHomeAbn;
@property (nonatomic,strong) NSString *craftModel;  //机型

@end
