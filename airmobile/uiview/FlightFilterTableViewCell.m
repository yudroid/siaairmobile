//
//  FlightFilterTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightFilterTableViewCell.h"

@interface FlightFilterTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *insideView;
@property (weak, nonatomic) IBOutlet UIImageView *airlineImage;
@property (weak, nonatomic) IBOutlet UILabel *flightNoLabel; //航班
@property (weak, nonatomic) IBOutlet UILabel *craftModelLable;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *craftSeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *preTakeOffLabel;
@property (weak, nonatomic) IBOutlet UILabel *landingLabel;//本站到达时间
@property (weak, nonatomic) IBOutlet UILabel *takeOffLabel;//本站起飞时间
@property (weak, nonatomic) IBOutlet UILabel *nextLandingLabel;//下一站到达时间
@property (weak, nonatomic) IBOutlet UILabel *flightStatus;
@property (weak, nonatomic) IBOutlet UILabel *preAirportLabel;//前站起飞城市
@property (weak, nonatomic) IBOutlet UILabel *airportLable;//本站到达城市
@property (weak, nonatomic) IBOutlet UILabel *takeOffAirportLabel;//本站起飞城市
@property (weak, nonatomic) IBOutlet UILabel *nextAirportLabel;//下站到达城市
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UILabel *specialLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusReasonLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingAlign;


@end

@implementation FlightFilterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _insideView.layer.cornerRadius = 5.0;

    _leadingAlign.constant = px_px_2_2_3(-40, 0, 0);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) refreshData:(FlightModel *)flight
{
//    flight.id = [[item objectForKey:@""] intValue];// 航班ID
//    flight.fNum = [item objectForKey:@""];//航班号
//    flight.fName= [item objectForKey:@""];//航班名称
//    flight.model= [item objectForKey:@""];//机型
//    flight.seat= [item objectForKey:@""]; //机位
//    flight.sTime= [item objectForKey:@""];//前序航班城市时间
//    flight.mTime= [item objectForKey:@""];//本站时间
//    flight.eTime= [item objectForKey:@""];//后序航班城市时间
//    flight.sCity= [item objectForKey:@""];//前序航班城市
//    flight.mCity= [item objectForKey:@""];//本站
//    flight.eCity= [item objectForKey:@""];//后序航班城市
//    flight.rangeSate= [item objectForKey:@""];
//    flight.region= [[item objectForKey:@""] intValue];//区域属性
//    flight.fState= [[item objectForKey:@""] intValue];//航班状态
//    flight.special= [[item objectForKey:@""] intValue];//是否特殊航班 0:普通 1：特殊
    
//    airlineImage
//    @property (weak, nonatomic) IBOutlet UIImageView *airlineImage;
//    @property (weak, nonatomic) IBOutlet UILabel *flightNoLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *craftModelLable;
//    @property (weak, nonatomic) IBOutlet UILabel *regionLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *craftSeatLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *preTakeOffLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *landingLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *nextLandingLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *flightStatus;
//    @property (weak, nonatomic) IBOutlet UILabel *preAirportLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *airportLable;
//    @property (weak, nonatomic) IBOutlet UILabel *nextAirportLabel;
//    @property (weak, nonatomic) IBOutlet UIImageView *backImageView;
//    @property (weak, nonatomic) IBOutlet UIView *middleView;
    NSString *airline = [NSString stringWithFormat:@"airline_%@", [flight.fNum substringToIndex:2]];
    _airlineImage.image = [CommonFunction imageWithName:airline leftCap:0 topCap:0];
    _flightNoLabel.text = [NSString stringWithFormat:@"%@%@",flight.fName,flight.fNum];
    _craftModelLable.text = flight.model;
    _regionLabel.text = flight.region;
    _craftSeatLabel.text = flight.seat;
    _preTakeOffLabel.text = flight.sTime;
    _preAirportLabel.text = flight.sCity;
    _takeOffLabel.text = flight.mTime;
    _takeOffAirportLabel.text = flight.mCity;
    _landingLabel.text = flight.mTime;
    _airportLable.text = flight.mCity;
    _nextLandingLabel.text = flight.eTime;
    _nextAirportLabel.text = flight.eCity;
    _flightStatus.text = flight.fState;
    if([flight.special isEqualToString:@"0"]){
        _backImageView.image = [UIImage imageNamed:@"FlightNormal"];
        _specialLabel.text = @"普";
        _statusReasonLabel.text = @"";
    }else{
        _backImageView.image = [UIImage imageNamed:@"FlightSpecial"];
        _specialLabel.text = @"特";
        _statusReasonLabel.text = @"天气原因";
    }

    if([flight.fState isEqualToString:@"正常"]){
        _flightStatus.textColor = [CommonFunction colorFromHex:0Xff2DCE70];
    }else{
        _flightStatus.textColor = [CommonFunction colorFromHex:0Xffff7c36];
    }
    
}

@end
