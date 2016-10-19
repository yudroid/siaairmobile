//
//  FlightFilterTableViewCell.h
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FlightProcessModel;

@interface FlightFilterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *carftModelLabel;//机型

@property (nonatomic, strong) FlightProcessModel *flightProcessModlel;

@end
