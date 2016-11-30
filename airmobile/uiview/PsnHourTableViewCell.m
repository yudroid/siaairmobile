//
//  PsnHourTableViewCell.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/27.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PsnHourTableViewCell.h"

@implementation PsnHourTableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)   style
              reuseIdentifier: (NSString *)             identifier
                   flightHour: (FlightHourModel *)      flightHour
{
    self = [super init];
    if(self){
        [self.contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(20, 0, kScreenWidth/2-20, viewHeight(self.contentView))
                                                              text:flightHour.hour
                                                              font:18
                                                     textAlignment:(NSTextAlignmentLeft)
                                                      colorFromHex:0xFF000000]];
        
        int arrCount = flightHour.before?flightHour.arrCount:flightHour.planArrCount;
        int depCount = flightHour.before?flightHour.depCount:flightHour.planDepCount;

        UILabel *valueLable =[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2,
                                                                      0,
                                                                      kScreenWidth/2-20,
                                                                      viewHeight(self.contentView))
                                                      text:[NSString stringWithFormat:@"进 %i 出 %i",arrCount,depCount]
                                                      font:18
                                             textAlignment:(NSTextAlignmentRight)
                                              colorFromHex:0xFF1B1B1B];
        NSMutableAttributedString *valueAttributedString = [[NSMutableAttributedString alloc]initWithString:valueLable.text];
        [valueAttributedString addAttribute:NSFontAttributeName
                                      value:[UIFont fontWithName:@"PingFangSC-Regular" size:11]
                                      range:[valueLable.text rangeOfString:@"进"]];
        [valueAttributedString addAttribute:NSFontAttributeName
                                      value:[UIFont fontWithName:@"PingFangSC-Regular" size:11]
                                      range:[valueLable.text rangeOfString:@" 出"]];
        valueLable.attributedText = valueAttributedString;
        [self.contentView addSubview:valueLable];

        UIView *lineView            = [[UIView alloc]initWithFrame:CGRectMake(px2(32), viewHeight(self)-0.5, kScreenWidth-2*px2(32), 0.5 )];
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
