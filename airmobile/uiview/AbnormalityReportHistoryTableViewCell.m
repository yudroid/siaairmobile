//
//  AbnormalityReportHistoryTableViewCell.m
//  airmobile
//
//  Created by xuesong on 16/10/29.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AbnormalityReportHistoryTableViewCell.h"
#import "AbnormalModel.h"
#import "PersistenceUtils+Business.h"
#import "BasisInfoEventModel.h"

@interface AbnormalityReportHistoryTableViewCell ()


@end

@implementation AbnormalityReportHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setAbnormalModel:(AbnormalModel *)abnormalModel
{
    _abnormalModel = abnormalModel;
    _starLabel.text = [NSString stringWithFormat:@"开始:%@",abnormalModel.startTime];
    _endLabel.text =  [NSString stringWithFormat:@"结束:%@",abnormalModel.endTime];

    NSDictionary *dic = [[PersistenceUtils findBasisInfoEventWithEventId:(int)abnormalModel.id] lastObject];

    BasisInfoEventModel *eventModel = [[BasisInfoEventModel alloc]initWithDictionary:dic];
    _nameLabel.text = eventModel.event;
    if (abnormalModel.endTime && ![abnormalModel.endTime isEqualToString:@""]) {
        _statusLabel.text = @"上报完成";
    }else{
        _statusLabel.text = @"上报开始";
    }

}

@end
