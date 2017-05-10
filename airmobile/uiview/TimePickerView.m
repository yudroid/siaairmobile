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
@property (weak, nonatomic) IBOutlet UIView *backgroundView;


@end

@implementation TimePickerView
-(void)awakeFromNib
{
    [super awakeFromNib];
//    self.layer.cornerRadius = 10;
//    self.layer.masksToBounds = YES;
    _backgroundView.layer.cornerRadius = 10;
    _backgroundView.layer.masksToBounds = YES;

}


- (IBAction)ensureClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(timePickerViewDidSelectDate:)]) {
        NSDate *date = _timePicker.date;
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate: date];
        NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
        [_delegate timePickerViewDidSelectDate:localeDate];
    }
    [self removeFromSuperview];
}
- (IBAction)cancelClick:(id)sender {
    [self removeFromSuperview];

}

@end
