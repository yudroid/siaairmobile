//
//  FlightDetailTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDetailTableViewCell.h"
#import "SafeguardModel.h"

@interface FlightDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;

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

-(void)setSafeguardModel:(SafeguardModel *)safeguardModel
{
    _nameLabel.text = safeguardModel.name;
    _statusLabel.text = safeguardModel.status;
    if([safeguardModel.status isEqualToString:@"正常"]){
        _stateImageView.image = [UIImage imageNamed:@"FlightDetailState1"];
    }else{
        _stateImageView.image = [UIImage imageNamed:@"FlightDetailState"];
    }
    _peopleLabel.text = safeguardModel.dispatchPeople;
    _timeLabel.text = [NSString stringWithFormat:@"%@-%@",safeguardModel.realStartTime,safeguardModel.endTime];
}



@end
