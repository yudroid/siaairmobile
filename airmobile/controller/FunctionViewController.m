//
//  FunctionViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FunctionViewController.h"
#import "FlightViewController.h"
#import "HomePageViewController.h"
#import "MessageViewController.h"
#import "UserInfoViewController.h"
#import "UserInfoTableViewCell.h"
#import "NightShiftRoomViewController.h"
#import "AddressBookViewController.h"

static const NSString *FUNCTION_TABLECELL_IDENTIFIER = @"FUNCTION_TABLECELL_IDENTIFIER";

@interface FunctionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
    @property (nonatomic,strong) NSArray *tableArray;

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTitleView];
    [self initTable];
    //TabBer自定义
    self.tabBarView = [[TabBarView alloc] initTabBarWithModel:TabBarBgModelHomePage selectedType:TabBarSelectedTypeFunction delegate:self];
    [self.view insertSubview:self.tabBarView aboveSubview:self.view];
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"功能"];
}
-(void)initTable
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49)
                                             style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"UserInfoTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)FUNCTION_TABLECELL_IDENTIFIER];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableArray= @[@{@"name":@"通讯录",@"image":@"AddressBook"},
                   @{@"name":@"值班表",@"image":@"WatchBill"}];

    [self.view addSubview:_tableView];
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
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FUNCTION_TABLECELL_IDENTIFIER];
    NSDictionary *rowDic = _tableArray[indexPath.row];
    NSString *name = [rowDic objectForKey:@"name"];
    NSString *imageString = [rowDic objectForKey:@"image"];
    cell.nameLabel.text = name;
    cell.iconImageView.image = [UIImage imageNamed:imageString];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *rowDic = _tableArray[indexPath.row];
    NSString *name = [rowDic objectForKey:@"name"];

    if ([name isEqualToString:@"值班表"]){
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
        case TabBarSelectedTypeMessage:
        {
            MessageViewController *messagepage = [[MessageViewController alloc] init];
            [self.navigationController pushViewController:messagepage animated:NO];
            break;
        }
        case TabBarSelectedTypeFlight:
        {
            FlightViewController *flight = [[FlightViewController alloc] init];
            [self.navigationController pushViewController:flight animated:NO];
            break;
        }
        case TabBarSelectedTypeUserInfo:
        {
            UserInfoViewController *userInfo = [[UserInfoViewController alloc] init];
            [self.navigationController pushViewController:userInfo animated:NO];
            break;
        }
        default:
            break;
    }
}

@end
