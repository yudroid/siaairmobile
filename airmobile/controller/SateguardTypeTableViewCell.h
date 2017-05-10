//
//  SateguardTypeTableViewCell.h
//  airmobile
//
//  Created by xuesong on 17/4/11.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SateguardTypeModel;

@interface SateguardTypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (nonatomic, strong) SateguardTypeModel *satefuardTypeModel;
@end
