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
#import "SingleMessageViewController.h"
#import "ContactPersonViewController.h"
#import "MessageTableViewCell.h"
#import "FixedMessageTableViewCell.h"
#import "ChatViewController.h"
#import "PersistenceUtils+Business.h"
#import "FlightDelaysViewController.h"
#import "AppDelegate.h"
#import "MessageService.h"
#import "HttpsUtils+Business.h"

static const NSString *MESSAGE_TABLECELL_IDENTIFIER = @"MESSAGE_TABLECELL_IDENTIFIER";
static const NSString *MESSAGE_FIXTABLECELL_IDENTIFIER = @"MESSAGE_FIXTABLECELL_IDENTIFIER";

@interface MessageViewController ()<TabBarViewDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate,MessageViewDelegate>

@property (nonatomic, strong) UISearchBar *searBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *searchView;

@end

@implementation MessageViewController{
    SRWebSocket *srWebSocket;
    UITextField *textfield;
    NSArray<NSDictionary *> *array;
    NSMutableArray<NSDictionary *> *filterArray;
    UITextField *searchTextField;
    int userId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    userId = (int)delegate.userInfoModel.id;

    
    [self initTitleView];
    [self initSearBar];
    [self initTable];
    [self initSearchTableView];

    

    filterArray = [NSMutableArray array];
    //TabBer自定义
    self.tabBarView = [[TabBarView alloc] initTabBarWithModel:TabBarBgModelHomePage
                                                 selectedType:TabBarSelectedTypeMessage
                                                     delegate:self];
    [self.view insertSubview:self.tabBarView aboveSubview:self.view];
}

-(void)initSearBar
{

    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                 64,
                                                                 kScreenWidth,
                                                                 50)];
    searchView.backgroundColor = [CommonFunction colorFromHex:0XFFF1F1F1];
    [self.view addSubview:searchView];
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(7,
                                                                  11,
                                                                  kScreenWidth-8,
                                                                  32)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 4.0;
    [searchView addSubview:contentView];
    UIImageView *searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(6,
                                                                                8,
                                                                                15,
                                                                                15)];
    searchImageView.image = [UIImage imageNamed:@"SearchIconBig"];
    [contentView addSubview:searchImageView];

    searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(27,
                                                                                0,
                                                                                kScreenWidth-50,
                                                                                32)];
    searchTextField.font = [UIFont fontWithName:@"PingFang SC"
                                           size:14];
    searchTextField.textColor = [CommonFunction colorFromHex:0XFFbbbbbb];
    searchTextField.placeholder = @"会话名称";
    searchTextField.returnKeyType = UIReturnKeyDone;
    searchTextField.delegate = self;
    [searchTextField addTarget:self action:@selector(filterDialogList:) forControlEvents:UIControlEventEditingChanged];
    
    [contentView addSubview:searchTextField];
    if([DeviceInfoUtil isPlus]){
        contentView.frame = CGRectMake(px_3(20),
                                       px_3(22),
                                       kScreenWidth-2*px_3(20),
                                       px_3(105));
        searchImageView.frame = CGRectMake(px_3(21),
                                           10,
                                           15,
                                           15);
        searchTextField.frame = CGRectMake(px_3(21)+15+px_3(26),
                                           0,
                                           viewWidth(contentView)-(px_3(21)+15+px_3(26)),
                                           px_3(105));
    }
}

-(void)initTable
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                              114,
                                                              kScreenWidth,
                                                              kScreenHeight-114-48)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MessageTableViewCell" bundle:nil]
     forCellReuseIdentifier:(NSString *)MESSAGE_TABLECELL_IDENTIFIER];
    [_tableView registerNib:[UINib nibWithNibName:@"FixedMessageTableViewCell" bundle:nil]
     forCellReuseIdentifier:(NSString *)MESSAGE_FIXTABLECELL_IDENTIFIER];
    [self.view addSubview:_tableView];
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"消息"];
    
    UIButton *chatButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-10-22,
                                                                     33,
                                                                     22,
                                                                     20)];
    [chatButton setBackgroundImage:[UIImage imageNamed:@"message"]
                          forState:UIControlStateNormal];
    [chatButton addTarget:self
                   action:@selector(chatButtonClick:)
         forControlEvents:UIControlEventTouchUpInside];
    
    [self.titleView addSubview:chatButton];
}



-(void)chatButtonClick:(UIButton *)sender
{
    ContactPersonViewController *contactPersonVC = [[ContactPersonViewController alloc]initWithNibName:@"ContactPersonViewController"
                                                                                                bundle:nil];
    [self.navigationController  pushViewController:contactPersonVC animated:YES];
}

