//
//  DelayTimeTableViewCell.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/27.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "DelayTimeTableViewCell.h"

@implementation DelayTimeTableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)identifier delayTime: (RegionDlyTimeModel *)delayTime
{
    self = [super init];
    if(self){
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 41)];
        [self addSubview:contentView];
        [contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(13, 0, kScreenWidth/2-26, 41) text:delayTime.region font:12 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
        UILabel *numLabel = [CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2-13, 41) text:[NSString stringWithFormat:@"%imin,%i架",delayTime.time,delayTime.count] font:12 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B];
        NSMutableAttributedString *numAttributedString = [[NSMutableAttributedString alloc]initWithString:numLabel.text];
        [numAttributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:NSMakeRange( [self location:numLabel.text]-3, 3)];
        [numAttributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:10] range:NSMakeRange(numAttributedString.length-1, 1)];
        numLabel.attributedText = numAttributedString;
        [contentView addSubview:numLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

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
