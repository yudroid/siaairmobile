//
//  FlightFliterView.m
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightFilterView.h"

@implementation FilghtFilterButton


-(void) awakeFromNib{
    [super awakeFromNib];
    self.layer.cornerRadius = 5.0;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [CommonFunction colorFromHex:0XFFA7E6F8].CGColor;
    
}

-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.backgroundColor = [CommonFunction colorFromHex:0XFFA7E6F8];
        self.titleLabel.textColor = [CommonFunction colorFromHex:0XFF28BEEA];
        
    }else{
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor blackColor];
        
    }
}

@end

@implementation FlightFilterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];
    
}
- (IBAction)cancelButtonClick:(id)sender {
    [UIView animateWithDuration:0.6 animations:^{
        self.alpha = 0;
    }];
}
- (IBAction)sureButtonClick:(id)sender {
    [UIView animateWithDuration:0.6 animations:^{
        self.alpha = 0;
    }];
}

@end
