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
#import "FlightModel.h"
#import "HttpsUtils+Business.h"
#import <MJRefresh.h>
#import "FlightService.h"

static const CGFloat FLIGHTFILTERVIEW_HEIGHT = 365;
static  NSString * TABLEVIEWCELL_IDETIFIER = @"FLIGHTFILTER_TABLEVIEWCELL_IDETIFIER";

@interface FlightViewController ()<TabBarViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UIView *searBar;
@property (nonatomic, strong) UITableView *tableView ;

@end

@implementation FlightViewController
{
    FlightFilterView *filterView;
    NSArray<FlightModel *> *dataArray;
    int startIndex;
    int pagesize;
    NSString *flightNo;//搜索的内容（模糊查询）
    NSString *flightRegion;//区域筛选
    NSString *flightType;//性质筛选
    NSString *flightStatus;//状态筛选
}

- (void)viewDidLoad {

    [super viewDidLoad];

    FlightService *flightService = [[FlightService alloc]init];
    [flightService startService];
    dataArray = [flightService getFlightArray];
    
    // 优先加载数据，存在网络延迟，认为会在视图加载完成后返回结果
    startIndex = 0;
    pagesize = 20;
//    dataArray = [NSMutableArray array];

    [self initTitleView];
    //TabBer自定义
    self.tabBarView = [[TabBarView alloc] initTabBarWithModel:TabBarBgModelHomePage
                                                 selectedType:TabBarSelectedTypeFlight
                                                     delegate:self];
    [self.view insertSubview:self.tabBarView
                aboveSubview:self.view];
    
    
    _tableView = [[UITableView alloc]
                              initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49)];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    //添加过滤条件View
    filterView = [[[NSBundle mainBundle] loadNibNamed:@"FlightFilterView"
                                                owner:nil
                                              options:nil] lastObject];
    filterView.frame = CGRectMake(0, 64, kScreenWidth, FLIGHTFILTERVIEW_HEIGHT);
    filterView.alpha = 0;

    [self.view addSubview:filterView];

    //添加下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                      refreshingAction:@selector(UpdateNetwork)];
    //添加上拉加载
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                          refreshingAction:@selector(loadMoreNetwork)];
}


#pragma mark - 自定义方法
-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor
                                      colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"航班列表"];
    //过滤按钮
    UIButton *filterButton = [[UIButton alloc]
                              initWithFrame:CGRectMake(kScreenWidth-36, 33, 18, 18)];
    [filterButton setBackgroundImage:[UIImage imageNamed:@"ListIcon"]
                            forState:UIControlStateNormal];
    [filterButton addTarget:self
                     action:@selector(filterButtonClick:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:filterButton];
    //查询按钮
    UIButton *searchButton = [[UIButton alloc]
                              initWithFrame:CGRectMake(kScreenWidth-72, 33, 18, 18)];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"FlightSearchIconBig"]
                            forState:UIControlStateNormal];
    [searchButton addTarget:self
                     action:@selector(searchButtonClick:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:searchButton];

    //搜索条
    _searBar = [[UIView alloc]
                initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, 64)];
    _searBar.backgroundColor = [UIColor
                                colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:_searBar];

    //返回按钮
    UIButton *searchBackButton = [[UIButton alloc]
                                  initWithFrame:CGRectMake(0, 20, 51, 44)];
    searchBackButton.backgroundColor = [UIColor clearColor];
    //    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [searchBackButton setImage:[UIImage imageNamed:@"back"]
                      forState:(UIControlStateNormal)];
    [searchBackButton setImage:[UIImage imageNamed:@"back"]
                      forState:(UIControlStateSelected)];
    [_searBar addSubview:searchBackButton];
    [searchBackButton addTarget:self
                         action:@selector(searchBackButtonClick:)
               forControlEvents:(UIControlEventTouchUpInside)];
    //查询文本输入框

    //背景
    UIImageView *searchTextBackgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(searchBackButton), (44- px_px_2_3(59, 91))/2+20, kScreenWidth-viewTrailing(searchBackButton)-16,px_px_2_3(59, 91) )];
    searchTextBackgroundImageView.image = [UIImage imageNamed:@"SearchTextBackground"];
    [_searBar addSubview:searchTextBackgroundImageView];

    //放大镜图标
    UIImageView *searchTagImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px_px_2_3(11, 17)+viewX(searchTextBackgroundImageView), viewY(searchTextBackgroundImageView)+(viewHeight(searchTextBackgroundImageView)-15)/2, 15, 15)];
    searchTagImageView.image = [UIImage imageNamed:@"SearchIconBig"];
