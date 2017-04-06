//
//  KnowledgeBaseContentTableViewCell.h
//  airmobile
//
//  Created by xuesong on 17/3/31.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KnowledgeBaseContentTableViewCellDelegate <NSObject>

-(void)functionButtonClick:(UIButton *)sender;

@end

@interface KnowledgeBaseContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, weak) id<KnowledgeBaseContentTableViewCellDelegate> delegate;

@end
