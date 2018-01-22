//
//  FlightDetailOrderTableViewCell.h
//  airmobile
//
//  Created by xuesong on 2018/1/19.
//  Copyright © 2018年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  FlightDetailOrderTableViewCellDelegate <NSObject>

-(void)flightDetailOrderTableViewCellNormalButtonClick:(UIButton *)sender;
-(void)flightDetailOrderTableViewCellAbnormalButtonClick:(UIButton *)sender;

@end

@interface FlightDetailOrderTableViewCell : UITableViewCell

@property (nonatomic,weak) id<FlightDetailOrderTableViewCellDelegate> delegate;

@end
