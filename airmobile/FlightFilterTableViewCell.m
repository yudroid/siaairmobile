//
//  FlightFilterTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightFilterTableViewCell.h"

@interface FlightFilterTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *insideView;

@end

@implementation FlightFilterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor grayColor];
    _insideView.layer.cornerRadius = 5.0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
