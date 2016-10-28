//
//  TimePickerView.h
//  airmobile
//
//  Created by xuesong on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimePickerViewDelegate <NSObject>

@optional
-(void)timePickerViewDidEnsure:(NSDate *)date;
-(void)timePickerViewDidCancel;

@end

@interface TimePickerView : UIView

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerView;
@property (weak, nonatomic) id<TimePickerViewDelegate> delegate;

@end
