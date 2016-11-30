//
//  FlightDetailSafeguardTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDetailSafeguardTableViewCell.h"
#import "SafeguardModel.h"


@interface FlightDetailSafeguardTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *starReportButton;
@property (weak, nonatomic) IBOutlet UIButton *delayReportButton;

@end


@implementation FlightDetailSafeguardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _starReportButton.layer.cornerRadius = 5.0;
    _delayReportButton.layer.cornerRadius=5.0;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)normalButtonClick:(id)sender {

    if ([_delegate respondsToSelector:@selector(flightDetailSafeguardTableViewCellNormalButtonClick:)]) {
        [_delegate flightDetailSafeguardTableViewCellNormalButtonClick:sender];
    }

}
- (IBAction)abnormalButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(flightDetailSafeguardTableViewCellAbnormalButtonClick:)]) {
        [_delegate flightDetailSafeguardTableViewCellAbnormalButtonClick:sender];
    }
}

@end
