//
//  NightShiftRoomTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "NightShiftRoomTableViewCell.h"

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

@end
