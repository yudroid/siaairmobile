//
//  UserInfoViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightViewController.h"
#import "HomePageViewController.h"
#import "MessageViewController.h"
#import "FunctionViewController.h"
#import "UserInfoViewController.h"
#import "UserInfoTableViewCell.h"
#import "UserManagementViewController.h"
#import "UploadPhotoViewController.h"
#import "LoadingView.h"
#import "MessageFilterViewController.h"
#import "UIViewController+Reminder.h"
#import "HttpsUtils+Business.h"
#import "AppDelegate.h"
#import "PersistenceUtils+Business.h"
#import "LoginViewController.h"
#import <FlyImage.h>
#import "SingleMessageViewController.h"
#import "VersionModel.h"
#import "FunctionShowViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "YDWaveLoadingView.h"



static const NSString *USERINFO_TABLECELL_IDENTIFIER = @"USERINFO_TABLECELL_IDENTIFIER";

@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headImageView ;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dptLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, copy)   NSArray *tableArray;

@end

@implementation UserInfoViewController
{
    UIView      *userInfo;
    UIButton    *cardButton;
    UIButton    *logoffButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];
    [self initUserInfoView];
    [self initTable];
    //TabBer自定义
    self.tabBarView = [[TabBarView alloc] initTabBarWithModel:TabBarBgModelHomePage selectedType:TabBarSelectedTypeUserInfo delegate:self];
    [self.view insertSubview:self.tabBarView aboveSubview:self.view];
    
    
    self.view.backgroundColor =  [CommonFunction colorFromHex:0XFFEBEBF1];
    // Do any additional setup after loading the view.

    logoffButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-70)/2,
                                                             viewBotton(_tableView)+5,
                                                             70,
                                                             30)];

    [logoffButton setTitle:@"注销" forState:UIControlStateNormal];
    [logoffButton addTarget:self action:@selector(logoffButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [logoffButton setBackgroundImage:[UIImage imageNamed:@"AbnormalityRequestStarButton"] forState:UIControlStateNormal];
    logoffButton.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:18];
    [self.view addSubview:logoffButton];

    self.navigationController.navigationBar.hidden = YES;
    self.fd_prefersNavigationBarHidden = YES;


}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"设置"];
}
-(void) initUserInfoView
{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    userInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, 82)];
    userInfo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:userInfo];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 16, 50, 50)];
    _headImageView.image = [UIImage imageNamed:@"home_title_bg.png"];
    _headImageView.layer.cornerRadius = 25.0;
    _headImageView.layer.masksToBounds = YES;

    [userInfo addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 16, 150, 20)];
    _nameLabel.textColor = [CommonFunction colorFromHex:0XFF1b1b1b];
    _nameLabel.font = [UIFont fontWithName:@"PingFang SC" size:18];
    _nameLabel.text = appdelegate.userInfoModel.name;
    [userInfo addSubview:_nameLabel];
    
    _dptLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 36, 200, 15)];
    _dptLabel.text = appdelegate.userInfoModel.deptName;
    _dptLabel.textColor = [CommonFunction colorFromHex:0XFF9d9d9d];
    _dptLabel.font = [UIFont fontWithName:@"PingFang SC" size:13];
    [userInfo addSubview:_dptLabel];


    UIImageView *phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(74, 53, 6, 12)];
    phoneImageView.image = [UIImage imageNamed:@"MyIphone"];
    [userInfo addSubview:phoneImageView];

    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(82, 51, 100, 15)];
    _phoneLabel.text = appdelegate.userInfoModel.phone;
    _phoneLabel.textColor = [CommonFunction colorFromHex:0XFF9d9d9d];
    _phoneLabel.font = [UIFont fontWithName:@"PingFang SC" size:13];
    [userInfo addSubview:_phoneLabel];
    
    cardButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-16-60, 26, 72, 31)];
    [cardButton setTitle:@"签到" forState:UIControlStateNormal];
    cardButton.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:17];
    cardButton.layer.cornerRadius = 5.0;
    [cardButton setBackgroundImage:[UIImage imageNamed:@"PlayCard"] forState:UIControlStateNormal];
    [cardButton addTarget:self action:@selector(cardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [userInfo addSubview:cardButton];


    if ([appdelegate.userInfoModel.signStatus isEqualToString:@"未签到"]) {
        [cardButton setTitle:@"签到" forState:UIControlStateNormal];
    }else if([appdelegate.userInfoModel.signStatus isEqualToString:@"已签到"]){
        [cardButton setTitle:@"签退" forState:UIControlStateNormal];
    }else if([appdelegate.userInfoModel.signStatus isEqualToString:@"已签退"]){
        [cardButton setTitle:@"完成" forState:UIControlStateNormal];
    }
    cardButton.enabled = YES;

}

-(void)initTable
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 157, kScreenWidth, kScreenHeight-157-49-40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"UserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)USERINFO_TABLECELL_IDENTIFIER];
    _tableView.tableFooterView = [[UIView alloc]init];

    NSMutableArray *mutableArray = [NSMutableArray array];
//    [mutableArray addObject:@{@"name":@"用户管理",@"image":@"UserManager"}];
    if ([CommonFunction hasFunction:SET_USERMANAGE]) {
        [mutableArray addObject:@{@"name":@"用户管理",@"image":@"UserManager"}];
    }
    if ([CommonFunction hasFunction:SET_MSGFILTER]) {
        [mutableArray addObject:@{@"name":@"消息过滤",@"image":@"AccessControl"}];
    }
    if ([CommonFunction hasFunction:SET_VERSION]) {
        [mutableArray addObject:@{@"name":@"版本检测",@"image":@"VersionCheck"}];
    }
    if ([CommonFunction hasFunction:SET_SYNCBASE]) {
        [mutableArray addObject:@{@"name":@"更新基础数据",@"image":@"RefreshData"}];
    }
    if ([CommonFunction hasFunction:SET_FUNCTION]) {
        [mutableArray addObject:@{@"name":@"功能说明",@"image":@"RefreshData"}];
    }
    _tableArray = [mutableArray copy];
    
    [self.view addSubview:_tableView];
}

