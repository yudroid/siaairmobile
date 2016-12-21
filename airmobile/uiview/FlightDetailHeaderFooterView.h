//
//  FlightDetailHeaderFooterView.h
//  airmobile
//
//  Created by xuesong on 16/12/21.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlightDetailHeaderFooterViewDelegate  <NSObject>

-(void)flightDetailHeaderFooterView:(UITableViewHeaderFooterView *)view showAndHiddenButton:(UIButton *)sender;

@end

@interface FlightDetailHeaderFooterView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) id<FlightDetailHeaderFooterViewDelegate> delegate;

@end
