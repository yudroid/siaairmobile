//
//  FlightDetailTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDetailTableViewCell.h"
#import "SafeguardModel.h"

@interface FlightDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;

@property (weak, nonatomic) IBOutlet UIView *statusBackView;
@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UIButton *nomalButton;

@end

@implementation FlightDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];


    _statusLabel.adjustsFontSizeToFitWidth = YES;
    _statusBackView.layer.cornerRadius = viewWidth(_statusBackView)/2.0;
    _statusBackView.layer.masksToBounds = YES;
    _tagView.layer.cornerRadius = viewWidth(_tagView)/2;
    _nomalButton.layer.cornerRadius = 10;
    _unusualButton.layer.cornerRadius = 10;
    _nomalButton.layer.borderWidth = 1;
    _unusualButton.layer.borderWidth = 1;
    _nomalButton.layer.borderColor = [CommonFunction colorFromHex:0xFF18D0AE].CGColor;
    _unusualButton.layer.borderColor = [CommonFunction colorFromHex:0xFFFF0000].CGColor;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setType:(FlightDetailTableViewCellType)type
{
    switch (type) {
        case FlightDetailTableViewCellTypeTypeLast:
            _bottomLineView.hidden = YES;
            break;
        case FlightDetailTableViewCellTypeTypeFirst:
            _topLineView.hidden = YES;
            break;
        default:
            break;
    }
}

- (IBAction)normalButtonClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(flightDetailTableViewCellnormalButtonClick:)]) {
        sender.tag = self.indexRow;
        [_delegate flightDetailTableViewCellnormalButtonClick:sender];
    }

}

- (IBAction)unusualButtonClikc:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(flightDetailTableViewCellUsualButtonClick:)]) {
        sender.tag = self.indexRow;
        [_delegate flightDetailTableViewCellUsualButtonClick:sender];
    }
}

-(void)setSafeguardModel:(SafeguardModel *)safeguardModel
{
//
    NSString *name = [NSString stringWithFormat:@"%@%@",safeguardModel.name,safeguardModel.isAD?@"进":@"出"];
    NSMutableAttributedString *aname = [[NSMutableAttributedString  alloc]initWithString:name];
    [aname addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"PingFangSC-Regular" size:11]
                  range:[name rangeOfString:safeguardModel.isAD?@"进":@"出"]];
    [aname addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[name rangeOfString:safeguardModel.isAD?@"进":@"出"]];

    _nameLabel.attributedText = aname;
    _statusLabel.text = safeguardModel.status;
    if([safeguardModel.status isEqualToString:@"正常"]){
        _statusBackView.backgroundColor = [CommonFunction colorFromHex:0Xff2dce70];
        _tagView.backgroundColor = [CommonFunction colorFromHex:0Xff2dce70];
    }else if([safeguardModel.status containsString:@"延误"]){
        _statusBackView.backgroundColor = [CommonFunction colorFromHex:0Xfff46970];
        _tagView.backgroundColor = [CommonFunction colorFromHex:0Xfff46970];
    }else if([safeguardModel.status containsString:@"进行中"]){
        _statusBackView.backgroundColor = [CommonFunction colorFromHex:0Xff17b9e8];
        _tagView.backgroundColor = [CommonFunction colorFromHex:0Xff17b9e8];
    }else if([safeguardModel.status containsString:@"未开始"]){
        _statusBackView.backgroundColor = [CommonFunction colorFromHex:0Xffff7c36];
        _tagView.backgroundColor = [CommonFunction colorFromHex:0Xffff7c36];
    }
    _peopleLabel.text = safeguardModel.dispatchPeople;
    _timeLabel.text = [NSString stringWithFormat:@"%@",[safeguardModel startTimeAndEndTime]];

}



@end
