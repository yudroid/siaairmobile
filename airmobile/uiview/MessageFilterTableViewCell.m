//
//  MessageFilterTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/12/5.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "MessageFilterTableViewCell.h"


@interface MessageFilterTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectTagImageView;

@end

@implementation MessageFilterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setisSelected:(BOOL)selected
{

}

-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        _selectTagImageView.image = [UIImage imageNamed:@"Selected"] ;
    }else{
        _selectTagImageView.image = [UIImage imageNamed:@"Unselected"] ;
    }

}
@end
