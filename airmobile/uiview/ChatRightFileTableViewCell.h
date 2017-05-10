//
//  ChatRightFileTableViewCell.h
//  airmobile
//
//  Created by xuesong on 2017/4/26.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ChatRightFileTableViewCellDelegate<NSObject>

-(void) chatRightFileDownFlile:(NSString *)path;

@end

@interface ChatRightFileTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;
@property (nonatomic, weak) id<ChatRightFileTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSString *filePath;

@end