-(void)viewWillAppear:(BOOL)animated
{

    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [_headImageView setIconURL:[HttpsUtils imageDownloadURLWithString:appdelegate.userInfoModel.imagePath]];
    if (_headImageView.image == nil) {
        _headImageView.image = [UIImage imageNamed:@"MessageHeader"];
    }

}

-(void)cardButtonClick:(UIButton *)sender
{
    NSString *title = sender.titleLabel.text;
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if ([title isEqualToString:@"签到"]) {
        [self cardButtonAddLoadingView];
        [HttpsUtils signIn:(int)appdelegate.userInfoModel.id
                   success:^(NSNumber *response) {
                       appdelegate.userInfoModel.signStatus = @"已签到";
                        [cardButton setTitle:@"签退" forState:UIControlStateNormal];
                       [self cardButtonRemoveLoadingView];
                   }
                   failure:^(NSError *error) {
                       [self showAnimationTitle:@"签到失败"];
                       [self cardButtonRemoveLoadingView];
                   }];

    }else if ([title isEqualToString:@"签退"]){
        [self cardButtonAddLoadingView];
        [HttpsUtils signOut:(int)appdelegate.userInfoModel.id
                    success:^(NSNumber *response) {
                        appdelegate.userInfoModel.signStatus = @"已签退";
                        [cardButton setTitle:@"完成" forState:UIControlStateNormal];
                        [self cardButtonRemoveLoadingView];
                    }
                    failure:^(NSError *error) {
                        [self showAnimationTitle:@"签退失败"];
                        [self cardButtonRemoveLoadingView];
                    }];
    }
    
}
-(void)logoffButtonClick:(UIButton *)sender
{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self starNetWorking];
    [HttpsUtils logOut:(int)appdelegate.userInfoModel.id
               success:^(NSNumber *response) {
                   [self stopNetWorking];
                   LoginViewController *homepage = [[LoginViewController alloc] init];
                   UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:homepage];
                   nv.navigationBarHidden= YES;
                   appdelegate.window.rootViewController = nv;
                   [appdelegate.window makeKeyWindow];
               }
               failure:^(NSError *error) {
                   [self stopNetWorking];
                   [self showAnimationTitle:@"注销失败"];
               }];
}

-(void)cardButtonAddLoadingView
{
    YDWaveLoadingView *loadingView = [[YDWaveLoadingView alloc]initWithFrame:cardButton.frame];;
    loadingView.tag = 99;
    cardButton.hidden = YES;
    [userInfo addSubview:loadingView];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ loadingView startLoading];
    });
}
-(void)cardButtonRemoveLoadingView
{
    UIView *loadingView = [userInfo viewWithTag:99];
    [loadingView removeFromSuperview];
    cardButton.hidden = NO;
}

