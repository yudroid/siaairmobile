//
//  KnowledgeBaseContentTableViewCell.m
//  airmobile
//
//  Created by xuesong on 17/3/31.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "KnowledgeBaseContentTableViewCell.h"
#import <FCFileManager.h>


@interface KnowledgeBaseContentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *functionButton;
@end

@implementation KnowledgeBaseContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _functionButton.layer.cornerRadius = 5.0;
    _functionButton.layer.borderColor = [CommonFunction colorFromHex:0xFF0080F2].CGColor;
    _functionButton.layer.borderWidth = 1.0;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFilePath:(NSString *)filePath
{
    if (!filePath) {
        return;
    }
    _filePath = filePath;
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"DownFile/%@",filePath]];
    if ([FCFileManager existsItemAtPath:path]) {
        [_functionButton setTitle:@"查看" forState:UIControlStateNormal];
    }else{
        [_functionButton setTitle:@"下载" forState:UIControlStateNormal];
    }
}

- (IBAction)functionButtonClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(functionButtonClick:)]) {
        sender.tag = self.tag;
        [_delegate functionButtonClick:sender];
    }

}




@end
