//
//  ChatLeftTableViewCell.h
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatLeftTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, copy) NSString *contentText;

@end
