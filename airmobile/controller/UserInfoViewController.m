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



static const NSString *USERINFO_TABLECELL_IDENTIFIER = @"USERINFO_TABLECELL_IDENTIFIER";

@interface UserInfoViewController ()<TabBarViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headImageView ;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dptLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, copy) NSArray *tableArray;

@end

@implementation UserInfoViewController
{

    UIButton *cardButton;
    UIButton *logoffButton;
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
    UIView *userInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, 82)];
    userInfo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:userInfo];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 16, 50, 50)];
    _headImageView.image = [UIImage imageNamed:@"home_title_bg.png"];
    _headImageView.layer.cornerRadius = 25.0;
    _headImageView.layer.masksToBounds = YES;
    [_headImageView setIconURL:[HttpsUtils imageDownloadURLWithString:@"1481161300838/2345.png"]];
    [userInfo addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 16, 150, 20)];
    _nameLabel.textColor = [CommonFunction colorFromHex:0XFF1b1b1b];
    _nameLabel.font = [UIFont fontWithName:@"PingFang SC" size:18];
    _nameLabel.text = appdelegate.userInfoModel.name;
    [userInfo addSubview:_nameLabel];
    
    _dptLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 36, 100, 15)];
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
    
    cardButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-16-60, 26, 65, 31)];
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
    [mutableArray addObject:@{@"name":@"用户管理",@"image":@"UserManager"}];
    if ([CommonFunction hasFunction:SET_MSGFILTER]) {
        [mutableArray addObject:@{@"name":@"消息过滤",@"image":@"AccessControl"}];
    }
    if ([CommonFunction hasFunction:SET_VERSION]) {
        [mutableArray addObject:@{@"name":@"版本检测",@"image":@"VersionCheck"}];
    }
    if ([CommonFunction hasFunction:SET_SYNCBASE]) {
        [mutableArray addObject:@{@"name":@"更新基础数据",@"image":@"RefreshData"}];
    }
    _tableArray = [mutableArray copy];
    
    [self.view addSubview:_tableView];
}


-(void)cardButtonClick:(UIButton *)sender
{
    NSString *title = sender.titleLabel.text;
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([title isEqualToString:@"签到"]) {
        [HttpsUtils signIn:(int)appdelegate.userInfoModel.id
                   success:^(NSNumber *response) {
                       appdelegate.userInfoModel.signStatus = @"已签到";
                        [cardButton setTitle:@"签退" forState:UIControlStateNormal];
                   }
                   failure:^(NSError *error) {
                       [self showAnimationTitle:@"签到失败"];
                   }];

    }else if ([title isEqualToString:@"签退"]){
        [HttpsUtils signOut:(int)appdelegate.userInfoModel.id
                    success:^(NSNumber *response) {
                        appdelegate.userInfoModel.signStatus = @"已签退";
                        [cardButton setTitle:@"完成" forState:UIControlStateNormal];
                    }
                    failure:^(NSError *error) {
                        [self showAnimationTitle:@"签退失败"];
                    }];
    }
    
}
-(void)logoffButtonClick:(UIButton *)sender
{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [HttpsUtils logOut:(int)appdelegate.userInfoModel.id
               success:^(NSNumber *response) {
                   LoginViewController *homepage = [[LoginViewController alloc] init];
                   UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:homepage];
                   nv.navigationBarHidden= YES;
                   appdelegate.window.rootViewController = nv;
                   [appdelegate.window makeKeyWindow];
               }
               failure:^(NSError *error) {
//                   [self showAnimationTitle:@"注销失败"];
                   LoginViewController *homepage = [[LoginViewController alloc] init];
                   UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:homepage];
                   nv.navigationBarHidden= YES;
                   appdelegate.window.rootViewController = nv;
                   [appdelegate.window makeKeyWindow];
               }];

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

#if __IPHONE_OS_VERSION_MAX_ALLOWED == __IPHONE_8_3
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"发现新版本" message:@"是否更新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1;
        [alertView show];
#else
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发现新版本" message:@"是否更新？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=https://www.pgyer.com/app/plist/acf6d58c177698e4c0117cdf44b282c5&password=123456"]];

        }]];

        [self presentViewController:alertController animated:YES completion:nil];
#endif
    }else if ([name isEqualToString:@"更新基础数据"]){
#if __IPHONE_OS_VERSION_MAX_ALLOWED == __IPHONE_8_3
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1;
        [alertView show];
#else
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要更新基础数据吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
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
        

    }
    
}
#pragma mark - 切换底部主功能页面
-(void)selectWithType:(TabBarSelectedType)type
{
    switch (type) {
        case TabBarSelectedTypeHomePage:
        {
            HomePageViewController *homepage = [[HomePageViewController alloc] init];
            [self.navigationController pushViewController:homepage animated:NO];
            break;
        }
        case TabBarSelectedTypeFlight:
        {
            FlightViewController *flightpage = [[FlightViewController alloc] init];
            [self.navigationController pushViewController:flightpage animated:NO];
            break;
        }
        case TabBarSelectedTypeMessage:
        {
            [self showMessageViewController];
            break;
        }
        case TabBarSelectedTypeFunction:
        {
            FunctionViewController *function = [[FunctionViewController alloc] init];
            [self.navigationController pushViewController:function animated:NO];
            break;
        }
        default:
        break;
    }
}

-(void)showMessageViewController
{
    if([CommonFunction hasFunction:MSG_WORNING] && ![CommonFunction hasFunction:MSG_FLIGHT] && ![CommonFunction hasFunction:MSG_DIALOG]){
        SingleMessageViewController *message = [[SingleMessageViewController alloc] init];
        message.type = @"COMMAND";
        [self.navigationController pushViewController:message animated:NO];
    }else if(![CommonFunction hasFunction:MSG_WORNING] && [CommonFunction hasFunction:MSG_FLIGHT] && ![CommonFunction hasFunction:MSG_DIALOG]){
        SingleMessageViewController *message = [[SingleMessageViewController alloc] init];
        message.type = @"FLIGHT";
        [self.navigationController pushViewController:message animated:NO];
    }else{
        MessageViewController *message = [[MessageViewController alloc] init];
        [self.navigationController pushViewController:message animated:NO];
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
