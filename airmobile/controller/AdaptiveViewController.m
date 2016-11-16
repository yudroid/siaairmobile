//
//  AdaptiveViewController.m
//  airmobile
//
//  Created by xuesong on 16/11/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AdaptiveViewController.h"

@interface AdaptiveViewController ()

@end

@implementation AdaptiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([DeviceInfoUtil isPlus]) {
        [self adjustPLUS];
    }

}

-(void)adjustPLUS
{
    [self subViewAdjustPLUS:self.view];
}


-(void)subViewAdjustPLUS:(UIView *)superView
{
    CGFloat ratio = 414/375.0;
    CGRect frame = superView.frame;
    frame.origin.x = frame.origin.x*ratio;
    frame.origin.y = frame.origin.y;
    frame.size.height = frame.size.height * ratio;
    frame.size.width = frame.size.width * ratio;
    superView.frame =frame;

    for (UIView *view in superView.subviews) {
        [self subViewAdjustPLUS:view];
    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
