//
//  TimePickerView.m
//  airmobile
//
//  Created by xuesong on 17/3/29.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "TimePickerView.h"

@interface TimePickerView ()
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;


@end

@implementation TimePickerView
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius = 10;
}


- (IBAction)ensureClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(timePickerViewDidSelectDate:)]) {
        
        [_delegate timePickerViewDidSelectDate:_timePicker.date];
    }
    [self removeFromSuperview];
}
- (IBAction)cancelClick:(id)sender {
    [self removeFromSuperview];

}

@end
