//
//  PsnSafetyContentViewTableViewCell.h
//  airmobile
//
//  Created by xuesong on 16/12/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class  FlightHourModel;
@interface PsnSafetyContentViewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (nonatomic, strong) NSDictionary *content;

@end
