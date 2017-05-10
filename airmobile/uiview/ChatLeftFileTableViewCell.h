//
//  ChatLeftFileTableViewCell.h
//  airmobile
//
//  Created by xuesong on 2017/4/26.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ChatLeftFileTableViewCellDelegate<NSObject>

-(void) chatLeftFileDownFlile:(NSString *)path;

@end

@interface ChatLeftFileTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;

@property (nonatomic, strong) NSString *filePath;

@property (nonatomic, weak) id<ChatLeftFileTableViewCellDelegate> delegate;

@end
