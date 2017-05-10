//
//  ChatLeftFileTableViewCell.m
//  airmobile
//
//  Created by xuesong on 2017/4/26.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "ChatLeftFileTableViewCell.h"

@interface ChatLeftFileTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageViewTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelTrailing;

@end

@implementation ChatLeftFileTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    if ([DeviceInfoUtil isPlus]) {
        [self adjustPLUS];
    }
}

-(void)adjustPLUS
{
    _headerImageViewTrailing.constant = px_3(35);
    _headerImageViewWidth.constant = px_3(125);
    _headerImageViewHeight.constant = px_3(125);
    _nameLabelTrailing.constant = px_3(15);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)fileButtonClick:(id)sender {

    if ([_delegate respondsToSelector:@selector(chatLeftFileDownFlile:)]) {
        [_delegate chatLeftFileDownFlile:_filePath];
    }
}

-(void)setFilePath:(NSString *)filePath
{
    _filePath = filePath;
    _fileNameLabel.text = [NSString stringWithFormat:@"文件：%@",[[filePath componentsSeparatedByString:@"/"] lastObject]];
}

@end
