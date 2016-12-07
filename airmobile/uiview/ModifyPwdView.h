//
//  ModifyPwdView.h
//  PopView
//
//  Created by xuesong on 16/12/4.
//  Copyright © 2016年 xuesong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyPwdView : UIView
@property (weak, nonatomic) IBOutlet UIButton *backgroundButton;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentCentre;


- (void)createBlurBackgroundWithImage:(UIImage *)backgroundImage tintColor:(UIColor *)tintColor blurRadius:(CGFloat)blurRadius;


@end
