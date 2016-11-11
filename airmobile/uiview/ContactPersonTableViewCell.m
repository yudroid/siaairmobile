//
//  ContactPersonTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ContactPersonTableViewCell.h"

@interface ContactPersonTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seleedImageViewTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageViewTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelTrailing;

@end

@implementation ContactPersonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    if ([DeviceInfoUtil isPlus]) {
        [self adjustPLUS];
    }

    // Initialization code
}

-(void)adjustPLUS
{
    _seleedImageViewTrailing.constant = px_3(47);
    _headerImageViewTrailing.constant = px_3(33);
    _nameLabelTrailing.constant = px_3(30);
    _nameLabel.font = [UIFont fontWithName:@"PingFang SC" size:px_3(54)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setIsSelected:(Boolean)isSelected
{
    _isSelected= isSelected;
    if (isSelected) {
        _selectedImageView.image = [UIImage imageNamed:@"Selected"] ;
    }else{
        _selectedImageView.image = [UIImage imageNamed:@"Unselected"] ;
    }
}
@end
