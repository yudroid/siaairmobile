//
//  FlightDetailAirLineCollectionViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDetailAirLineCollectionViewCell.h"

@interface FlightDetailAirLineCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIView *roundView;
@property (weak, nonatomic) IBOutlet UIImageView *leftLineImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightLIneImageView;

@end

@implementation FlightDetailAirLineCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _roundView.layer.cornerRadius = 4.0;
    _roundView.layer.borderWidth = 1.0;
    _roundView.layer.borderColor = [UIColor grayColor].CGColor;
    
}


-(void)setType:(FlightDetailAirLineCollectionViewCellType)type
{
    switch (type) {
        case FlightDetailAirLineCollectionViewCellTypeLast:
            _rightLIneImageView.hidden = YES;
            break;
        case FlightDetailAirLineCollectionViewCellTypeFirst:
            _leftLineImageView.hidden = YES;
            break;
        default:
            break;
    }
}


@end
