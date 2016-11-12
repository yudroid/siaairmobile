//
//  ContactPersonTableViewHeaderView.h
//  airmobile
//
//  Created by xuesong on 16/11/11.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContactPersonTableViewHeaderViewDelegate <NSObject>

-(void)contactPersonTableViewHeaderViewClick:(UIView *)view;

@end

@interface ContactPersonTableViewHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, assign) BOOL open;
@property (nonatomic, weak) id<ContactPersonTableViewHeaderViewDelegate> delegate;



@end