//    searchTagImageView.backgroundColor = [UIColor redColor];
    [_searBar addSubview:searchTagImageView];
    
    UITextField *searContentTextField = [[UITextField alloc]
                                         initWithFrame:CGRectMake(px_px_2_3(14, 22)+viewTrailing(searchTagImageView), viewY(searchTextBackgroundImageView), viewWidth(searchTextBackgroundImageView)-viewTrailing(searchTagImageView)-px_px_2_3(14, 22), viewHeight(searchTextBackgroundImageView))];
    searContentTextField.placeholder = @"请输入查询内容";
    searContentTextField.delegate = self;
    searContentTextField.returnKeyType = UIReturnKeySearch;
    searContentTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:px_px_2_3(26, 40)];
    [_searBar addSubview:searContentTextField];

    //搜索按钮
//    UIButton *searchBarSearchButton = [[UIButton alloc]
//                                       initWithFrame:CGRectMake(kScreenWidth-51, 20, 51, 44)];
//    [searchBarSearchButton setTitle:@"搜索"
//                           forState:UIControlStateNormal];
//    [searchBarSearchButton addTarget:self
//                              action:@selector(searchBarSearchButtonClick:)
//                    forControlEvents:UIControlEventTouchUpInside];
//    [_searBar addSubview:searchBarSearchButton];

}

-(void)UpdateNetwork
{
//    NSDictionary *conds = [[NSDictionary alloc] initWithObjectsAndKeys:flightNo,@"search_flightNO",flightRegion,@"search_region",flightType,@"search_model",flightStatus,@"search_state",startIndex,@"start",pagesize,@"length", nil];
//    [HttpsUtils queryFlightList:conds success:^(id responseObj) {
//        // 数据加载完成
//        [_tableView.mj_header endRefreshing];
//        if(![responseObj isKindOfClass:[NSDictionary class]]){
//            return;
//        }
//        FlightModel *flight = nil;
//        for(id item in responseObj){
//            flight = [FlightModel new];
//            [self copyToFlightModel:flight item:item];
//            [dataArray addObject:flight];
//        }
//        [_tableView reloadData];
//        startIndex +=pagesize;
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        [_tableView.mj_header endRefreshing];
//    }];
}

-(void)loadMoreNetwork
{
//    NSDictionary *conds = [[NSDictionary alloc] initWithObjectsAndKeys:flightNo,@"search_flightNO",flightRegion,@"search_region",flightType,@"search_model",flightStatus,@"search_state",startIndex,@"start",pagesize,@"length", nil];
//    [HttpsUtils queryFlightList:conds success:^(id responseObj) {
//        // 数据加载完成
//        [_tableView.mj_footer endRefreshing];
//        if(![responseObj isKindOfClass:[NSDictionary class]]){
//            return;
//        }
//        FlightModel *flight = nil;
//        for(id item in responseObj){
//            flight = [FlightModel new];
//            [self copyToFlightModel:flight item:item];
//            [dataArray addObject:flight];
//        }
//        [_tableView reloadData];
//        startIndex +=pagesize;
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        [_tableView.mj_footer endRefreshing];
//    }];
}

-(void)copyToFlightModel:(FlightModel *)flight item:(id)item
{
    if([flight isNull:item])
        return;
    [flight setValuesForKeysWithDictionary:item];
}

#pragma mark - EVENT
-(void)filterButtonClick:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        filterView.alpha = 1;
    }];
}
-(void)searchButtonClick:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        _searBar.frame = CGRectMake(0, 0, kScreenWidth, 64);
    }];

}
-(void)searchBackButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        _searBar.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, 64);
    }];

}
-(void)searchBarSearchButtonClick:(UIButton *)sender
{
    [self.view endEditing:YES];

}


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlightModel *flight = [dataArray objectAtIndex:indexPath.row];
    FlightFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEWCELL_IDETIFIER ];
    if (cell==nil) {
        cell= [[NSBundle mainBundle] loadNibNamed:@"FlightFilterTableViewCell" owner:nil options:nil][0];
    }
    [cell refreshData:flight];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FlightDetailViewController *flightDetailVC = [[FlightDetailViewController alloc]initWithNibName:@"FlightDetailViewController" bundle:nil];
    FlightModel *flight = [dataArray objectAtIndex:indexPath.row];
    flightDetailVC.flightId = flight.id;
    [self.navigationController pushViewController:flightDetailVC animated:YES];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
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
