//
//  ChatLeftImageTableViewCell.h
//  airmobile
//
//  Created by xuesong on 2017/4/26.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  ChatLeftImageTableViewCellDelegate<NSObject>

-(void) chatLeftImageClick:(UIImage *)image;

@end

@interface ChatLeftImageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@property (nonatomic, strong) NSString *imageBase64;

@property (weak, nonatomic) id<ChatLeftImageTableViewCellDelegate> delegate;

@end
