//
//  LoginViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "LoginViewController.h"
#import "UIView+Toast.h"
#import "StringUtils.h"
#import <AdSupport/ASIdentifierManager.h>
#import "HttpsUtils+Business.h"
#import "ThreadUtils.h"
#import "HomePageViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
    
@end

@implementation LoginViewController{
    UIImageView *_bgView;
    
    UITextField *_accountTF;
    UITextField *_passwordTF;
    UIButton *_loginBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [super preferredStatusBarStyle];
    
    // 增加键盘显示隐藏事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillShowNotification object:nil];
    
    [self createLogoView];
    [self createInputView];

}

// 创建logo的view
-(void) createLogoView
{
    _bgView = [[UIImageView alloc]initWithFrame:self.view.frame];
    _bgView.image = [UIImage imageNamed:@"login_bg"];
    _bgView.userInteractionEnabled = YES;
    [self.view addSubview:_bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [_bgView addGestureRecognizer:tap];
    int width = 214;
    int height = 101;
    int x = (kScreenWidth - 214)/2;
    if([DeviceInfoUtil IphoneVersions] == 5){
        NSLog(@"------------iphone5-----------------");
        width *= [DeviceInfoUtil ip6Facto5];
        height *= [DeviceInfoUtil ip6Facto5];
        x += 15;
    }
    UIImageView *logoImgV = [[UIImageView alloc]initWithFrame:CGRectMake(x, 95, width , height)];
    //logoImgV.image = [UIImage imageNamed:@"login_logo"];
    [_bgView addSubview:logoImgV];
    int y = 95+101;
    
    if ([DeviceInfoUtil IphoneVersions] == 5) {
        y -= 10;
    }
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, 60)];
    nameLabel.text = @"";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:20];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:nameLabel];

}

