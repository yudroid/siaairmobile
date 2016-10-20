//
//  FlightDetailTableViewCell.h
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlightDetailTableViewCellDelegate <NSObject>

-(void)flightDetailTableViewCellUsualButtonClick;

@end

@interface FlightDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *finishStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *unusualButton;

@property (weak, nonatomic) id<FlightDetailTableViewCellDelegate> delegate;

@end
