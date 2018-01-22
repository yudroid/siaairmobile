//
//  FlightDetailOrderTableViewCell.m
//  airmobile
//
//  Created by xuesong on 2018/1/19.
//  Copyright © 2018年 杨泉林. All rights reserved.
//

#import "FlightDetailOrderTableViewCell.h"

@implementation FlightDetailOrderTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)normalReportButtonClick:(id)sender {

    if([_delegate respondsToSelector:@selector(flightDetailOrderTableViewCellNormalButtonClick:)]){
        [_delegate flightDetailOrderTableViewCellNormalButtonClick:sender];
    }


}
- (IBAction)abnormalReportButtonClick:(id)sender {
    if([_delegate respondsToSelector:@selector(flightDetailOrderTableViewCellAbnormalButtonClick:)]){
        [_delegate flightDetailOrderTableViewCellAbnormalButtonClick:sender];
    }
    
}

@end
