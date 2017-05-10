//
//  WillGoFlightTableViewCell.m
//  airmobile
//
//  Created by xuesong on 2017/4/18.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "WillGoFlightTableViewCell.h"
#import "WillGoFlightModel.h"

@interface WillGoFlightTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *flightNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *colorView;


@end

@implementation WillGoFlightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setIndex:(NSInteger)index
{
    _index = index;
    _indexLabel.text = @(index).stringValue;
}

-(void)setWillGoFlightModel:(WillGoFlightModel *)willGoFlightModel
{
    _willGoFlightModel = willGoFlightModel;
    _flightNoLabel.text = willGoFlightModel.flyno;
    _timeLabel.text = willGoFlightModel.flyTime;

    if (willGoFlightModel.delayTime.integerValue ==0) {
        _colorView.backgroundColor = [CommonFunction colorFromHex:0xFF0f6a30];
    }else if (willGoFlightModel.delayTime.integerValue < 20){
        _colorView.backgroundColor = [CommonFunction colorFromHex:0xFF9ab212];
    }else if (willGoFlightModel.delayTime.integerValue < 30){
        _colorView.backgroundColor = [CommonFunction colorFromHex:0xFFc73013];
    }else {
        _colorView.backgroundColor = [CommonFunction colorFromHex:0xFFf61605];
    }
}
@end
