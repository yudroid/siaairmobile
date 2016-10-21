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
#import "NightShiftRoomViewController.h"
#import "AddressBookViewController.h"

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
    self.tabBarView = [[TabBarView alloc] initTabBarWithModel:TabBarBgModelHomePage selectedType:TabBarSelectedTypeHomePage delegate:self];
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
    UIView *userInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 82)];
    [self.view addSubview:userInfo];
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 50, 50)];
    _headImageView.image = [UIImage imageNamed:@"home_title_bg.png"];
    _headImageView.layer.cornerRadius = 25.0;
    _headImageView.layer.masksToBounds = YES;
    [userInfo addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 16, 100, 20)];
    _nameLabel.text = @"寇雪松";
    [userInfo addSubview:_nameLabel];
    
    _dptLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 36, 100, 15)];
    _dptLabel.text = @"研发部";
    _dptLabel.textColor = [UIColor grayColor];
    _dptLabel.font = [UIFont systemFontOfSize:14];
    [userInfo addSubview:_dptLabel];
    
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 51, 100, 15)];
    _phoneLabel.text = @"13210150408";
    _phoneLabel.textColor = [UIColor grayColor];
    _phoneLabel.font = [UIFont systemFontOfSize:13];
    [userInfo addSubview:_phoneLabel];
    
    UIButton *cardButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-16-60, 26, 60, 30)];
    [cardButton setTitle:@"打卡" forState:UIControlStateNormal];
    cardButton.layer.cornerRadius = 5.0;
    cardButton.backgroundColor = [CommonFunction colorFromHex:0XFF00BAEC];
    [cardButton addTarget:self action:@selector(cardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [userInfo addSubview:cardButton];
    
    
}

-(void)initTable
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 154, kScreenWidth, kScreenHeight-154-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"UserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)USERINFO_TABLECELL_IDENTIFIER];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableArray= @[@"用户管理",@"通讯录",@"权限控制",@"值班表",@"版本检测"];
    
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
    return 46;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)USERINFO_TABLECELL_IDENTIFIER];
    cell.nameLabel.text = _tableArray[indexPath.row];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *name = _tableArray[indexPath.row];
    if ([name isEqualToString:@"用户管理"]) {
        UserManagementViewController *userManagementVC = [[UserManagementViewController alloc]initWithNibName:@"UserManagementViewController" bundle:nil];
        [self.navigationController pushViewController:userManagementVC animated:YES];
    }else if ([name isEqualToString:@"值班表"]){
        NightShiftRoomViewController *nightShiftRoomVC = [[NightShiftRoomViewController alloc]initWithNibName:@"NightShiftRoomViewController" bundle:nil];
        [self.navigationController pushViewController:nightShiftRoomVC animated:YES];
    }else if ([name isEqualToString:@"通讯录"]){
        AddressBookViewController *addressBookVC = [[AddressBookViewController alloc]initWithNibName:@"AddressBookViewController" bundle:nil];
        [self.navigationController pushViewController:addressBookVC animated:YES];
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
