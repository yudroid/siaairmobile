//
//  PsnHourTableViewCell.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/27.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightHourModel.h"

@interface PsnHourTableViewCell : UITableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)identifier flightHour: (FlightHourModel *)flightHour;
@end
