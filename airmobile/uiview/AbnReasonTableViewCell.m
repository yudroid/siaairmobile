//
//  AbnReasonTableViewCell.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AbnReasonTableViewCell.h"

@implementation AbnReasonTableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)identifier abnReason: (AbnReasonModel *)abnReason
{
    self = [super init];
    if(self){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 41)];
        [self addSubview:contentView];
        [contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(13, 0, kScreenWidth/2-13, 41) text:abnReason.reason font:12 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF000000]];

        UILabel *numLabel = [CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2-13, 41) text:[NSString stringWithFormat:@"%i架次,%i%%",(int)abnReason.count,(int)(abnReason.percent*100)] font:12 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B];

        NSInteger location = [self location:numLabel.text];
        NSMutableAttributedString *numAttributedString = [[NSMutableAttributedString alloc]initWithString:numLabel.text];
        [numAttributedString addAttribute:NSForegroundColorAttributeName value:[CommonFunction colorFromHex:0xFFFF7c36] range:NSMakeRange(0, location)];
        [numAttributedString addAttribute:NSForegroundColorAttributeName value:[CommonFunction colorFromHex:0xFFF17b9e8] range:NSMakeRange(location+1, numAttributedString.length-location-1)];
        numLabel.attributedText = numAttributedString;
        [contentView addSubview:numLabel];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//查找，的位置
-(NSInteger)location:(NSString *)string
{
    NSRange range;
    range = [string rangeOfString:@","];
    if (range.location!=NSNotFound) {
        return range.location;
    }else{
        return 0;
    }
}

@end
