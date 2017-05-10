//
//  DispatchModel.h
//  airmobile
//
//  Created by xuesong on 17/4/12.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface DispatchModel : RootModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger fid;
@property (nonatomic, strong) NSString *safeName;
@property (nonatomic, assign) NSInteger isAD;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString *normalTime;
@property (nonatomic, strong) NSString *safeguardDepart;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *dispatchPeople;
@property (nonatomic, strong) NSString *tip;
@property (nonatomic, strong) NSString *realStartTime;
@property (nonatomic, strong) NSString *realEndTime;
@property (nonatomic, assign) NSInteger key;  //1特殊 0普通
@property (nonatomic, strong) NSString *reportId;
@property (nonatomic, assign) NSInteger dispatchId;
//"id":82066127,"fid":4451698,"safeName":"值机","isAD":1,"state":0,"normalTime":null,"safeguardDepart":null,"startTime":null,"endTime":"2017-01-22 09:27:00","status":null,"dispatchPeople":null,"tip":null,"realStartTime":null,"realEndTime":null,"key":0,"reportId":null,"dispatchId":0
-(NSString *)startTimeAndEndTime;
@end
