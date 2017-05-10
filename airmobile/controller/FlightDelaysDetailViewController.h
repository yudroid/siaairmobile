//
//  EventRemindViewController.h
//  airmobile
//
//  Created by xuesong on 16/11/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootViewController.h"
@class SysMessageModel;

@interface FlightDelaysDetailViewController : RootViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic ,copy) NSString *contentText;

@property (nonatomic ,strong) SysMessageModel *sysMessageModel;

@property (nonatomic, assign) NSInteger type;//0 航班事件消息 1 重要消息

@end
