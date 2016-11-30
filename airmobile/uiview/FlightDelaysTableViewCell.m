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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundViewLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelbottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *authorLableBottom;
@property (weak, nonatomic) IBOutlet UIImageView *readTagImageView;
@property (weak, nonatomic) IBOutlet UILabel *readTagLabel;

@end

@implementation FlightDelaysTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    if ([DeviceInfoUtil isPlus]) {
        [self adjustPLUS];
    }

    // Initialization code
}

-(void)adjustPLUS
{
    _titleLabelTop.constant = px_3(26);
    _titleLabelLeading.constant = px_3(40);
    _backgroundViewLeading.constant = px_3(33);
    _titleLabelbottom.constant = px_3(37);
    _authorLableBottom.constant = px_3(27);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setRead:(BOOL)read
{
    _read = read;
    if (read) {
        _readTagLabel.text = @"已读";
        _readTagImageView.image = [UIImage imageNamed:@"ReadTagGrey"];
    }else{
        _readTagLabel.text = @"未读";
        _readTagImageView.image = [UIImage imageNamed:@"ReadTagRed"];

    }
}

@end
