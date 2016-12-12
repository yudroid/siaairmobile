//
//  AbnormalityReportViewController.h
//  airmobile
//
//  Created by xuesong on 16/10/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootViewController.h"
@class BasisInfoEventModel;
@class BasisInfoDictionaryModel;

@interface AbnormalityReportViewController : RootViewController
@property (weak, nonatomic) IBOutlet UIButton       *startReportButton;
@property (weak, nonatomic) IBOutlet UIButton       *endReportButton;
@property (weak, nonatomic) IBOutlet UIButton       *iphoneButton;
@property (weak, nonatomic) IBOutlet UITextView     *requireTextView;
@property (weak, nonatomic) IBOutlet UITableView    *tableView;
@property (weak, nonatomic) IBOutlet UITextView     *explainTextView;

@property (nonatomic, copy)          NSArray        *abnormalityHistoryArray;
@property (weak, nonatomic) IBOutlet UITableView    *abnormalityHistoryTableView;
@property (nonatomic, strong) NSString *DispatchType;

@property (nonatomic, strong) BasisInfoDictionaryModel *eventType;
@property (nonatomic, strong) BasisInfoDictionaryModel *eventLevel;
@property (nonatomic, strong) BasisInfoEventModel *event;


@end
