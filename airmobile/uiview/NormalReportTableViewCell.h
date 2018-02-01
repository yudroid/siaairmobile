//
//  NormalReportTableViewCell.h
//  airmobile
//
//  Created by xuesong on 2018/1/23.
//  Copyright © 2018年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalReportTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIImageView *tagImageView;

@property (nonatomic, assign) BOOL isSelected;

@end
