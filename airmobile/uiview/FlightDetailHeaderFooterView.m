//
//  FlightDetailHeaderFooterView.m
//  airmobile
//
//  Created by xuesong on 16/12/21.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDetailHeaderFooterView.h"

@interface FlightDetailHeaderFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation FlightDetailHeaderFooterView

-(void)awakeFromNib
{
    [super awakeFromNib];
    if (![CommonFunction hasFunction:FL_ALLDISPATCH]) {
        _addButton.hidden = YES;
    }
}


- (IBAction)showAndHidenButtonClick:(UIButton *)sender {

    if (sender.tag == 0) {

        sender.tag = 1;
        [UIView animateWithDuration:0.3 animations:^{
            sender.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }else{
        sender.tag = 0;
        [UIView animateWithDuration:0.3 animations:^{
            sender.transform = CGAffineTransformMakeRotation(0);

        }];
    }
    if ([_delegate respondsToSelector:@selector(flightDetailHeaderFooterView:showAndHiddenButton:)]) {
        [_delegate flightDetailHeaderFooterView:self showAndHiddenButton:sender];
    }
}
- (IBAction)addButtonClick:(id)sender {

    if ([_delegate respondsToSelector:@selector(flightDetailHeaderFooterView:addButtonClick:)]) {
        [_delegate flightDetailHeaderFooterView:self addButtonClick:sender];
    }
}

@end
