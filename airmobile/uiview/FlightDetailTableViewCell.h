//
//  FlightDetailTableViewCell.h
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SafeguardModel;
@class SpecialModel;

typedef NS_ENUM(NSUInteger, FlightDetailTableViewCellType) {
    FlightDetailTableViewCellTypeTypeDefault,
    FlightDetailTableViewCellTypeTypeFirst,
    FlightDetailTableViewCellTypeTypeLast,
};

@protocol FlightDetailTableViewCellDelegate <NSObject>

-(void)flightDetailTableViewCellUsualButtonClick:(UIButton *)sender;
-(void)flightDetailTableViewCellnormalButtonClick:(UIButton *)sender;

@end

@interface FlightDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *unusualButton;
@property (nonatomic ,assign) FlightDetailTableViewCellType type;
@property (nonatomic, strong)SafeguardModel *safeguardModel;
@property (nonatomic, assign) NSInteger indexRow;
//@property (nonatomic, strong)SpecialModel *specialModel;

@property (weak, nonatomic) id<FlightDetailTableViewCellDelegate> delegate;

@end
