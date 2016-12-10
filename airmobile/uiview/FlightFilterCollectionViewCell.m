//
//  FlightFilterCollectionViewCell.m
//  airmobile
//
//  Created by xuesong on 16/12/10.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightFilterCollectionViewCell.h"

@implementation FlightFilterCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _contentButton.enabled = NO;
}

-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected == YES) {
        [self.contentButton setBackgroundImage:[UIImage imageNamed:@"FlightFilterbuttonSelected"] forState:UIControlStateNormal];
        self.contentButton.titleLabel.textColor = [CommonFunction colorFromHex:0XFF17B9E8];
    }else{
        [self.contentButton setBackgroundImage:[UIImage imageNamed:@"FlightFilterbuttonNoSelected"] forState:UIControlStateNormal];
        self.contentButton.titleLabel.textColor = [CommonFunction colorFromHex:0XFF2A2D32];
    }
}

@end
