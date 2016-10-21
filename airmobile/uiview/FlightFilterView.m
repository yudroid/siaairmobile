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
    
}
-(void)setIsSelected:(Boolean)isSelected
{
    _isSelected = isSelected;
    if (isSelected == YES) {
        [self setBackgroundImage:[UIImage imageNamed:@"FlightFilterbuttonSelected"] forState:UIControlStateNormal];
        self.titleLabel.textColor = [CommonFunction colorFromHex:0XFF17B9E8];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"FlightFilterbuttonNoSelected"] forState:UIControlStateNormal];
        self.titleLabel.textColor = [CommonFunction colorFromHex:0XFF2A2D32];
    }
}
-(void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

@end

@interface FlightFilterView ()

@property (nonatomic, strong) NSMutableArray *selectedArray;

@end

@implementation FlightFilterView

-(void)awakeFromNib
{
    [super awakeFromNib];
    _selectedArray = [NSMutableArray array];
    
}
- (IBAction)cancelButtonClick:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}
- (IBAction)sureButtonClick:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}
- (IBAction)selectButtonClick:(FilghtFilterButton *)sender {
    if(sender.isSelected){
        sender.isSelected = NO;
        if ([_selectedArray containsObject:sender]) {
            [_selectedArray removeObject:sender];
        }
    }else{
        sender.isSelected = YES;
        if (![_selectedArray containsObject:sender]) {
            [_selectedArray addObject:sender];
        }
    }
}

@end
