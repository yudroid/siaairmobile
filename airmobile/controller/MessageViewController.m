//
//  MessageViewController.m
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
#import "ContactPersonViewController.h"
#import "MessageTableViewCell.h"
#import "FixedMessageTableViewCell.h"

static const NSString *MESSAGE_TABLECELL_IDENTIFIER = @"MESSAGE_TABLECELL_IDENTIFIER";
static const NSString *MESSAGE_FIXTABLECELL_IDENTIFIER = @"MESSAGE_FIXTABLECELL_IDENTIFIER";


@interface MessageViewController ()<TabBarViewDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic, strong) UIView *optionView;
@property (nonatomic, strong) UISearchBar *searBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *searchView;

@end

@implementation MessageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitleView];
    [self initSearBar];
    [self initTable];
    [self initSearchTableView];
    
    [self initOptionView];
    
    //TabBer自定义
    self.tabBarView = [[TabBarView alloc] initTabBarWithModel:TabBarBgModelHomePage selectedType:TabBarSelectedTypeHomePage delegate:self];
    [self.view insertSubview:self.tabBarView aboveSubview:self.view];
    
    
    // Do any additional setup after loading the view.
}


-(void)initSearBar
{
    _searBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];
    _searBar.delegate = self;
    [self.view addSubview:_searBar];
}

-(void)initTable
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 108, kScreenWidth, kScreenHeight-108-48)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)MESSAGE_TABLECELL_IDENTIFIER];
    [_tableView registerNib:[UINib nibWithNibName:@"FixedMessageTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)MESSAGE_FIXTABLECELL_IDENTIFIER];
    [self.view addSubview:_tableView];
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"消息"];
    
    UIButton *chatButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-16-20, 33, 20, 20)];
    
    [chatButton setBackgroundImage:[UIImage imageNamed:@"icon_flight"] forState:UIControlStateNormal];
    [chatButton addTarget:self action:@selector(chatButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.titleView addSubview:chatButton];
}

-(void)chatButtonClick:(UIButton *)sender
{
    if (_optionView.alpha == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            _optionView.alpha = 1;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            _optionView.alpha = 0;
        }];
    }
}

-(void)initOptionView
{
    _optionView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-8-100, 53, 100, 40)];
    [self.view addSubview:_optionView];
    
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 00, 100, 40)];
    backgroundImageView.image = [UIImage imageNamed:@"optionChatBackground"];
    [_optionView addSubview:backgroundImageView];
    
    
    UIImageView *openChatImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 13, 20, 20)];
    openChatImageView.image = [UIImage imageNamed:@"icon_flight"];
    [_optionView addSubview:openChatImageView];
    
    UIButton *openChatButton = [[UIButton alloc]initWithFrame:CGRectMake(33, 5, 67, 35)];
    [openChatButton setTitle:@"发起聊天" forState:UIControlStateNormal];
    openChatButton.titleLabel.font = [UIFont systemFontOfSize:14];
    openChatButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [openChatButton addTarget:self action:@selector(optionChatButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_optionView addSubview:openChatButton];
    
    _optionView.alpha = 0;
}



-(void)initSearchTableView
{
    _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 108, kScreenWidth, kScreenHeight-108)];
    _searchView.backgroundColor = [UIColor grayColor];
    _searchView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchViewClick:)];
    [_searchView addGestureRecognizer:tap];
    [self.view addSubview:_searchView];
}


#pragma mark - EVENT

-(void)optionChatButtonClick:(UIButton *)sender
{
    ContactPersonViewController *contactPersonVC = [[ContactPersonViewController alloc]initWithNibName:@"ContactPersonViewController" bundle:nil];
    [self.navigationController  pushViewController:contactPersonVC animated:YES];
}

-(void)searchViewClick:(UIView *)view
{
    [UIView animateWithDuration:0.6 animations:^{
        _searchView.alpha = 0;
    }];
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <2) {
        FixedMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)MESSAGE_FIXTABLECELL_IDENTIFIER];
        
        return cell;
    }else{
        MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)MESSAGE_TABLECELL_IDENTIFIER];
        return cell;
        
    }
    
    return  nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UIsearchDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText);
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _searchView.alpha = 1;
}
#pragma mark 切换底部主功能页面
-(void)selectWithType:(TabBarSelectedType)type
{
    NSArray *viewControllers=[self.navigationController viewControllers];
    
    if (type == TabBarSelectedTypeHomePage)
    {
        for (UIViewController * controller in viewControllers)
        {
            if ([controller isKindOfClass:[HomePageViewController class]])
            {
                [self.navigationController popToViewController:controller animated:NO];
            }
            else
            {
                HomePageViewController *homPage = [[HomePageViewController alloc] init];
                [self.navigationController pushViewController:homPage animated:NO];
            }
        }
    }
    else if (type==TabBarSelectedTypeFlight)
    {
        for (UIViewController * controller in viewControllers)
        {
            if ([controller isKindOfClass:[FlightViewController class]])
            {
                [self.navigationController popToViewController:controller animated:NO];
            }
            else
            {
                FlightViewController *flight = [[FlightViewController alloc] init];
                [self.navigationController pushViewController:flight animated:NO];
            }
        }
        
    }
    else if (type==TabBarSelectedTypeUserInfo)
    {
        for (UIViewController * controller in viewControllers)
        {
            if ([controller isKindOfClass:[UserInfoViewController class]])
            {
                [self.navigationController popToViewController:controller animated:NO];
            }
            else
            {
                UserInfoViewController *userInfo = [[UserInfoViewController alloc] init];
                [self.navigationController pushViewController:userInfo animated:NO];
            }
        }
        
    }
    else if (type==TabBarSelectedTypeFunction)
    {
        for (UIViewController * controller in viewControllers)
        {
            if ([controller isKindOfClass:[FunctionViewController class]])
            {
                [self.navigationController popToViewController:controller animated:NO];
            }
            else
            {
                FunctionViewController *function = [[FunctionViewController alloc] init];
                [self.navigationController pushViewController:function animated:NO];
            }
        }
        
    }
}


@end
