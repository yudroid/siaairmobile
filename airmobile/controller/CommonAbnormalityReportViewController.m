//
//  CommonAbnormalityReportViewController.m
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "CommonAbnormalityReportViewController.h"

typedef NS_ENUM(NSUInteger, ReportState) {
    ReportStateNoStart,
    ReportStateStarted,
    ReportStateCompleted
};

@interface CommonAbnormalityReportViewController ()

@property (nonatomic, assign) ReportState reportState;

@end

@implementation CommonAbnormalityReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //网络请求

    self.reportState = ReportStateStarted;
}


-(void)setReportState:(ReportState)reportState
{
    _reportState = reportState;
    switch (reportState) {
        case ReportStateNoStart:
            self.startReportButton.enabled = YES;
            self.endReportButton.enabled = YES;
            self.tableView.allowsSelection = YES;
            self.requireTextView.editable = YES;
            self.explainTextView.editable = YES;
            self.iphoneButton.enabled = YES;
            break;
        case ReportStateStarted:
            self.startReportButton.enabled = NO;
            self.endReportButton.enabled = YES;
            self.tableView.allowsSelection = YES;
            self.requireTextView.editable = YES;
            self.explainTextView.editable = YES;
            self.iphoneButton.enabled = YES;
            break;
        case ReportStateCompleted:
            self.startReportButton.enabled = NO;
            self.endReportButton.enabled = NO;
            self.tableView.allowsSelection = NO;
            self.requireTextView.editable = NO;
            self.explainTextView.editable = NO;
            self.iphoneButton.enabled = NO;
            break;
        default:
            break;
    }
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