#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *rowDic = _tableArray[indexPath.row];
    NSString *name = [rowDic objectForKey:@"name"];
    NSString *imageString = [rowDic objectForKey:@"image"];
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)USERINFO_TABLECELL_IDENTIFIER];
    cell.nameLabel.text =name;
    cell.iconImageView.image = [UIImage imageNamed:imageString];
    if ([name isEqualToString:@"版本检测"]) {

        NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        cell.secondLabel.text = [NSString stringWithFormat:@"%@(%@)",@"当前版本",app_Version];
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

        if(appdelegate.userInfoModel.version.floatValue >app_Version.floatValue)
            cell.versionImageView.hidden = NO;
    }
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSDictionary *rowDic = _tableArray[indexPath.row];
    NSString *name = [rowDic objectForKey:@"name"];
//    UIImage *image = [rowDic objectForKey:@"image"];
    if ([name isEqualToString:@"用户管理"]) {
        UserManagementViewController *userManagementVC = [[UserManagementViewController alloc]initWithNibName:@"UserManagementViewController" bundle:nil];
        [self.navigationController pushViewController:userManagementVC animated:YES];
    }else if ([name isEqualToString:@"消息过滤"]){
        MessageFilterViewController *messageFilterVC = [[MessageFilterViewController alloc]initWithNibName:@"MessageFilterViewController" bundle:nil];
        [self.navigationController pushViewController:messageFilterVC animated:YES];

    }else if ([name isEqualToString:@"版本检测"]){
//        [self showAnimationTitle:@"正在进行版本检测"];
        [HttpsUtils versionCheckSuccess:^(id response) {
            NSArray * data = [response objectForKey:@"data"];
            VersionModel *version = [[VersionModel alloc]initWithDictionary:[data lastObject]];
            NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            if (version.appVersion.floatValue<=app_Version.floatValue) {
                [self showAnimationTitle:@"已经为最新版本"];
            }else{
#if __IPHONE_OS_VERSION_MAX_ALLOWED == __IPHONE_8_3
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"发现新版本"
                                                                   message:@"是否更新"
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                         otherButtonTitles:@"确定", nil];
                alertView.tag = 1;
                [alertView show];
#else
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发现新版本"
                                                                                         message:@"是否更新？"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                                    style:UIAlertActionStyleCancel handler:nil]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action){
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",@"itms-services://?action=download-manifest&url=https://www.pgyer.com/app/plist/",version.appKey,@"&password=",@"siaaoc"]]];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        } failure:^(id error) {
            [self showAnimationTitle:@"版本检测失败"];
        }];
        return;
#endif
    }else if ([name isEqualToString:@"更新基础数据"]){
#if __IPHONE_OS_VERSION_MAX_ALLOWED == __IPHONE_8_3
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@""
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"确定", nil];
        alertView.tag = 1;
        [alertView show];
#else
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                                 message:@"确定要更新基础数据吗？"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action){
            [HttpsUtils loadEventsSuccess:^(id response) {
                [self showAnimationTitle:@"更新成功"];

                for(NSDictionary *dic in response){
                    [PersistenceUtils insertBasisInfoEventWithDictionary:dic];
                }
            } failure:^(NSError *error) {
                [self showAnimationTitle:@"更新失败"];
            }];
            [HttpsUtils loadDictDatasSuccess:^(id response) {
                [self showAnimationTitle:@"更新成功"];
                for(NSDictionary *dic in response){
                    [PersistenceUtils insertBasisInfoDictionaryWithDictionary:dic];
                }
            } failure:^(NSError *error) {
                [self showAnimationTitle:@"更新失败"];
            }];
            [HttpsUtils loadAllUsers];
        }]];

        [self presentViewController:alertController animated:YES completion:nil];
#endif
    }else if([name isEqualToString:@"功能说明"]){
        FunctionShowViewController *funcitonShowVC = [[FunctionShowViewController alloc]init];
        [self.navigationController pushViewController:funcitonShowVC animated:YES];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1 && buttonIndex == 1) {
        [HttpsUtils loadEventsSuccess:^(id response) {
            [self showAnimationTitle:@"更新成功"];
        } failure:^(NSError *error) {
            [self showAnimationTitle:@"更新失败"];
        }];
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
