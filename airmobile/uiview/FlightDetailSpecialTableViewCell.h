//
//  FlightDetailSafeguardTableViewCell.h
//  airmobile
//
//  Created by xuesong on 16/10/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpecialModel;

@protocol  FlightDetailSpecialTableViewCellDelegate <NSObject>

-(void)flightDetailSpecialTableViewCellNormalButtonClick:(UIButton *)sender;
-(void)flightDetailSpecialTableViewCellAbnormalButtonClick:(UIButton *)sender;

@end

@interface FlightDetailSpecialTableViewCell : UITableViewCell

@property (nonatomic,weak) id<FlightDetailSpecialTableViewCellDelegate> delegate;
@property (nonatomic, strong) SpecialModel *specialModel;
@property (nonatomic, assign) NSInteger indexRow;

@end
