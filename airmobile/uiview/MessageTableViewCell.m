//
//  MessageTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headImageView.layer.cornerRadius = 20;
    _headImageView.layer.masksToBounds = YES;
    _unReadLabel.layer.cornerRadius = 6.0;
    _unReadLabel.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setUnRead:(NSInteger)unRead
{
    if (unRead ==0 ) {
        _unReadLabel.hidden = YES;
    }else{
        _unReadLabel.hidden = NO;
        _unReadLabel.text = @(unRead).stringValue;
    }
    _unRead = unRead;

}

@end

