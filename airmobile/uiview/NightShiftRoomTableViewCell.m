//
//  NightShiftRoomTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "NightShiftRoomTableViewCell.h"
#import "DutyModel.h"

@implementation NightShiftRoomTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _tagLabel.layer.cornerRadius = 5.0;
    _tagLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setDutyModel:(DutyModel *)dutyModel
{
    if (dutyModel == nil) {
        return;
    }
    _dutyModel = dutyModel;
    _dptLabel.text = dutyModel.section;
    _nameLabel.text = dutyModel.userName;
    _phoneLabel.text = dutyModel.phone;
    _titleLabel.text = dutyModel.duty;
}
@end
