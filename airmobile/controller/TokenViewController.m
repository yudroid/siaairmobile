//
//  TokenViewController.m
//  airmobile
//
//  Created by xuesong on 2017/11/18.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "TokenViewController.h"

@interface TokenViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TokenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化标题
    [self titleViewInit];
    // Do any additional setup after loading the view from its nib.
}

//titleView订制
- (void)titleViewInit{
    [self titleViewInitWithHight:64];
    [self titleViewAddTitleText:self.title];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddBackBtn];
    //[self titleViewAddRefreshBtn];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _textView.text =  [defaults objectForKey:@"token"];
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
