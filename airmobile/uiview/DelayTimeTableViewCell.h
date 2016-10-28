//
//  DelayTimeTableViewCell.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/27.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionDlyTimeModel.h"

@interface DelayTimeTableViewCell : UITableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)identifier delayTime: (RegionDlyTimeModel *)delayTime;

@end
