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
#import "NSString+Size.h"

@interface AbnormalityReportHistoryTableViewCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelHeight;

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
    NSDictionary * dic = [[PersistenceUtils findBasisInfoEventWithEventId:(int)abnormalModel.event] lastObject];
    BasisInfoEventModel *model = [[BasisInfoEventModel alloc]initWithDictionary:dic];
    _nameLabel.text = model.event;
    CGSize size = [model.event sizeWithWidth:kScreenWidth - 32 font:[UIFont fontWithName:@"PingFang SC" size:15]];
    _nameLabelHeight.constant = size.height;
//    size = [model.content sizeWithWidth:kScreenWidth - 32 font:[UIFont fontWithName:@"PingFang SC" size:12]];
//    _contentLabelHeight.constant = size.height;
    _contentLabel.text = abnormalModel.memo;
}

@end
