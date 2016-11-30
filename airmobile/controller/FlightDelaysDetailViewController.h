//
//  EventRemindViewController.h
//  airmobile
//
//  Created by xuesong on 16/11/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootViewController.h"

@interface FlightDelaysDetailViewController : RootViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic ,copy) NSString *contentText;

@end
