//
//  UIControl+SelfViewController.m
//  airmobile
//
//  Created by xuesong on 17/1/19.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "UIControl+SelfViewController.h"

@implementation UIControl (SelfViewController)

// 获取视图所在的 viewcontroller
-(UIViewController *)rootViewController
{
    for (UIView *nextView = self.superview; nextView; nextView = nextView.superview) {
        UIResponder *responder = [nextView nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

@end
