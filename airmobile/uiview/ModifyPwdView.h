//
//  ModifyPwdView.h
//  PopView
//
//  Created by xuesong on 16/12/4.
//  Copyright © 2016年 xuesong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModifyPwdViewDelegate <NSObject>

@optional
-(void)modifyPwdView:(UIView *)modifyPwdView CancelButtonClick:(UIButton *)sender;
-(void)modifyPwdView:(UIView *)modifyPwdView sureButtonClick:(UIButton *)sender;

@end

@interface ModifyPwdView : UIView
@property (weak, nonatomic) IBOutlet UIButton *backgroundButton;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentCentre;
@property (weak, nonatomic) IBOutlet UITextField *originalLabel;
@property (weak, nonatomic) IBOutlet UITextField *newpwdLabel;

@property (weak, nonatomic) IBOutlet UITextField *confirmPwdLabel;

@property (nonatomic, weak) id<ModifyPwdViewDelegate> delegate;


- (void)createBlurBackgroundWithImage:(UIImage *)backgroundImage tintColor:(UIColor *)tintColor blurRadius:(CGFloat)blurRadius;

- (IBAction)cancelButtonClick:(id)sender;

@end
