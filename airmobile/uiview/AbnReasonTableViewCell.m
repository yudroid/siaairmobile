//
//  AbnReasonTableViewCell.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AbnReasonTableViewCell.h"

@implementation AbnReasonTableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)   style
              reuseIdentifier: (NSString *)             identifier
                    abnReason: (AbnReasonModel *)       abnReason
                          sum:(CGFloat)sum
{
    self = [super init];
    if(self){

        [self.contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(px2(32),
                                                                              0,
                                                                              kScreenWidth/2-px2(32),
                                                                              viewHeight(self.contentView))
                                                              text:abnReason.reason
                                                              font:px_px_2_3(24, 40)
                                                     textAlignment:(NSTextAlignmentLeft)
                                                      colorFromHex:0xFF000000]];

        UILabel *numLabel = [CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2,
                                                                     0,
                                                                     kScreenWidth/2-px2(32),
                                                                     viewHeight(self.contentView))
                                                     text:[NSString stringWithFormat:@"%.1f%%",abnReason.count/@(sum==0?1:sum).floatValue*100]
                                                     font:px_px_2_3(24, 40)
                                            textAlignment:(NSTextAlignmentRight)
                                             colorFromHex:0xFF1B1B1B];

//        NSInteger location = [self location:numLabel.text];
//        NSMutableAttributedString *numAttributedString = [[NSMutableAttributedString alloc]initWithString:numLabel.text];
//        [numAttributedString addAttribute:NSForegroundColorAttributeName value:[CommonFunction colorFromHex:0xFFFF7c36]
//                                    range:NSMakeRange(0, location)];
//        [numAttributedString addAttribute:NSForegroundColorAttributeName value:[CommonFunction colorFromHex:0xFF17b9e8]
//                                    range:NSMakeRange(location+1, numAttributedString.length-location-1)];
//        numLabel.attributedText = numAttributedString;
        [self.contentView addSubview:numLabel];

        UIView *lineView        = [[UIView alloc]initWithFrame:CGRectMake(px2(32), viewHeight(self)-0.5, kScreenWidth-2*px2(32), 0.5 )];
        lineView.backgroundColor= [UIColor grayColor];
        lineView.alpha          = 0.5;
        [self.contentView addSubview:lineView];

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
