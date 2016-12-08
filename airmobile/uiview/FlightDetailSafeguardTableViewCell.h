//
//  FlightDetailSafeguardTableViewCell.h
//  airmobile
//
//  Created by xuesong on 16/10/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpecialModel;

@protocol  FlightDetailSafeguardTableViewCellDelegate <NSObject>

-(void)flightDetailSafeguardTableViewCellNormalButtonClick:(UIButton *)sender;
-(void)flightDetailSafeguardTableViewCellAbnormalButtonClick:(UIButton *)sender;

@end

@interface FlightDetailSafeguardTableViewCell : UITableViewCell

@property (nonatomic,weak) id<FlightDetailSafeguardTableViewCellDelegate> delegate;
@property (nonatomic, strong) SpecialModel *specialModel;
@property (nonatomic, assign) NSInteger indexRow;

@end
