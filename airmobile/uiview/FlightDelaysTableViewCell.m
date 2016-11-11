//
//  FlightDelaysTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/11/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDelaysTableViewCell.h"

@interface FlightDelaysTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation FlightDelaysTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bgView.layer.cornerRadius = 10;
    _bgView.layer.borderWidth = 1.0;
    _bgView.layer.borderColor = [CommonFunction colorFromHex:0XFF949494].CGColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
