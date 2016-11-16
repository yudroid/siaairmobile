//
//  AbnormalityReportCollectionViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AbnormalityReportCollectionViewCell.h"

@interface AbnormalityReportCollectionViewCell ()




@end

@implementation AbnormalityReportCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        _selectedBackgroundImageView.image = [UIImage imageNamed:@"UploadImageSelected"];
    }else{
        _selectedBackgroundImageView.image = [UIImage imageNamed:@"UploadImageNotSelected"];
    }
}







@end
