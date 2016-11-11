//
//  EventRemindViewController.m
//  airmobile
//
//  Created by xuesong on 16/11/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDelaysDetailViewController.h"

@interface FlightDelaysDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelLeading;
@end

@implementation FlightDelaysDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitie];


    _textFieldWidth.constant = kScreenWidth-62;

    if ([DeviceInfoUtil isPlus]) {
        [self adjustPLUS];
    }

}

-(void)initTitie{
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"群体事件提醒"];
    [self titleViewAddBackBtn];
}


-(void)setContentText:(NSString *)contentText
{
    _contentLabel.text = [contentText copy];
}


-(void)adjustPLUS
{
    _titleLabelLeading.constant = px_3(102);
    _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:px_3(52)];
    _contentLabelTop.constant = px_3(47);
    _contentLabelLeading.constant = px_3(102);

    _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:px_3(52)];
    _authorLabel.font = [UIFont fontWithName:@"PingFang SC" size:px_3(40)];
    _timeLabel.font = [UIFont fontWithName:@"PingFang SC" size:px_3(40)];
    _contentLabel.font = [UIFont fontWithName:@"PongFang SC" size:px_3(52)];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
