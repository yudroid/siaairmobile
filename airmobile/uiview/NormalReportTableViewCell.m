//
//  NormalReportTableViewCell.m
//  airmobile
//
//  Created by xuesong on 2018/1/23.
//  Copyright © 2018年 杨泉林. All rights reserved.
//

#import "NormalReportTableViewCell.h"



@implementation NormalReportTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (_isSelected) {
//        self.isSelected = false;
//    }else{
//        self.isSelected = true;
//    }
}


-(void) setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        _tagImageView.image = [UIImage imageNamed:@"Completed"];
    }else{
        _tagImageView.image = [UIImage imageNamed:@""];
    }
}

@end
