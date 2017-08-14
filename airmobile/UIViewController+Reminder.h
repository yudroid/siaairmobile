//
//  UIViewController+Reminder.h
//  DynamicSChool
//
//  Created by 小屁孩 on 15/8/23.
//  Copyright (c) 2015年 XS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Reminder)

-(void)showAnimationTitle:(NSString *)title;

- (void)starNetWorking;
- (void)starNetWorkingWithY:(CGFloat)y;

-(void)stopNetWorking;

- (void)starNetWorkingWithString:(NSString *)string;
-(UIView *)starNetWorkingWithString:(NSString *)string Y:(CGFloat)y;
-(void)updateNetWorkingWithString:(NSString *)string;
/**
 *  添加网络请求无内容视图
 */
-(void)showNetWorkingNoFindView;

/**
 *  隐藏网络请求无内容视图
 */
-(void)hideNetWorkingNoFindView;

/**
 *  通过storyboard ID  从Main.storyboard中获取ViewController
 *
 *  @param storyboardID storyboard 中的 ID标识
 *
 *  @return 返回获取的ViewController
 */
-(UIViewController *)storyboardWithstoryboardID:(NSString *)storyboardID;


/**
 *  通过storyboard ID  从Template.storyboard中获取ViewController
 *
 *  @param storyboardID storyboard 中的 ID标识
 *
 *  @return 返回获取的ViewController
 */
-(UIViewController *)storyboardWithTemplateStoryboardID:(NSString *)storyboardID;
@end
