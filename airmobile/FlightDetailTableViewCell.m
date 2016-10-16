//
//  FlightDetailTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDetailTableViewCell.h"

@implementation FlightDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _finishStatusLabel.layer.cornerRadius = 20;
    _finishStatusLabel.layer.masksToBounds = YES;
    _unusualButton.layer.cornerRadius = 5.0;
    _unusualButton.layer.borderColor = [UIColor redColor].CGColor;
    _unusualButton.layer.borderWidth = 1.0;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
