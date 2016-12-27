//
//  SingleMessageViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/12/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "SingleMessageViewController.h"
#import "FlightViewController.h"
#import "HomePageViewController.h"
#import "MessageViewController.h"
#import "FunctionViewController.h"
#import "UserInfoViewController.h"
#import "FlightDelaysTableViewCell.h"
#import "FlightDelaysDetailViewController.h"
#import "PersistenceUtils+Business.h"
#import <MJRefresh.h>
#import "SysMessageModel.h"

static const NSString *SINGLE_FLGHTDELAYS_TABLECELL_IDENTIFIER = @"SINGLE_FLGHTDELAYS_TABLECELL_IDENTIFIER";
@interface SingleMessageViewController ()<TabBarViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation SingleMessageViewController
{
    UITableView *_tableView;
    NSMutableArray *data;
    int startIndex;
    int pagesize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                              64,
                                                              kScreenWidth,
                                                              kScreenHeight-64-48)];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    //添加下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                            refreshingAction:@selector(updateNetwork)];
    //添加上拉加载
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadMoreNetwork)];
    [self.view addSubview:_tableView];
    
    startIndex = 0;
    pagesize = 20;
    data = [NSMutableArray array];
    
    //TabBer自定义
    self.tabBarView = [[TabBarView alloc] initTabBarWithModel:TabBarBgModelHomePage
                                                 selectedType:TabBarSelectedTypeMessage
                                                     delegate:self];
    [self.view insertSubview:self.tabBarView aboveSubview:self.view];
    
    [self refreshData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"消息"];
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

#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(data != nil)
        return [data count];
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlightDelaysTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)SINGLE_FLGHTDELAYS_TABLECELL_IDENTIFIER];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FlightDelaysTableViewCell"
                                             owner:nil
                                           options:nil][0];
    }
    
    SysMessageModel *model = [[SysMessageModel alloc] initWithDictionary:[data objectAtIndex:indexPath.row]];
    
    cell.authorLabel.text = [NSString stringWithFormat:@"%@", model.createtime];
    cell.titleLabel.text = model.title;
    cell.read = (![model.readtime isEqualToString:@"<null>"]);
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = [data objectAtIndex:indexPath.row];
    SysMessageModel *model = [[SysMessageModel alloc] initWithDictionary:dic];
    [PersistenceUtils updateSysMessageRead:model.msgid];
    [self.tabBarView setHasNewMessage:[PersistenceUtils unReadCount]];
    
    FlightDelaysDetailViewController *flightDelaysDetailVC = [[FlightDelaysDetailViewController alloc]initWithNibName:@"FlightDelaysDetailViewController" bundle:nil];
    flightDelaysDetailVC.titleText = model.title;
    flightDelaysDetailVC.contentText = model.content;
    [self.navigationController pushViewController:flightDelaysDetailVC
                                         animated:YES];
    [dic setValue:[CommonFunction nowDate] forKey:@"readtime"];
    [data setObject:dic atIndexedSubscript:indexPath.row];
    [_tableView reloadData];
}

-(void)refreshData
{
    [data removeAllObjects];
    startIndex = 0;
    [data addObjectsFromArray:[PersistenceUtils findSysMsgListByType:_type start:startIndex num:pagesize]];
    [_tableView reloadData];
}

-(void)updateNetwork
{
    [data removeAllObjects];
    startIndex = 0;
    @try {
        [data addObjectsFromArray:[PersistenceUtils findSysMsgListByType:_type start:startIndex num:pagesize]];
        [_tableView reloadData];
    } @catch (NSException *exception) {
        
    } @finally {
        [_tableView.mj_header endRefreshing];
    }
    startIndex +=pagesize;
}

-(void)loadMoreNetwork
{
    @try {
        [data addObjectsFromArray:[PersistenceUtils findSysMsgListByType:_type start:startIndex num:pagesize]];
        [_tableView reloadData];
    } @catch (NSException *exception) {
        
    } @finally {
        [_tableView.mj_footer endRefreshing];
    }
    startIndex +=pagesize;
}

@end
