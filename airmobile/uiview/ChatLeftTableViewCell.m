//
//  ChatLeftTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ChatLeftTableViewCell.h"

@interface ChatLeftTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@end

@implementation ChatLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setContentText:(NSString *)contentText
{
    UIFont *textFont =[UIFont fontWithName:@"PingFang SC" size:13];
    CGSize size = ([contentText boundingRectWithSize:CGSizeMake(kScreenWidth-80, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:textFont}
                                            context:nil]).size;
    _contentWidth.constant = size.width;
    _contentHeight.constant = size.height;
    _contentLabel.text = [contentText copy];
}
@end
