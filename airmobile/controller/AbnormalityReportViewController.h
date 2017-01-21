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
@class AbnormalModel;


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
@property (nonatomic ,strong)        NSMutableArray *collectionArray;
@property (nonatomic, copy)          NSArray        *imageFilePath;
@property (weak, nonatomic) IBOutlet UITableView    *abnormalityHistoryTableView;
@property (nonatomic, strong) NSString *DispatchType;

@property (nonatomic, strong) BasisInfoDictionaryModel *eventType;//事件类型
@property (nonatomic, strong) BasisInfoDictionaryModel *eventLevel;//事件级别
@property (nonatomic, strong) BasisInfoEventModel *event;//事件


@property (nonatomic, assign) BOOL isSpecial;//是否特殊航班
@property (nonatomic, assign) ReportState reportState;//数据上报的类型  上报  已经开始未结束  已经完成
@property (nonatomic, assign) int abnormalId;

@property (nonatomic, strong) NSString *title;


-(ReportState)judgeReportStateWithAbnormalModel:(AbnormalModel *)abnormalModel;

-(void)setEventAbnormalModel:(AbnormalModel *)abnormalModel;

@end
