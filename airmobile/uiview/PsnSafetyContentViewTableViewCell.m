//
//  PsnSafetyContentViewTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/12/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PsnSafetyContentViewTableViewCell.h"


@interface PsnSafetyContentViewTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;


@end

@implementation PsnSafetyContentViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setContent:(NSDictionary *)content
{
    _content = content;
    _titleLabel.text = [content objectForKey:@"hour"] ;
    _valueLabel.text = ((NSNumber *)[content objectForKey:@"count"]).stringValue;

}

@end
