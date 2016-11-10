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
#import "UserInfoModel.h"
#import "AppDelegate.h"

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self createLogoView];
    [self createInputView];
    
}

// 创建logo的view
-(void) createLogoView
{
    _bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgView.image = [UIImage imageNamed:@"LoginBackground"];
    _bgView.userInteractionEnabled = YES;
    [self.view addSubview:_bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapClick)];
    [_bgView addGestureRecognizer:tap];
    int width = [DeviceInfoUtil lengthFitIp6andIp5WithLength:374/2];
    int height = [DeviceInfoUtil lengthFitIp6andIp5WithLength:303/2];
    UIImageView *logoImgV = [[UIImageView alloc]
                             initWithFrame:CGRectMake((kScreenWidth-width)/2, 105, width , height)];
    logoImgV.image = [UIImage imageNamed:@"LoginLogo"];
    
    [_bgView addSubview:logoImgV];
    
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
    
    //用户名view
    UIView *AccountView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 257.5)/2, y, 257.5, 40)];
    [_bgView addSubview:AccountView];
    ///背景图片
    UIImageView *AccountViewBackgroundImageView = [[UIImageView alloc]
                                                   initWithFrame:CGRectMake(0, 0, 257.5, 40)];
    AccountViewBackgroundImageView.image = [UIImage imageNamed:@"LoginInputField"];
    [AccountView addSubview:AccountViewBackgroundImageView];
    //前部小图片
    UIImageView *accountFrontImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 18, 16)];
    accountFrontImageView.image = [UIImage imageNamed:@"LoginAccounts"];
    [AccountView addSubview: accountFrontImageView];
    //文本输入框
    _accountTF = [[UITextField alloc]initWithFrame:CGRectMake(44, 0, 200, 40)];
    
    _accountTF.placeholder = @"请输入账号";
    _accountTF.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
    _accountTF.font = [UIFont systemFontOfSize:15];
    [_accountTF setValue:[CommonFunction colorFromHex:0X7FFFFFFF] forKeyPath:@"_placeholderLabel.textColor"];
    [_accountTF setValue:[UIFont boldSystemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    [AccountView addSubview:_accountTF];
    
    y = 339 +40 +21;
    
    if([DeviceInfoUtil IphoneVersions] == 5){
        y -= 70;
    }
    
    //ipad
    if([DeviceInfoUtil IphoneVersions] == 4){
        y -= 85;
    }
    
    //密码view
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 257.5)/2, y, 257.5, 40)];
    [_bgView addSubview:passwordView];
    ///背景图片
    UIImageView *passwordViewBackgroundImageView = [[UIImageView alloc]
                                                    initWithFrame:CGRectMake(0, 0, 257.5, 40)];
    passwordViewBackgroundImageView.image = [UIImage imageNamed:@"LoginInputField"];
    [passwordView addSubview:passwordViewBackgroundImageView];
    //前部小图片
    UIImageView *passwordFrontImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 18, 16)];
    passwordFrontImageView.image = [UIImage imageNamed:@"LoginPassword"];
    [passwordView addSubview: passwordFrontImageView];
    //文本输入框
    _passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(44, 0, 190, 40)];
    _passwordTF.delegate = self;
    _passwordTF.placeholder = @"请输入密码";
    _passwordTF.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
    _passwordTF.font = [UIFont systemFontOfSize:17];
    [_passwordTF setValue:[CommonFunction colorFromHex:0X7FFFFFFF] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordTF setValue:[UIFont boldSystemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    
    
    UIButton *visibleBtn = [[UIButton alloc]initWithFrame:CGRectMake(257.5-15-25, 0, 30, 40)];
    [visibleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [visibleBtn setImage:[UIImage imageNamed:@"LoginVisible"] forState:(UIControlStateNormal)];
    [visibleBtn setImage:[UIImage imageNamed:@"login_icon_invisible"] forState:(UIControlStateSelected)];
    [visibleBtn addTarget:self action:@selector(visibleBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    visibleBtn.selected = YES;
    [_passwordTF setSecureTextEntry:YES];
    [passwordView addSubview:visibleBtn];
    _passwordTF.text= [DefaultHelper getStringForKey:pwdKey];
    [passwordView addSubview:_passwordTF];
    
    _accountTF.text=[DefaultHelper getStringForKey:userKey];
    _passwordTF.text=[DefaultHelper getStringForKey:pwdKey];
    
    y = 339+45+25+45+52;
    
    if([DeviceInfoUtil IphoneVersions] == 5){
        y -= 75;
    }
    
    //ipad
    if([DeviceInfoUtil IphoneVersions] == 4){
        y-=100;
    }
    
    _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - 257.5)/2, y, 257.5, 40)];
    [_loginBtn setImage:[UIImage imageNamed:@"LoginButtonBackground"] forState:(UIControlStateNormal)];
    [_loginBtn setImage:[UIImage imageNamed:@"login_btn"] forState:(UIControlStateSelected)];
    [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:(UIControlEventTouchUpInside)];
    [_bgView addSubview:_loginBtn];
    UILabel *loginLabel = [[UILabel alloc]initWithFrame:_loginBtn.frame];
    loginLabel.textColor = [CommonFunction colorFromHex:0XFF122046];
    loginLabel.text = @"登录";
    loginLabel.font = [UIFont fontWithName:@"PingFang SC" size:18];
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

    [HttpsUtils loginUser:userName pwd:password deviceInfo:deviceInfo success:^(UserInfoModel *user){
        //隐藏忙碌提示
        [ThreadUtils dispatchMain:^{
            _loginBtn.enabled = YES;
            [self.view hideToastActivity];
        }];
        
        /*
         返回 1 登录成功  2 登录失败，用户名\密码为空 3登录失败，用户名或密码输入错误 4 用户被禁用 5已在其他设备登录，登录失败 6 账号已过期 7 MAC地址不匹配
         */
        //调用成功的回调
        switch (user.flag) {
            case 1:
            {
                [HttpsUtils setUserName:userName];
                [HttpsUtils setPassword:password];
                NSString* userKey = @"taocares_userName";
                NSString* pwdKey = @"taocares_pwd";
                //保存用户名和密码
                [DefaultHelper setString:userName forKey:userKey];
                [DefaultHelper setString:password forKey:pwdKey];
                AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                delegate.userInfoModel = user;
                
                [ThreadUtils dispatchMain:^{
                    HomePageViewController *homepage = [[HomePageViewController alloc] init];
                    [self.navigationController pushViewController:homepage animated:YES];
                }];
                BOOL isFirstTime = [StringUtils isNullOrWhiteSpace:[DefaultHelper getStringForKey:@"SIAAIRMOBILE.LOGINFIRSTTIME"]];
                if (isFirstTime) {
                    //绑定MAC地址
                    //[HttpsUtils binding:userName uuid:deviceId];
                }
                break;
            }
            case 2:{
                [ThreadUtils dispatchMain:^{
                    [self toast:@"登录失败，用户名不存在"];
                }];
                break;
            }
                
            case 3:{
                [ThreadUtils dispatchMain:^{
                    [self toast:@"登录失败，密码输入错误"];
                }];
                break;
            }
                
            case 4:{
                [ThreadUtils dispatchMain:^{
                    [self toast:@"用户被禁用"];
                }];
                break;
            }
            case 5:{
                [ThreadUtils dispatchMain:^{
                    [self toast:@"已在别处登录，请注销或联系管理单位"];
                }];
                break;
            }
            case 6:{
                [ThreadUtils dispatchMain:^{
                    [self toast:@"本账号已过期，请联系管理单位"];
                }];
                break;
            }
            case 7:{
                [ThreadUtils dispatchMain:^{
                    [self toast:@"请在绑定设备上登录或联系管理单位"];
                }];
                break;
            }
            default:{
                [ThreadUtils dispatchMain:^{
                    [self toast:@"登录失败"];
                }];
                break;
            }
        }
        
    }failure:^(NSError* error){
        NSLog(@"%@",error);
        [ThreadUtils dispatchMain:^{
            _loginBtn.enabled = YES;
            [self.view hideToastActivity];
            //调用失败的回调
            [self toast:@"服务或网络异常"];
        }];
        return;
    }];
    
}

/**
 textfield编辑时显示键盘
 
 @param sender <#sender description#>
 */
-(void)KeyboardWillShow:(NSNotification *)sender{
    CGRect rect=[[sender.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat height= rect.size.height;
    
    float y = -height+160;
    if(y<0){
        //    UIKeyboardAnimationDurationUserInfoKey//获取键盘升起动画时间
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:[[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue]];
        _bgView.transform=CGAffineTransformMakeTranslation(0, y);
        [UIView commitAnimations];
        
    }
    
    
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
