//
//  FlightHourTableViewCell.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightHourTableViewCell.h"

@implementation FlightHourTableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)style psnArea: (PassengerAreaModel *)psnArea
{
    self = [super init];
    if(self){
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(0, 0, kScreenWidth/2-20, 25) text:psnArea.region font:20 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2-40, 25) text:[NSString stringWithFormat:@"%i",(int)psnArea.count] font:20 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B]];
    }
    return self;
}


-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)identifier flightHour: (FlightHourModel *)flightHour
{
    self = [super init];
    if(self){
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(0, 0, kScreenWidth/2-20, 25) text:flightHour.hour font:20 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2-40, 25) text:[NSString stringWithFormat:@"%i",(int)flightHour.count] font:20 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B]];
    }
    return self;
}

-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)identifier flightHour: (FlightHourModel *)flightHour type:(FlightHourType) type
{
    self = [super init];
    if(self){
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(0, 0, 150, 25) text:flightHour.hour font:20 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
        
        if(type == ArrFlightHour){
            [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-20-240, 0, 70, 25) text:@"计划进" font:20 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B]];
            [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-20-120, 0, 70, 25) text:@"实际进" font:20 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B]];
        }else{
            [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-20-240, 0, 70, 25) text:@"计划出" font:20 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B]];
            [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-20-120, 0, 70, 25) text:@"实际出" font:20 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B]];
        }
        
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-20-170, 0, 40, 25) text:[NSString stringWithFormat:@"%i",(int)flightHour.planCount] font:20 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-20-50, 0, 30, 25) text:[NSString stringWithFormat:@"%i",(int)flightHour.count] font:20 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
