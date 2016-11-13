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
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(13, 0, kScreenWidth/2-13, viewHeight(self)) text:ratio.time font:18 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF000000]];

        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2-13, viewHeight(self)) text:[NSString stringWithFormat:@"%i",(int)(ratio.ratio*100)] font:18 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF000000]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
