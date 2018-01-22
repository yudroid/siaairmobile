//
//  NormalReportView.m
//  airmobile
//
//  Created by xuesong on 2018/1/19.
//  Copyright © 2018年 杨泉林. All rights reserved.
//

#import "NormalReportView.h"


@interface NormalReportView ()
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@end

@implementation NormalReportView

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


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
