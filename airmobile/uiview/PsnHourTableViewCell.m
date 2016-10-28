//
//  PsnHourTableViewCell.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/27.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "PsnHourTableViewCell.h"

@implementation PsnHourTableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)identifier flightHour: (FlightHourModel *)flightHour
{
    self = [super init];
    if(self){
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(0, 0, kScreenWidth/2-20, 25) text:flightHour.hour font:20 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
        
        int arrCount = flightHour.before?flightHour.arrCount:flightHour.planArrCount;
        int depCount = flightHour.before?flightHour.depCount:flightHour.planDepCount;
        [self addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2-40, 25) text:[NSString stringWithFormat:@"进%i,出%i",arrCount,depCount] font:20 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