//-(void)initOptionView
//{
//    _optionView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-8-100, 53, 100, 40)];
//    [self.view addSubview:_optionView];
//    
//    UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 00, 100, 40)];
//    backgroundImageView.image = [UIImage imageNamed:@"optionChatBackground"];
//    [_optionView addSubview:backgroundImageView];
//    
//    
//    UIImageView *openChatImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 13, 20, 20)];
//    openChatImageView.image = [UIImage imageNamed:@"icon_flight"];
//    [_optionView addSubview:openChatImageView];
//    
//    UIButton *openChatButton = [[UIButton alloc]initWithFrame:CGRectMake(33, 5, 67, 35)];
//    [openChatButton setTitle:@"发起聊天" forState:UIControlStateNormal];
//    openChatButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    openChatButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [openChatButton addTarget:self action:@selector(optionChatButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [_optionView addSubview:openChatButton];
//    
//    _optionView.alpha = 0;
//}



-(void)initSearchTableView
{
    _searchView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                          108,
                                                          kScreenWidth,
                                                          kScreenHeight-108)];
    _searchView.backgroundColor = [UIColor grayColor];
    _searchView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(searchViewClick:)];
    [_searchView addGestureRecognizer:tap];
    [self.view addSubview:_searchView];
}

-(void)filterDialogList:(id)sender
{
    if(array==nil || [array count]<5)
        return;
    NSString *search = searchTextField.text;
    [filterArray removeAllObjects];
    if([search isEqualToString:@""]){
        [filterArray addObjectsFromArray:array];
        [_tableView reloadData];
        return;
    }
    
    for(NSDictionary *dic in array){
        NSString *name = [dic objectForKey:@"name"];
        if([name containsString:search]){
            [filterArray addObject:dic];
        }
    }
    [_tableView reloadData];
}

#pragma mark - EVENT

//-(void)optionChatButtonClick:(UIButton *)sender
//{
//   
//}


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
    return [filterArray count]+2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        FixedMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)MESSAGE_FIXTABLECELL_IDENTIFIER];
        cell.headImageView.image = [UIImage imageNamed:@"FlightDelays"];
        cell.nameLabel.text = @"航班事件消息";
        return cell;
    }else if (indexPath.row ==1) {
        FixedMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)MESSAGE_FIXTABLECELL_IDENTIFIER];
        cell.nameLabel.text = @"重要消息";
        cell.headImageView.image = [UIImage imageNamed:@"EventRemind"];
        return cell;
    }else{
        MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)MESSAGE_TABLECELL_IDENTIFIER];
        NSDictionary *dic = [filterArray objectAtIndex:indexPath.row-2];
        if(dic == nil){
            return nil;
        }
         cell.headImageView.image = [UIImage imageNamed:@"MessageHeader"];
        cell.nameLabel.text = [dic objectForKey:@"name"];
        cell.messageLabel.text = [dic objectForKey:@"describe"];
        cell.timeLable.text = [[dic objectForKey:@"time"] stringByReplacingOccurrencesOfString:@" "
                                                                                    withString:@"\n"];
        return cell;
    }
    return  nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        [self showFlightEventView];

    }else if(indexPath.row ==1){
        [self showCommendMsgView];
    }else{
        NSDictionary *dic = [filterArray objectAtIndex:indexPath.row-2];
        long chatId = [[dic objectForKey:@"chatid"]  longLongValue];
        long typeId = [[dic objectForKey:@"type"] longLongValue];
        long localChatId = [[dic objectForKey:@"id"] longLongValue];
        [self showMessageDialog:chatId
                     chatTypeId:typeId
                    localChatId:localChatId];
    }
}
///左滑动删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0||indexPath.row==1) {
        return NO;
    }
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [filterArray removeObjectAtIndex:indexPath.row-2];

    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];

}


-(void) showFlightEventView
{
    FlightDelaysViewController *flightDelaysVC = [[FlightDelaysViewController alloc]initWithNibName:@"FlightDelaysViewController"
                                                                                             bundle:nil];
    flightDelaysVC.type = @"FLIGHT";
    [self.navigationController pushViewController:flightDelaysVC
                                         animated:YES];

}

-(void) showCommendMsgView
{
    FlightDelaysViewController *flightDelaysVC = [[FlightDelaysViewController alloc]initWithNibName:@"FlightDelaysViewController"
                                                                                             bundle:nil];
    flightDelaysVC.type = @"COMMAND";
    [self.navigationController pushViewController:flightDelaysVC
                                         animated:YES];
}

-(void) showMessageDialog:(long)chatId chatTypeId:(long)chatTypeId localChatId:(long)localChatId
{
    ChatViewController *chatVC = [[ChatViewController alloc]initWithNibName:@"ChatViewController"
                                                                     bundle:nil];
    chatVC.chatId = chatId;
    chatVC.chatTypeId = (int)chatTypeId;
    chatVC.localChatId = localChatId;
    [self.navigationController pushViewController:chatVC
                                         animated:YES];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _searchView.alpha = 1;
}

-(void)loadChatList:(int)start num:(int)num
{
    array = [PersistenceUtils findChatListByUserId:userId start:start num:num];
    [filterArray removeAllObjects];
    [filterArray addObjectsFromArray:array];
    [_tableView reloadData];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
    [MessageService sharedMessageService].chatListDelegate = self;
    [self loadChatList:0 num:1000];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [MessageService sharedMessageService].chatListDelegate = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

-(void)refreshChatInfoList
{
    [self loadChatList:0 num:1000];
}

@end
