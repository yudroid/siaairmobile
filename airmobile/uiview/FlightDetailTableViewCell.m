//
//  FlightDetailTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDetailTableViewCell.h"

@interface FlightDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;


@end

@implementation FlightDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setType:(FlightDetailTableViewCellType)type
{
    switch (type) {
    case FlightDetailTableViewCellTypeTypeLast:
    _bottomLineView.hidden = YES;
    break;
    case FlightDetailTableViewCellTypeTypeFirst:
    _topLineView.hidden = YES;
    break;
    default:
    break;
}
}


- (IBAction)unusualButtonClikc:(id)sender {
    if ([_delegate respondsToSelector:@selector(flightDetailTableViewCellUsualButtonClick)]) {
        [_delegate flightDetailTableViewCellUsualButtonClick];
    }
}

@end
