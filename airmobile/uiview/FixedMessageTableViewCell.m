//
//   Initialization code } FixedMessageTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FixedMessageTableViewCell.h"

@implementation FixedMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _headImageView.layer.cornerRadius = viewWidth(_headImageView)/2;
    _headImageView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
