//
//  ChatRightFileTableViewCell.m
//  airmobile
//
//  Created by xuesong on 2017/4/26.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "ChatRightFileTableViewCell.h"

@interface ChatRightFileTableViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImgeViewTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelTrailing;

@end

@implementation ChatRightFileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([DeviceInfoUtil isPlus]) {
        [self adjustPLUS];
    }

}

-(void) adjustPLUS
{
    _headerImgeViewTrailing.constant = px_3(35);
    _nameLabelTrailing.constant = px_3(31);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)fileButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(chatRightFileDownFlile:)]) {
        [_delegate chatRightFileDownFlile:_filePath];
    }
}

-(void)setFilePath:(NSString *)filePath
{
    _filePath = filePath;
    _fileNameLabel.text = [NSString stringWithFormat:@"文件：%@",[[filePath componentsSeparatedByString:@"/"] lastObject]];
}

@end
