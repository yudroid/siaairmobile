//
//  FlightHourTableViewCell.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightHourModel.h"
#import "EnumTypeModel.h"
#import "PassengerAreaModel.h"

@interface FlightHourTableViewCell : UITableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)style psnArea: (PassengerAreaModel *)psnArea;
-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)identifier flightHour: (FlightHourModel *)flightHour;
-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)identifier flightHour: (FlightHourModel *)flightHour type:(FlightHourType) type;

@end
