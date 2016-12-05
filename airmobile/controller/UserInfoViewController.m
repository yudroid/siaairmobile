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



static const NSString *USERINFO_TABLECELL_IDENTIFIER = @"USERINFO_TABLECELL_IDENTIFIER";

@interface UserInfoViewController ()<TabBarViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headImageView ;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dptLabel;
@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, copy) NSArray *tableArray;

@end

@implementation UserInfoViewController

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
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"我的"];
}
-(void) initUserInfoView
{
    UIView *userInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, 82)];
    userInfo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:userInfo];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 16, 50, 50)];
    _headImageView.image = [UIImage imageNamed:@"home_title_bg.png"];
    _headImageView.layer.cornerRadius = 25.0;
    _headImageView.layer.masksToBounds = YES;
    [userInfo addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 16, 100, 20)];
    _nameLabel.textColor = [CommonFunction colorFromHex:0XFF1b1b1b];
    _nameLabel.font = [UIFont fontWithName:@"PingFang SC" size:18];
    _nameLabel.text = @"寇雪松";
    [userInfo addSubview:_nameLabel];
    
    _dptLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 36, 100, 15)];
    _dptLabel.text = @"研发部";
    _dptLabel.textColor = [CommonFunction colorFromHex:0XFF9d9d9d];
    _dptLabel.font = [UIFont fontWithName:@"PingFang SC" size:13];
    [userInfo addSubview:_dptLabel];


    UIImageView *phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(74, 53, 6, 12)];
    phoneImageView.image = [UIImage imageNamed:@"MyIphone"];
    [userInfo addSubview:phoneImageView];

    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(82, 51, 100, 15)];
    _phoneLabel.text = @"13210150408";
    _phoneLabel.textColor = [CommonFunction colorFromHex:0XFF9d9d9d];
    _phoneLabel.font = [UIFont fontWithName:@"PingFang SC" size:13];
    [userInfo addSubview:_phoneLabel];
    
    UIButton *cardButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-16-60, 26, 65, 31)];
    [cardButton setTitle:@"打卡" forState:UIControlStateNormal];
    cardButton.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:17];
    cardButton.layer.cornerRadius = 5.0;
    [cardButton setBackgroundImage:[UIImage imageNamed:@"PlayCard"] forState:UIControlStateNormal];
    [cardButton addTarget:self action:@selector(cardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [userInfo addSubview:cardButton];

}

-(void)initTable
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 157, kScreenWidth, kScreenHeight-157-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"UserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)USERINFO_TABLECELL_IDENTIFIER];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableArray= @[@{@"name":@"用户管理",@"image":@"UserManager"},
                   @{@"name":@"消息过滤",@"image":@"AccessControl"},
                   @{@"name":@"版本检测",@"image":@"VersionCheck"},
                   @{@"name":@"更新基础数据",@"image":@"RefreshData"}];
    
    [self.view addSubview:_tableView];
}


-(void)cardButtonClick:(UIButton *)sender
{
    
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
        [self showAnimationTitle:@"正在进行版本检测"];

    }else if ([name isEqualToString:@"更新基础数据"]){
#if __IPHONE_OS_VERSION_MAX_ALLOWED == __IPHONE_8_3
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
#else
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要更新基础数据吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //清除消息
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
                MessageViewController *messagepage = [[MessageViewController alloc] init];
                [self.navigationController pushViewController:messagepage animated:NO];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
