//
//  AbnormalityReportViewController.h
//  airmobile
//
//  Created by xuesong on 16/10/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootViewController.h"

@interface AbnormalityReportViewController : RootViewController
@property (weak, nonatomic) IBOutlet UIButton *startReportButton;
@property (weak, nonatomic) IBOutlet UIButton *endReportButton;
@property (weak, nonatomic) IBOutlet UIButton *iphoneButton;
@property (weak, nonatomic) IBOutlet UITextView *requireTextView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *explainTextView;
@end
