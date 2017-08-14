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
@property (weak, nonatomic) IBOutlet UITextView *contentLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageViewTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelTrailing;

@end

@implementation ChatLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([DeviceInfoUtil isPlus]) {
        [self adjustPLUS];
    }
//    _contentLabel.adjustsFontForContentSizeCategory = YES;

}

-(void)adjustPLUS
{
    _headerImageViewTrailing.constant = px_3(35);
    _headerImageViewWidth.constant = px_3(125);
    _headerImageViewHeight.constant = px_3(125);
    _nameLabelTrailing.constant = px_3(15);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setContentText:(NSString *)contentText
{
    UIFont *textFont =[UIFont fontWithName:@"PingFang SC" size:13];
    CGSize size = ([contentText boundingRectWithSize:CGSizeMake(kScreenWidth-140, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:textFont}
                                            context:nil]).size;
    _contentWidth.constant = size.width+10;
    _contentHeight.constant = size.height;
    _contentLabel.text = [contentText copy];
}

@end
