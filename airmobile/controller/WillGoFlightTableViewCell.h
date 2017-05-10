//
//  WillGoFlightTableViewCell.h
//  airmobile
//
//  Created by xuesong on 2017/4/18.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WillGoFlightModel;

@interface WillGoFlightTableViewCell : UITableViewCell

@property (nonatomic, strong) WillGoFlightModel *willGoFlightModel;
@property (nonatomic, assign) NSInteger index;

@end
