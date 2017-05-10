//
//  ReportTableViewCell.h
//  airmobile
//
//  Created by xuesong on 2017/5/9.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KnowledgeBaseModel;

@protocol ReportTableViewCellDelegate <NSObject>

-(void)reportTableViewCellViewButtonClick:(UIButton *)sender;

@end

@interface ReportTableViewCell : UITableViewCell

@property (nonatomic, strong) KnowledgeBaseModel *knowledgeBaseModel;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<ReportTableViewCellDelegate> delegate;

@end