- (void)tapClick{
    [_accountTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
}

// 创建输入框view
-(void) createInputView
{
    
    int y = 339;
    if([DeviceInfoUtil IphoneVersions] == 5){
        y -= 70;
        
    }
    
    //ipad
    if([DeviceInfoUtil IphoneVersions] == 4){
        y -= 85;
    }
    
    
    
    NSString* userKey = @"taocares_userName";
    NSString* pwdKey = @"taocares_pwd";
    
    
    _accountTF = [[UITextField alloc]initWithFrame:CGRectMake((kScreenWidth - 291)/2, y, 291, 45)];
    _accountTF.delegate = self;
    _accountTF.placeholder = @"请输入账号";
    _accountTF.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
    _accountTF.font = [UIFont systemFontOfSize:17];
    [_accountTF setValue:[CommonFunction colorFromHex:0X7FFFFFFF] forKeyPath:@"_placeholderLabel.textColor"];
    [_accountTF setValue:[UIFont boldSystemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    _accountTF.background = [UIImage imageNamed:@"login_input_field"];
    _accountTF.leftViewMode = UITextFieldViewModeAlways;
    UIButton *placeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [placeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [placeBtn setImage:[UIImage imageNamed:@"login_accounts"] forState:(UIControlStateNormal)];
    [_accountTF setLeftView:placeBtn];
    _accountTF.text = [DefaultHelper getStringForKey:userKey];
    [_bgView addSubview:_accountTF];
    
    y = 339 +45 +25;
    
    if([DeviceInfoUtil IphoneVersions] == 5){
        y -= 70;
    }
    
    //ipad
    if([DeviceInfoUtil IphoneVersions] == 4){
        y -= 85;
    }
    
    _passwordTF = [[UITextField alloc]initWithFrame:CGRectMake((kScreenWidth - 291)/2, y, 291, 45)];
    _passwordTF.delegate = self;
    _passwordTF.placeholder = @"请输入密码";
    _passwordTF.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
    _passwordTF.font = [UIFont systemFontOfSize:17];
    [_passwordTF setValue:[CommonFunction colorFromHex:0X7FFFFFFF] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordTF setValue:[UIFont boldSystemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    _passwordTF.background = [UIImage imageNamed:@"login_input_field"];
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    UIButton *passPlaceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [passPlaceBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [passPlaceBtn setImage:[UIImage imageNamed:@"login_icon_lock"] forState:(UIControlStateNormal)];
    [_passwordTF setLeftView:passPlaceBtn];
    _passwordTF.rightViewMode = UITextFieldViewModeAlways;
    UIButton *visibleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 50)];
    [visibleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [visibleBtn setImage:[UIImage imageNamed:@"login_visible"] forState:(UIControlStateNormal)];
    [visibleBtn setImage:[UIImage imageNamed:@"login_icon_invisible"] forState:(UIControlStateSelected)];
    [visibleBtn addTarget:self action:@selector(visibleBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    visibleBtn.selected = YES;
    [_passwordTF setSecureTextEntry:YES];
    [_passwordTF setRightView:visibleBtn];
    _passwordTF.text= [DefaultHelper getStringForKey:pwdKey];
    [_bgView addSubview:_passwordTF];
    
    _accountTF.text=@"admin";
    _passwordTF.text=@"123";
    
    y = 339+45+25+45+60;
    
    if([DeviceInfoUtil IphoneVersions] == 5){
        y -= 75;
    }
    
    //ipad
    if([DeviceInfoUtil IphoneVersions] == 4){
        y-=100;
    }
    
    _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - 291)/2, y, 291, 45)];
    [_loginBtn setImage:[UIImage imageNamed:@"login_btn_pre"] forState:(UIControlStateNormal)];
    [_loginBtn setImage:[UIImage imageNamed:@"login_btn"] forState:(UIControlStateSelected)];
    [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_bgView addSubview:_loginBtn];
    UILabel *loginLabel = [[UILabel alloc]initWithFrame:_loginBtn.frame];
    loginLabel.textColor = [CommonFunction colorFromHex:0XFF122046];
    loginLabel.text = @"登录";
    loginLabel.font = [UIFont systemFontOfSize:21];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:loginLabel];
}

/**
 *  密码是否可见回调
 *
 *  @param button <#button description#>
 */
- (void)visibleBtnClick:(UIButton *)button{
    if (button.selected) {
        button.selected = NO;
        [_passwordTF setSecureTextEntry:NO];
    }else{
        button.selected = YES;
        [_passwordTF setSecureTextEntry:YES];
    }
}

/**
 *  登录按钮事件
 */
- (void)loginClick
{
    NSString* userName = _accountTF.text;
    NSString* password = _passwordTF.text;
    NSLog(@"%s  %@  %@",__func__,userName,password);
    
    
    
    if ([StringUtils isNullOrWhiteSpace:userName]) {
        [self toast:@"用户名不能为空"];
        return;
    }
    
    if ([StringUtils isNullOrWhiteSpace:password]) {
        [self toast:@"密码不能为空"];
        return;
    }
    
    _loginBtn.enabled = NO;
    [self.view makeToastActivity:CSToastPositionCenter];
    
    NSString* deviceId = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    NSString *deviceInfo = [NSString stringWithFormat:@"%@:%@:iOS:%@",deviceId,deviceId,userName];
    HomePageViewController *homepage = [[HomePageViewController alloc] init];
    [self.navigationController pushViewController:homepage animated:YES];
    
//    [HttpsUtils loginUser:userName pwd:password deviceInfo:deviceInfo success:^(id responseObj){
//        //[HttpUtils loginUser:userName pwd:password success:^(id responseObj){
//        //隐藏忙碌提示
//        [ThreadUtils dispatchMain:^{
//            _loginBtn.enabled = YES;
//            [self.view hideToastActivity];
//        }];
//        
//        /*
//         返回 1 登录成功  2 登录失败，用户名不存在 3登录失败，密码输入错误 4 用户被禁用 5已在其他设备登录，登录失败 6 账号已过期 7 MAC地址不匹配
//         */
//        //调用成功的回调
//        if ([StringUtils equals:responseObj To:@"1" ByIgnoreCase:YES]) {
//            //LWGMainViewController* mainController = [[LWGMainViewController alloc] init];
//            //[self presentViewController:mainController animated:YES completion:nil];
//            //返回
//            //[self dismissViewControllerAnimated:YES completion:nil];
//            [HttpsUtils setUserName:userName];
//            [HttpsUtils setPassword:password];
//            NSString* userKey = @"taocares_userName";
//            NSString* pwdKey = @"taocares_pwd";
//            [DefaultHelper setString:userName forKey:userKey];
//            [DefaultHelper setString:password forKey:pwdKey];
//            [ThreadUtils dispatchMain:^{
//                HomePageViewController *homepage = [[HomePageViewController alloc] init];
//                [self.navigationController pushViewController:homepage animated:YES];
//            }];
//            
//            //            //保存用户名和密码
//            //            NSDictionary* dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userName,userNameKey,pwd,pwdKey,isAutoLogin?@"YES":@"NO",autoLoginKey, nil];
//            //
//            //            NSString* destFile = [[PersistenceUtils getDirectoryOfDocuments] stringByAppendingPathComponent:autoLoginFile];
//            //            [PersistenceUtils writeDictionary:dictionary toFile:destFile];
//            BOOL isFirstTime = [StringUtils isNullOrWhiteSpace:[DefaultHelper getStringForKey:@"Goose.LOGINFIRSTTIME"]];
//            if (isFirstTime) {
//                //绑定MAC地址
//                [HttpsUtils binding:userName uuid:deviceId];
//            }
//            return;
//        }
//        else{
//            
//            if([StringUtils equals:responseObj To:@"2" ByIgnoreCase:YES]){
//                [ThreadUtils dispatchMain:^{
//                    [self toast:@"登录失败，用户名不存在"];
//                }];
//            }
//            else if([StringUtils equals:responseObj To:@"3" ByIgnoreCase:YES]){
//                [ThreadUtils dispatchMain:^{
//                    [self toast:@"登录失败，密码输入错误"];
//                }];
//            }
//            else if([StringUtils equals:responseObj To:@"4" ByIgnoreCase:YES]){
//                [ThreadUtils dispatchMain:^{
//                    [self toast:@"用户被禁用"];
//                }];
//            }
//            else if([StringUtils equals:responseObj To:@"5" ByIgnoreCase:YES]){
//                [ThreadUtils dispatchMain:^{
//                    [self toast:@"已在别处登录，请注销或联系管理单位"];
//                }];
//            }else if([StringUtils equals:responseObj To:@"6" ByIgnoreCase:YES]){
//                [ThreadUtils dispatchMain:^{
//                    [self toast:@"本账号已过期，请联系管理单位"];
//                }];
//            }else if([StringUtils equals:responseObj To:@"7" ByIgnoreCase:YES]){
//                [ThreadUtils dispatchMain:^{
//                    [self toast:@"请在绑定设备上登录或联系管理单位"];
//                }];
//            }
//            else{
//                [ThreadUtils dispatchMain:^{
//                    [self toast:@"登录失败"];
//                }];
//            }
//            return;
//        }
//    }failure:^(NSError* error){
//        [ThreadUtils dispatchMain:^{
//            _loginBtn.enabled = YES;
//            [self.view hideToastActivity];
//            //调用失败的回调
//            [self toast:@"服务或网络异常"];
//        }];
//        return;
//    }];
    
    
    
    //    HomePageViewController *homepage = [[HomePageViewController alloc] init];
    //    [self.navigationController pushViewController:homepage animated:YES];
}

/**
 textfield编辑时显示键盘

 @param sender <#sender description#>
 */
-(void)KeyboardWillShow:(NSNotification *)sender{
    CGRect rect=[[sender.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat height= rect.size.height;
    
    //    UIKeyboardAnimationDurationUserInfoKey//获取键盘升起动画时间
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:[[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue]];
    _bgView.transform=CGAffineTransformMakeTranslation(0, -height+160);
    [UIView commitAnimations];
}


/**
 退出编辑时隐藏键盘

 @param sender <#sender description#>
 */
-(void)KeyboardWillHide:(NSNotification *)sender{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:[[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue]];
    _bgView.transform=CGAffineTransformIdentity;//重置状态
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  tost
 *
 *  @param str <#str description#>
 */
-(void) toast:(NSString*) str{
    [self.view makeToast:str duration:0.6 position:CSToastPositionCenter];
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
