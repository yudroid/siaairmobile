//
//  ContactPersonTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ContactPersonTableViewCell.h"

@interface ContactPersonTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;


@end

@implementation ContactPersonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headImageView.layer.cornerRadius  = 20;
    _headImageView.layer.masksToBounds = YES;


    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectButtonClick:(id)sender {
}


-(void)setIsSelected:(Boolean)isSelected
{
    _isSelected= isSelected;
    if (isSelected) {
        [_selectedButton setBackgroundImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
    }else{
        [_selectedButton setBackgroundImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
    }

}
@end
