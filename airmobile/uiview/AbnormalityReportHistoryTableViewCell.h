//
//  AbnormalityReportHistoryTableViewCell.h
//  airmobile
//
//  Created by xuesong on 16/10/29.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  AbnormalModel;

@interface AbnormalityReportHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, strong) AbnormalModel *abnormalModel;


@end
