//
//  TimePickerView.m
//  airmobile
//
//  Created by xuesong on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "TimePickerView.h"

@interface TimePickerView ()

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *ensureButton;

@end

@implementation TimePickerView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor =  [CommonFunction colorFromHex:0XCCEBEBF1];

    _backgroundView.layer.cornerRadius = 10.0;
    _cancelButton.layer.cornerRadius = 5.0;
    _cancelButton.layer.borderColor = [CommonFunction colorFromHex:0XFF4484f6].CGColor;
    _cancelButton.layer.borderWidth = 1.0;

    _ensureButton.layer.cornerRadius = 5.0;
    _ensureButton.layer.borderColor = [CommonFunction colorFromHex:0XFF4484f6].CGColor;
    _ensureButton.layer.borderWidth = 1.0;

}
- (IBAction)cancelButtonClick:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];

    if ([_delegate respondsToSelector:@selector(timePickerViewDidCancel)]) {
        [_delegate timePickerViewDidCancel];
    }
}
- (IBAction)ensureButtonClick:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
    if ([_delegate respondsToSelector:@selector(timePickerViewDidEnsure:)]) {
        [_delegate timePickerViewDidEnsure:_pickerView.date];
    }
}
@end
