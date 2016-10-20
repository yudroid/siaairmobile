//
//  ChatTimeTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ChatTimeTableViewCell.h"

@implementation ChatTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _timeLabel.layer.cornerRadius = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
