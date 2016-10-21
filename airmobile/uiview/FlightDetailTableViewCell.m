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
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)unusualButtonClikc:(id)sender {
    if ([_delegate respondsToSelector:@selector(flightDetailTableViewCellUsualButtonClick)]) {
        [_delegate flightDetailTableViewCellUsualButtonClick];
    }
}

@end
