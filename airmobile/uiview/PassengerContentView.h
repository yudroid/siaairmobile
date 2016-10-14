//
//  PassengerContentView.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PassengerContentViewDelegate <NSObject>

@optional
/**
 展示旅客小时分布
 */
-(void) showPassengerHourView;

/**
 展示隔离区内旅客小时分布、当前隔离区内各区域旅客分布
 */
-(void) showSecurityPassengerView;

@end

@interface PassengerContentView : UIView

@end
