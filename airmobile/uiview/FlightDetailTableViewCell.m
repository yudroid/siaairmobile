//
//  FlightDetailTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDetailTableViewCell.h"
#import "DispatchModel.h"

@interface FlightDetailTableViewCell ()
//@property (weak, nonatomic) IBOutlet UIView *topLineView;
//@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
//
//@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;

//@property (weak, nonatomic) IBOutlet UIView *statusBackView;
//@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UIButton *nomalButton;

@end

@implementation FlightDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

//    _nomalButton.layer.cornerRadius = 10;
//    _unusualButton.layer.cornerRadius = 10;
//    _nomalButton.layer.borderWidth = 1;
//    _unusualButton.layer.borderWidth = 1;
//    _nomalButton.layer.borderColor = [CommonFunction colorFromHex:0xFF18D0AE].CGColor;
//    _unusualButton.layer.borderColor = [CommonFunction colorFromHex:0xFFFF0000].CGColor;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//-(void)setType:(FlightDetailTableViewCellType)type
//{
//    switch (type) {
//        case FlightDetailTableViewCellTypeTypeLast:
//            _bottomLineView.hidden = YES;
//            break;
//        case FlightDetailTableViewCellTypeTypeFirst:
//            _topLineView.hidden = YES;
//            break;
//        default:
//            break;
//    }
//}

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

//-(void)setSafeguardModel:(SafeguardModel *)safeguardModel
//{
//

//    _statusLabel.text = safeguardModel.status;
//    if([safeguardModel.status isEqualToString:@"正常"]){
//        _statusBackView.backgroundColor = [CommonFunction colorFromHex:0Xff2dce70];
//        _tagView.backgroundColor = [CommonFunction colorFromHex:0Xff2dce70];
//    }else if([safeguardModel.status containsString:@"延误"]){
//        _statusBackView.backgroundColor = [CommonFunction colorFromHex:0Xfff46970];
//        _tagView.backgroundColor = [CommonFunction colorFromHex:0Xfff46970];
//    }else if([safeguardModel.status containsString:@"进行中"]){
//        _statusBackView.backgroundColor = [CommonFunction colorFromHex:0Xff17b9e8];
//        _tagView.backgroundColor = [CommonFunction colorFromHex:0Xff17b9e8];
//    }else if([safeguardModel.status containsString:@"未开始"]){
//        _statusBackView.backgroundColor = [CommonFunction colorFromHex:0Xffff7c36];
//        _tagView.backgroundColor = [CommonFunction colorFromHex:0Xffff7c36];
//    }
//}

-(void)setDispatchModel:(DispatchModel *)dispatchModel
{
    UIColor *statusColor = [CommonFunction colorFromHex:0Xffff7c36];
    if([dispatchModel.status isEqualToString:@"正常"]){
        statusColor = [CommonFunction colorFromHex:0Xff2dce70];
    }else if([dispatchModel.status containsString:@"延误"]){
        statusColor = [CommonFunction colorFromHex:0Xfff46970];
    }else if([dispatchModel.status containsString:@"进行中"]){
        statusColor = [CommonFunction colorFromHex:0Xff17b9e8];
    }else if([dispatchModel.status containsString:@"未开始"]){
        statusColor = [CommonFunction colorFromHex:0Xffff7c36];
    }

    dispatchModel.status = dispatchModel.status?:@"";
    NSString *name = [NSString stringWithFormat:@"%@%@%@",dispatchModel.safeName,dispatchModel.status,dispatchModel.isAD==1?@"进":@"出"];
    NSMutableAttributedString *aname = [[NSMutableAttributedString  alloc]initWithString:name];
    [aname addAttribute:NSForegroundColorAttributeName
                  value:statusColor
                  range:[name rangeOfString:dispatchModel.status]];
    [aname addAttribute:NSForegroundColorAttributeName
                  value:dispatchModel.isAD==1?[CommonFunction colorFromHex:0xff2dce70]:[CommonFunction colorFromHex:0xff17b9e8]
                  range:[name rangeOfString:dispatchModel.isAD==1?@"进":@"出"]];
    _nameLabel.attributedText = aname;
    _peopleLabel.text = dispatchModel.dispatchPeople;
    _timeLabel.text = [NSString stringWithFormat:@"%@",[dispatchModel startTimeAndEndTime]];
    _lastTimeLabel.text = [NSString stringWithFormat:@"上次上报时间:%@",dispatchModel.normalTime?:@"无"];
}



@end
