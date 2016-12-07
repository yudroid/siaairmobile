//
//  NightShiftRoomTableViewCell.h
//  airmobile
//
//  Created by xuesong on 16/10/19.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DutyModel;

@interface NightShiftRoomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dptLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@property (nonatomic, strong) DutyModel *dutyModel;

@end
