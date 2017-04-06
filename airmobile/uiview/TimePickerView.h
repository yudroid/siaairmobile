//
//  TimePickerView.h
//  airmobile
//
//  Created by xuesong on 17/3/29.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimePickerViewDelegate <NSObject>

-(void)timePickerViewDidSelectDate:(NSDate *)date;

@end

@interface TimePickerView : UIView

@property (nonatomic, strong) id<TimePickerViewDelegate> delegate;

@end
