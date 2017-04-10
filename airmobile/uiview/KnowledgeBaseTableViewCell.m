//
//  KnowledgeBaseTableViewCell.m
//  airmobile
//
//  Created by xuesong on 17/3/31.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "KnowledgeBaseTableViewCell.h"
#import "KnowledgeBaseModel.h"

@interface KnowledgeBaseTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *annexLabel;//附件

@end

@implementation KnowledgeBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setKnowledgeBaseModel:(KnowledgeBaseModel *)knowledgeBaseModel
{
    _knowledgeBaseModel = knowledgeBaseModel;
    _titleLabel.text = knowledgeBaseModel.title?:@"";
    _contentLabel.text = knowledgeBaseModel.memo?:@"";
    _userNameLabel.text = knowledgeBaseModel.userName?:@"";
    _timeLabel.text = knowledgeBaseModel.CreateTime?:@"";
    if (knowledgeBaseModel.httpPath.length > 0) {
        _annexLabel.text = @"附件";
    }else{
        _annexLabel.text = @"";
    }
}
@end
