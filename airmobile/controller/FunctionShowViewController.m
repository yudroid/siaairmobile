//
//  FunctionShowViewController.m
//  airmobile
//
//  Created by xuesong on 16/12/29.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FunctionShowViewController.h"

@interface FunctionShowViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidth;

@end

@implementation FunctionShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageViewWidth.constant = kScreenWidth;

    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"功能说明"];
    [self titleViewAddBackBtn];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
