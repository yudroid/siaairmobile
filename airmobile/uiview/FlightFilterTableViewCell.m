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

    NSString *airline = [NSString stringWithFormat:@"airline_%@", [flight.fNum substringToIndex:2]];
    _airlineImage.image = [CommonFunction imageWithName:airline leftCap:0 topCap:0];
    if (_airlineImage.image == nil) {
        _airlineImage.image = [UIImage imageNamed:@"logo_flight"];
    }
    _flightNoLabel.text = [NSString stringWithFormat:@"%@%@",flight.fName,flight.fNum];
    _craftModelLable.text = flight.model;
    _regionLabel.text = flight.region;
    _craftSeatLabel.text = flight.seat;




    _flightStatus.text = flight.fState;
    if(flight.special.integerValue == 0){
        _backImageView.image = [UIImage imageNamed:@"FlightNormal"];
        _specialLabel.text = @"普";
//        _statusReasonLabel.text = @"";
    }else{
        _backImageView.image = [UIImage imageNamed:@"FlightSpecial"];
        _specialLabel.text = @"特";
//        _statusReasonLabel.text = @"天气原因";
    }

    if([flight.fState isEqualToString:@"正常"]){
        _flightStatus.textColor = [CommonFunction colorFromHex:0Xff2DCE70];
    }else{
        _flightStatus.textColor = [CommonFunction colorFromHex:0Xffff7c36];
    }

    if(!flight.sCity||[flight.sCity isEqualToString:@""]){
        _middleView.hidden = YES;
        _preTakeOffLabel.text = flight.mOutTime;
        _preAirportLabel.text = flight.mOutCity;
    }else{
        _middleView.hidden = NO;
        _preTakeOffLabel.text = flight.sTime;
        _preAirportLabel.text = flight.sCity;
        _takeOffLabel.text = flight.mOutTime;
        _takeOffAirportLabel.text = flight.mInCity;
        _landingLabel.text = flight.mInTime;
    }
    _nextLandingLabel.text = flight.eTime;
    _nextAirportLabel.text = flight.eCity;
    
}

@end
