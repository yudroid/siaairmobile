//
//  FlightViewController.m
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
#import "FlightFilterView.h"
#import "FlightFilterTableViewCell.h"
#import "FlightDetailViewController.h"

static const CGFloat FLIGHTFILTERVIEW_HEIGHT = 365;
static  NSString * TABLEVIEWCELL_IDETIFIER = @"FLIGHTFILTER_TABLEVIEWCELL_IDETIFIER";

@interface FlightViewController ()<TabBarViewDelegate,UITableViewDelegate,UITableViewDataSource>



@end

@implementation FlightViewController
{
    FlightFilterView *filterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitleView];

    //TabBer自定义
    self.tabBarView = [[TabBarView alloc] initTabBarWithModel:TabBarBgModelHomePage selectedType:TabBarSelectedTypeFlight delegate:self];
    [self.view insertSubview:self.tabBarView aboveSubview:self.view];
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49)];
    tableView.delegate =self;
    tableView.dataSource =self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    //添加过滤条件View
    filterView = [[[NSBundle mainBundle] loadNibNamed:@"FlightFilterView" owner:nil options:nil] lastObject];
    filterView.frame = CGRectMake(0, 64, kScreenWidth, FLIGHTFILTERVIEW_HEIGHT);
    filterView.alpha = 0;
    
    [self.view addSubview:filterView];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -自定义方法
-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"航班列表"];
    
    UIButton *filterButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-36, 33, 18, 18)];
    [filterButton setBackgroundImage:[UIImage imageNamed:@"ListIcon"] forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(filterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:filterButton];
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-72, 33, 18, 18)];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"FlightSearchIconBig"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(filterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:searchButton];
}

-(void)filterButtonClick:(UIButton *)button
{
        [UIView animateWithDuration:0.3 animations:^{
            filterView.alpha = 1;
        }];
}



#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FlightFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEWCELL_IDETIFIER ];
    if (cell==nil) {
        cell= [[NSBundle mainBundle] loadNibNamed:@"FlightFilterTableViewCell" owner:nil options:nil][0];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FlightDetailViewController *flightDetailVC = [[FlightDetailViewController alloc]initWithNibName:@"FlightDetailViewController" bundle:nil];
    [self.navigationController pushViewController:flightDetailVC animated:YES];
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
            case TabBarSelectedTypeFunction:
            {
                FunctionViewController *function = [[FunctionViewController alloc] init];
                [self.navigationController pushViewController:function animated:NO];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
