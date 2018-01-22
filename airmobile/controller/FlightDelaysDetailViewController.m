//
//  EventRemindViewController.m
//  airmobile
//
//  Created by xuesong on 16/11/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDelaysDetailViewController.h"
#import "HttpsUtils+Business.h"
#import "UIViewController+Reminder.h"
#import "SysMessageModel.h"
#import "PersistenceUtils+Business.h"

@interface FlightDelaysDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelLeading;
@end

@implementation FlightDelaysDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitie];
    _textFieldWidth.constant = kScreenWidth-62;

    _titleLabel.text = [_titleText isEqualToString:@"(null)"]?@" ":_titleText;
    _contentLabel.text = [_contentText isEqualToString:@"(null)"]?@" ":_contentText;
    if ([DeviceInfoUtil isPlus]) {
        [self adjustPLUS];
    }
}

-(void)initTitie{
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];

    [self titleViewAddBackBtn];

    if(_type == 1) {
        [self titleViewAddTitleText:@"重要消息"];
        UIButton *tagButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-16-30, 27, 40, 30)];
        tagButton.titleLabel.font =  [UIFont fontWithName:@"PingFang SC" size:13];
        if (_sysMessageModel.status&&([_sysMessageModel.status isEqualToString:@"UNCONFIRM"])) {
            [tagButton setTitle:@"确认" forState:UIControlStateNormal];
            [tagButton addTarget: self action:@selector(concernButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        }else if(_sysMessageModel.status &&( [_sysMessageModel.status isEqualToString:@"CONFIRMED"]||[_sysMessageModel.status isEqualToString:@"CONFIRM"])){
            [tagButton setTitle:@"已确认" forState:UIControlStateNormal];
        }else{
            tagButton.hidden = YES;
        }

        [self.titleView addSubview:tagButton];
    }else{
        [self titleViewAddTitleText:@"群体事件提醒"];

    }



}


-(void)concernButtonClick:(UIButton *)sender
{
    [self starNetWorking];
    [HttpsUtils messageSureWithMsgId:@(_sysMessageModel.msgid).stringValue
                             success:^(id responsed) {
                                 [self stopNetWorking];

                                 [PersistenceUtils updateMessageSureWithMsgId:@(_sysMessageModel.msgid).stringValue];
                                 [self showAnimationTitle:@"确认成功"];
                             } failure:^(NSError *error) {
                                 [self stopNetWorking];
                                 [self showAnimationTitle:@"确认失败"];
                             }];

}

-(void)setContentText:(NSString *)contentText
{
    _contentText = [contentText copy];
    _contentLabel.text = [contentText copy];
}


-(void)adjustPLUS
{
    _titleLabelLeading.constant = px_3(102);
    _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:px_3(52)];
    _contentLabelTop.constant = px_3(47);
    _contentLabelLeading.constant = px_3(102);

    _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:px_3(52)];

    _timeLabel.font = [UIFont fontWithName:@"PingFang SC" size:px_3(40)];
    _contentLabel.font = [UIFont fontWithName:@"PongFang SC" size:px_3(52)];

}
-(void)setTitleText:(NSString *)titleText
{
    _titleText = [titleText copy];
    _titleLabel.text = [titleText copy];

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
