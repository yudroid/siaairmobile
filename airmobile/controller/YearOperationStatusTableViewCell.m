//
//  YearOperationStatusTableViewCell.m
//  airmobile
//
//  Created by xuesong on 2017/7/21.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "YearOperationStatusTableViewCell.h"

@implementation YearOperationStatusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _nameLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
