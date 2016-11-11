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
@end

@implementation FlightDelaysDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitie];


    _textFieldWidth.constant = kScreenWidth-62;

    


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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
