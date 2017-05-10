//
//  ReportTableViewCell.m
//  airmobile
//
//  Created by xuesong on 2017/5/9.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "ReportTableViewCell.h"
#import "KnowledgeBaseModel.h"
#import "FCFileManager.h"
@interface ReportTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *annexLabel;//附件
@property (weak, nonatomic) IBOutlet UIButton *viewButtton;

@end

@implementation ReportTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _viewButtton.layer.cornerRadius = 5.0;
    _viewButtton.layer.borderWidth = 1.0;
    _viewButtton.layer.borderColor = [CommonFunction colorFromHex:0xff0080F2].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setKnowledgeBaseModel:(KnowledgeBaseModel *)knowledgeBaseModel
{
    _knowledgeBaseModel = knowledgeBaseModel;
    _titleLabel.text = knowledgeBaseModel.title?:@"";
    _contentLabel.text = knowledgeBaseModel.typeName?:@" ";
    _userNameLabel.text = knowledgeBaseModel.userName?:@"";
    _timeLabel.text = knowledgeBaseModel.CreateTime?:@"";
    if (knowledgeBaseModel.httpPath.length > 0) {
        _annexLabel.text = @"附件";
    }else{
        _annexLabel.text = @"";
        _viewButtton.hidden = YES;
    }
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [knowledgeBaseModel.httpPath stringByReplacingOccurrencesOfString:@"/" withString:@"--"];
    NSString *path = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"DownFile/%@",fileName]];
    if ([FCFileManager existsItemAtPath:path]) {
        [_viewButtton setTitle:@"查看" forState:UIControlStateNormal];
    }else{
        [_viewButtton setTitle:@"下载" forState:UIControlStateNormal];
    }
}
- (IBAction)viewButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(reportTableViewCellViewButtonClick:)]) {
        [_delegate reportTableViewCellViewButtonClick:sender];
    }
}
-(void)setIndex:(NSInteger)index
{
    _index = index;
    _viewButtton.tag = index;
}

@end
