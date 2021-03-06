//
//  TenDayTableViewCell.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RatioTableViewCell.h"

@implementation RatioTableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)   style
              reuseIdentifier: (NSString *)             identifier
                        ratio: (ReleasedRatioModel *)   ratio
{
    self = [super init];
    if(self){
        [self.contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(px2(32),
                                                                              0,
                                                                              kScreenWidth/2-px2(32),
                                                                              viewHeight(self.contentView))
                                                              text:ratio.time
                                                              font:18
                                                     textAlignment:(NSTextAlignmentLeft)
                                                      colorFromHex:0xFF000000]];

        [self.contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2,
                                                                              0,
                                                                              kScreenWidth/2-px2(32),
                                                                              viewHeight(self.contentView))
                                                              text:[NSString stringWithFormat:@"%.1f%%",(float)(ratio.ratio*100)]
                                                              font:18
                                                     textAlignment:(NSTextAlignmentRight)
                                                      colorFromHex:0xFF000000]];

        UIView *lineView            = [[UIView alloc]initWithFrame:CGRectMake(px2(32),
                                                                              viewHeight(self)-0.5,
                                                                              kScreenWidth-2*px2(32),
                                                                              0.5 )];
        lineView.backgroundColor    = [UIColor grayColor];
        lineView.alpha              = 0.5;
        [self.contentView addSubview:lineView];
    }
    return self;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)identifier
                   thisRatio:(ReleasedRatioModel *)ratio1
               lastthisRatio:(ReleasedRatioModel *)ratio2
{
    self = [super init];
    if(self){
        [self.contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(px2(32),
                                                                              0,
                                                                              kScreenWidth/2-px2(32),
                                                                              viewHeight(self.contentView))
                                                              text:ratio1.time
                                                              font:18
                                                     textAlignment:(NSTextAlignmentLeft)
                                                      colorFromHex:0xFF000000]];

        [self.contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth-(kScreenWidth-px2(32))/4-px2(32),
                                                                              0,
                                                                              (kScreenWidth-px2(32))/4,
                                                                              viewHeight(self.contentView))
                                                              text:[NSString stringWithFormat:@"%@%.1f%%",(float)(ratio1.ratio-ratio2.ratio)>0?@"+":@"",(float)(ratio1.ratio-ratio2.ratio)*100]
                                                              font:17
                                                     textAlignment:(NSTextAlignmentRight)
                                                      colorFromHex:0xFF000000]];

        [self.contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2,
                                                                              0,
                                                                              (kScreenWidth-px2(32))/4,
                                                                              viewHeight(self.contentView))
                                                              text:[NSString stringWithFormat:@"%.1f%%",(float)(ratio1.ratio*100)]
                                                              font:18
                                                     textAlignment:(NSTextAlignmentRight)
                                                      colorFromHex:0xFF000000]];

        UIView *lineView            = [[UIView alloc]initWithFrame:CGRectMake(px2(32),
                                                                              viewHeight(self)-0.5,
                                                                              kScreenWidth-2*px2(32),
                                                                              0.5 )];
        lineView.backgroundColor    = [UIColor grayColor];
        lineView.alpha              = 0.5;
        [self.contentView addSubview:lineView];
    }
    return self;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
