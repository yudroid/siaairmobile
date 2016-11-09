//
//  ContactPersonTableViewCell.h
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@interface ContactPersonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, assign) Boolean isSelected;
@property (nonatomic, assign) long *userId;
@end
