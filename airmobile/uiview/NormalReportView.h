//
//  NormalReportView.h
//  airmobile
//
//  Created by xuesong on 2018/1/19.
//  Copyright © 2018年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimePickerViewDelegate <NSObject>

-(void)timePickerViewDidSelectDate:(NSDate *)date;

@end

@interface NormalReportView : UIView

@property (nonatomic, strong) id<TimePickerViewDelegate> delegate;

@end
