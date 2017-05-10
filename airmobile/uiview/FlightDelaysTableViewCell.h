//
//  FlightDelaysTableViewCell.h
//  airmobile
//
//  Created by xuesong on 16/11/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightDelaysTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (nonatomic, assign) BOOL read;

@property (nonatomic, strong) NSString *status;//0 为航班事件消息  1为重要消息

@end
