//
//  TenDayTableViewCell.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RatioTableViewCell.h"

@implementation RatioTableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)identifier ratio: (ReleasedRatioModel *)ratio
{
    self = [super init];
    if(self){
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(0, 0, kScreenWidth/2-20, 25) text:ratio.time font:20 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2-40, 25) text:[NSString stringWithFormat:@"%i",(int)(ratio.ratio*100)] font:20 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
