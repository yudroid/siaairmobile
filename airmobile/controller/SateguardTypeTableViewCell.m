//
//  SateguardTypeTableViewCell.m
//  airmobile
//
//  Created by xuesong on 17/4/11.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "SateguardTypeTableViewCell.h"
#import "SateguardTypeModel.h"

@implementation SateguardTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSatefuardTypeModel:(SateguardTypeModel *)satefuardTypeModel
{
    _satefuardTypeModel = satefuardTypeModel;
    if ([satefuardTypeModel.flagSuervise isEqualToString:@"1"]) {
        _selectedImageView.image = [UIImage imageNamed:@"type-selected"];
    }else{
        _selectedImageView.image = [UIImage imageNamed:@"type-noselected"];
    }
    _nameLabel.text = satefuardTypeModel.name;
}

@end
