//
//  FlightHourTableViewCell.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightHourTableViewCell.h"

@implementation FlightHourTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)    style
                      psnArea:(PassengerAreaModel *)    psnArea
{
    self = [super init];
    if(self){
        [self.contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(0,
                                                                              0,
                                                                              kScreenWidth/2-20,
                                                                              viewHeight(self.contentView))
                                                              text:psnArea.region
                                                              font:35/2
                                                     textAlignment:(NSTextAlignmentLeft)
                                                      colorFromHex:0xFF000000]];
        [self.contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2,
                                                                              0,
                                                                              kScreenWidth/2-40,
                                                                              viewHeight(self.contentView))
                                                              text:[NSString stringWithFormat:@"%i",(int)psnArea.count]
                                                              font:35/2
                                                     textAlignment:(NSTextAlignmentRight)
                                                      colorFromHex:0xFF000000]];
        UIView *lineView            = [[UIView alloc]initWithFrame:CGRectMake(px2(32),
                                                                              viewHeight(self)-0.5,
                                                                              kScreenWidth-2*px2(32),
                                                                              0.5 )];
        lineView.backgroundColor    = [UIColor grayColor];
        lineView.alpha              = 0.5;
        [self.contentView addSubview:lineView];
    }
    return self;
}


-(instancetype) initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)          identifier
                   flightHour:(FlightHourModel *)   flightHour
{
    self = [super init];
    if(self){
        UILabel *timeLabel  = [[UILabel alloc]initWithFrame:CGRectMake(px2(32),
                                                                       0,
                                                                       (kScreenWidth-2*px2(32))/2,
                                                                       viewHeight(self.contentView))];
        timeLabel.text      = flightHour.hour;
        timeLabel.font      = [UIFont fontWithName:@"PingFang SC" size:px2(36)];
        [self.contentView addSubview:timeLabel];


        UILabel *countLabel         = [[UILabel alloc]initWithFrame:CGRectMake(px2(32)+(kScreenWidth-2*px2(32))/2,
                                                                               0,
                                                                               (kScreenWidth-2*px2(32))/2,
                                                                               viewHeight(self.contentView))];
        countLabel.text             =[NSString stringWithFormat:@"%ld", flightHour.planDepCount+flightHour.planArrCount];
        countLabel.font             = [UIFont fontWithName:@"PingFang SC" size:px2(36)];
        countLabel.textAlignment    = NSTextAlignmentRight;
        [self.contentView addSubview:countLabel];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(px2(32),
                                                                   viewHeight(self.contentView)-0.5,
                                                                   kScreenWidth-2*px2(32),
                                                                   0.5 )];
        lineView.backgroundColor    = [UIColor grayColor];
        lineView.alpha              = 0.5;
        [self.contentView addSubview:lineView];
    }
    return self;
}

-(instancetype) initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)identifier
                   flightHour:(FlightHourModel *)flightHour
                         type:(FlightHourType) type
{
    self = [super init];
    if(self){
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(16, 0, 150, viewHeight(self))
                                                  text:flightHour.hour
                                                  font:18
                                         textAlignment:(NSTextAlignmentLeft)
                                          colorFromHex:0xFF000000]];

        if(type == ArrFlightHour){
            [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-232,
                                                                      (viewHeight(self)-8)/2+3,
                                                                      40,
                                                                      8)
                                                      text:@"计划进"
                                                      font:17/2
                                             textAlignment:(NSTextAlignmentRight)
                                              colorFromHex:0xFF000000]];
            [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-100,
                                                                      (viewHeight(self)-8)/2+3,
                                                                      40,
                                                                      8)
                                                      text:@"实际进"
                                                      font:17/2
                                             textAlignment:(NSTextAlignmentRight)
                                              colorFromHex:0xFF000000]];
            [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-190, 0, 50, viewHeight(self))
                                                      text:[NSString stringWithFormat:@"%i",(int)flightHour.planArrCount]
                                                      font:px2(35)
                                             textAlignment:(NSTextAlignmentLeft)
                                              colorFromHex:0xFF000000]];
            [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-58, 0, 50, viewHeight(self))
                                                      text:[NSString stringWithFormat:@"%i",(int)flightHour.arrCount]
                                                      font:px2(35)
                                             textAlignment:(NSTextAlignmentLeft)
                                              colorFromHex:0xFF000000]];
        }else{
            [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-232,
                                                                      (viewHeight(self)-8)/2+3, 40, 8)
                                                      text:@"计划进"
                                                      font:17/2
                                             textAlignment:(NSTextAlignmentRight)
                                              colorFromHex:0xFF000000]];
            [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-100,
                                                                      (viewHeight(self)-8)/2+3,
                                                                      40,
                                                                      8)
                                                      text:@"实际进"
                                                      font:17/2
                                             textAlignment:(NSTextAlignmentRight)
                                              colorFromHex:0xFF000000]];
            [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-190, 0, 50, viewHeight(self))
                                                      text:[NSString stringWithFormat:@"%i",(int)flightHour.planDepCount]
                                                      font:px2(35)
                                             textAlignment:(NSTextAlignmentLeft)
                                              colorFromHex:0xFF000000]];
            [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-58, 0, 50, viewHeight(self))
                                                      text:[NSString stringWithFormat:@"%i",(int)flightHour.depCount]
                                                      font:px2(35)
                                             textAlignment:(NSTextAlignmentLeft)
                                              colorFromHex:0xFF000000]];
        }
        

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
