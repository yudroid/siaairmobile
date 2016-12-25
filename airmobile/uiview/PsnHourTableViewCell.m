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
                                                              font:15
                                                     textAlignment:(NSTextAlignmentLeft)
                                                      colorFromHex:0xFF000000]];
        
        int arrCount = (int)flightHour.arrCount;
        int depCount = (int)flightHour.depCount;

        NSString *arrString = @"进";
        if (flightHour.hour.integerValue >= [CommonFunction currentHour]) {
            arrString = @"预测进";
        }
        UILabel *valueLable1 =[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2-5,
                                                                      0,
                                                                      kScreenWidth/4,
                                                                      viewHeight(self.contentView))
                                                      text:[NSString stringWithFormat:@"%@ %i",arrString,arrCount]
                                                      font:15
                                             textAlignment:(NSTextAlignmentLeft)
                                              colorFromHex:0xFF1B1B1B];
        NSMutableAttributedString *valueAttributedString1 = [[NSMutableAttributedString alloc]initWithString:valueLable1.text];
        [valueAttributedString1 addAttribute:NSFontAttributeName
                                      value:[UIFont fontWithName:@"PingFangSC-Regular" size:11]
                                      range:[valueLable1.text rangeOfString:arrString]];


//        valueLable1.backgroundColor = [UIColor redColor];
        valueLable1.attributedText = valueAttributedString1;
        [self.contentView addSubview:valueLable1];


        NSString *depString = @"出";
        if (flightHour.hour.integerValue >= [CommonFunction currentHour]) {
            depString = @"预测出";
        }
        UILabel *valueLable2 =[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/4*3-10,
                                                                       0,
                                                                       kScreenWidth/4,
                                                                       viewHeight(self.contentView))
                                                       text:[NSString stringWithFormat:@"%@ %i",depString,depCount]
                                                       font:15
                                              textAlignment:(NSTextAlignmentLeft)
                                               colorFromHex:0xFF1B1B1B];
        NSMutableAttributedString *valueAttributedString2 = [[NSMutableAttributedString alloc]initWithString:valueLable2.text];
        [valueAttributedString2 addAttribute:NSFontAttributeName
                                      value:[UIFont fontWithName:@"PingFangSC-Regular" size:11]
                                      range:[valueLable2.text rangeOfString:depString]];
        valueLable2.attributedText = valueAttributedString2;

        [self.contentView addSubview:valueLable2];


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
