//
//  UIViewController+Reminder.m
//  DynamicSChool
//
//  Created by 小屁孩 on 15/8/23.
//  Copyright (c) 2015年 XS. All rights reserved.
//

static const NSInteger  noFindViewTag = 1000;

#import "UIViewController+Reminder.h"
#import "YDWaveLoadingView.h"

@implementation UIViewController (Reminder)

-(void)showAnimationTitle:(NSString *)title
{
    double  delayTime = 1.0;
    dispatch_time_t popTime =  dispatch_time(DISPATCH_TIME_NOW, delayTime*NSEC_PER_SEC);
#if __IPHONE_OS_VERSION_MAX_ALLOWEDD == __IPHONE_8_3
    __block UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:title?:@"提示" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        alert = nil;
    });
#else 
    __block UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:title?:@"提示" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
        alert = nil;
    });

#endif

}


-(void)showNetWorkingNoFindView
{
    UIView *nofindView = [self.view viewWithTag:noFindViewTag];
    if (nofindView ) {
        return;
    }
    UIView *view = [[UIView alloc]initWithFrame:self.view.frame];
    view.tag = noFindViewTag;
    CGSize superSize = self.view.frame.size;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((superSize.width-200)/2, (superSize.height-300)/2, 200, 300)];
    imageView.image = [UIImage imageNamed:@"netWorkingNoFind"];
    [self.view addSubview:imageView];
}

-(void)hideNetWorkingNoFindView
{
    UIView *view = [self.view viewWithTag:noFindViewTag];
    [view removeFromSuperview];
}

- (void)starNetWorking
{
    [self starNetWorkingWithY:0];
}


- (void)starNetWorkingWithY:(CGFloat)y
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIView *activityBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, y, size.width, size.height-y)];
    activityBackgroundView.backgroundColor = [UIColor grayColor];
    activityBackgroundView.alpha = 0;
    activityBackgroundView.tag = 554;
    [self.view addSubview:activityBackgroundView];

    YDWaveLoadingView *loadingView = [[YDWaveLoadingView alloc]initWithFrame:CGRectMake((size.width-115)/2, (size.height-50)/2, 115, 50)];
    loadingView.tag = 99;
    [activityBackgroundView addSubview:loadingView];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ loadingView startLoading];
    });

    [UIView animateWithDuration:0.618 animations:^{
        activityBackgroundView.alpha = 0.8;
    }];
}

-(void)stopNetWorking
{
    [UIView animateWithDuration:0.618 animations:^{
        [self.view viewWithTag:554].alpha = 0;
        [self.view viewWithTag:555].alpha = 0;
    }];
    [[self.view viewWithTag:554] removeFromSuperview];
    [[self.view viewWithTag:555] removeFromSuperview];
    [[self.view viewWithTag:556] removeFromSuperview];
    [[self.view viewWithTag:99] removeFromSuperview];
}


-(void)h5PageLoading
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIView *activityBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    activityBackgroundView.backgroundColor = [UIColor grayColor];
    activityBackgroundView.alpha = 0;
    activityBackgroundView.tag = 554;
    [self.view addSubview:activityBackgroundView];
    [UIView animateWithDuration:0.618 animations:^{
        activityBackgroundView.alpha = 0.618;
    }];

}

-(UIView *)starNetWorkingWithString:(NSString *)string Y:(CGFloat)y
{
    CGSize size = [UIScreen mainScreen].bounds.size;

    //view
    UIView *activityBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, y, size.width, size.height-y)];
    activityBackgroundView.backgroundColor = [UIColor grayColor];
    activityBackgroundView.alpha = 0;
    activityBackgroundView.tag = 554;
    [self.view addSubview:activityBackgroundView];

    //activity
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((size.width-50)/2, (size.height-50)/2, 50, 50)];
    activity.tag = 555;
    activity.alpha = 0;
    [self.view addSubview:activity];

    //label
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, size.height/2+25, size.width, 50)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15.0];
    label.text = string;
    label.alpha = 0;
    label.tag = 556;
    [self.view addSubview:label];

    [activity startAnimating];
    [UIView animateWithDuration:0.618 animations:^{
        activityBackgroundView.alpha = 0.8;
        activity.alpha = 1;
        label.alpha = 1;
    }];
    return activityBackgroundView;
}


- (void)starNetWorkingWithString:(NSString *)string
{
    [self starNetWorkingWithString:string Y:0];
}


-(void)updateNetWorkingWithString:(NSString *)string
{
    UILabel *title = [self.view viewWithTag:556 ];
    title.text = string;
}


-(__kindof UIViewController *)storyboardWithstoryboardID:(NSString *)storyboardID
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:storyboardID];
}

-(UIViewController *)storyboardWithTemplateStoryboardID:(NSString *)storyboardID
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Template" bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:storyboardID];
}



@end
