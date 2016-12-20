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


typedef NS_ENUM(NSUInteger, ReportState) {
    ReportStateNoStart,
    ReportStateStarted,
    ReportStateCompleted
};

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


@property (nonatomic, assign) BOOL isSpecial;//是否特殊航班

@property (nonatomic, assign) ReportState reportState;
@property (nonatomic, assign) int abnormalId;

@property (nonatomic, strong) NSString *title;

@end
