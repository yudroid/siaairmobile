//
//  FlightDetailSafeguardTableViewCell.h
//  airmobile
//
//  Created by xuesong on 16/10/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DispatchModel;

@protocol  FlightDetailSpecialTableViewCellDelegate <NSObject>

-(void)flightDetailSpecialTableViewCellNormalButtonClick:(UIButton *)sender;
-(void)flightDetailSpecialTableViewCellAbnormalButtonClick:(UIButton *)sender;

@end

@interface FlightDetailSpecialTableViewCell : UITableViewCell

@property (nonatomic,weak) id<FlightDetailSpecialTableViewCellDelegate> delegate;
@property (nonatomic, strong) DispatchModel *dispatchModel;
@property (nonatomic, assign) NSInteger indexRow;

@end
