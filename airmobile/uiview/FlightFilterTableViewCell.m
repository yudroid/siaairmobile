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
@property (weak, nonatomic) IBOutlet UILabel *flightNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *craftModelLable;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *craftSeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *preTakeOffLabel;
@property (weak, nonatomic) IBOutlet UILabel *landingLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextLandingLabel;
@property (weak, nonatomic) IBOutlet UILabel *flightStatus;
@property (weak, nonatomic) IBOutlet UILabel *preAirportLabel;
@property (weak, nonatomic) IBOutlet UILabel *airportLable;
@property (weak, nonatomic) IBOutlet UILabel *nextAirportLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIView *middleView;

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
    _landingLabel.text = flight.mTime;
    _airportLable.text = flight.mCity;
    _nextLandingLabel.text = flight.eTime;
    _nextAirportLabel.text = flight.eCity;
    _flightStatus.text = flight.fState;
    if(flight.special==0){
        _backImageView.hidden = YES;
    }
    
}

@end
