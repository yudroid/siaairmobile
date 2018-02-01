//
//  NormalReportView.h
//  airmobile
//
//  Created by xuesong on 2018/1/19.
//  Copyright © 2018年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NormalReportViewDelegate <NSObject>

-(void)normalReportViewDidSelectDate:(NSDate *)date reports:(NSArray *)reportsArray ;

@end

@interface NormalReportView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) id<NormalReportViewDelegate> delegate;

@end
