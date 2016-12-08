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
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

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

-(void)setSafeguardModel:(SafeguardModel *)safeguardModel
{
    _safeguardModel = safeguardModel;
    _nameLabel.text = safeguardModel.name;
    
}

- (IBAction)normalButtonClick:(UIButton *)sender {

    if ([_delegate respondsToSelector:@selector(flightDetailSafeguardTableViewCellNormalButtonClick:)]) {
        sender.tag = self.indexRow;
        [_delegate flightDetailSafeguardTableViewCellNormalButtonClick:sender];
    }

}
- (IBAction)abnormalButtonClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(flightDetailSafeguardTableViewCellAbnormalButtonClick:)]) {
        sender.tag = self.indexRow;
        [_delegate flightDetailSafeguardTableViewCellAbnormalButtonClick:sender];
    }
}

@end
