//
//  ChatRightImageTableViewCell.h
//  airmobile
//
//  Created by xuesong on 2017/4/26.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  ChatRightImageTableViewCellDelegate<NSObject>

-(void) chatRightImageClick:(UIImage *)image;

@end


@interface ChatRightImageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@property (nonatomic, strong) NSString *imageBase64;

@property (weak, nonatomic) id<ChatRightImageTableViewCellDelegate> delegate;

@end
