//
//  FlightDetailSafeguardTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDetailSpecialTableViewCell.h"
#import "SpecialModel.h"


@interface FlightDetailSpecialTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *starReportButton;
@property (weak, nonatomic) IBOutlet UIButton *delayReportButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *inOutImageView;
@property (weak, nonatomic) IBOutlet UILabel *inOutLabel;

@end


@implementation FlightDetailSpecialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _starReportButton.layer.cornerRadius = 5.0;
    _delayReportButton.layer.cornerRadius=5.0;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSpecialModel:(SpecialModel *)specialModel
{
    _specialModel = specialModel;
    _nameLabel.text = specialModel.safeName;
    if (specialModel.isAD) {
        _inOutLabel.text = @"出";
        _inOutImageView.image = [UIImage imageNamed:@"icon_keysafe_out"];
    }else{
        _inOutLabel.text = @"进";
        _inOutImageView.image = [UIImage imageNamed:@"icon_keysafe_in"];

    }

    if (specialModel.tag == 1){
        _statusLabel.text = @"--正常--";
        _statusLabel.textColor = [CommonFunction colorFromHex:0xff2dce70];
    }else if (specialModel.tag == 2){
        _statusLabel.text = @"--异常--";
        _statusLabel.textColor = [CommonFunction colorFromHex:0xfff46970];
    }else if(specialModel.tag == 0 || !specialModel.normalTime || [specialModel.normalTime isEqualToString:@""]){
        _statusLabel.text = @"--未开始--";
        _statusLabel.textColor = [CommonFunction colorFromHex:0xffff7c36];
    }

    if (specialModel.normalTime &&[specialModel.normalTime isKindOfClass:[NSString class]]&&![specialModel.normalTime isEqualToString:@""]) {
        [_starReportButton setTitle:specialModel.normalTime forState:UIControlStateNormal] ;
//        _starReportButton.enabled = NO;
    }
}

- (IBAction)normalButtonClick:(UIButton *)sender {

    if ([_delegate respondsToSelector:@selector(flightDetailSpecialTableViewCellNormalButtonClick:)]) {
        sender.tag = self.indexRow;
        [_delegate flightDetailSpecialTableViewCellNormalButtonClick:sender];
    }

}
- (IBAction)abnormalButtonClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(flightDetailSpecialTableViewCellAbnormalButtonClick:)]) {
        sender.tag = self.indexRow;
        [_delegate flightDetailSpecialTableViewCellAbnormalButtonClick:sender];
    }
}

@end
