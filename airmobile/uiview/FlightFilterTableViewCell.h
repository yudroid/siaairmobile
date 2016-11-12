//
//  FlightFilterTableViewCell.h
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightModel.h"

@interface FlightFilterTableViewCell : UITableViewCell


-(void) refreshData:(FlightModel *)flight;

@end
