//
//  ChatViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatLeftTableViewCell.h"
#import "ChatRightTableViewCell.h"
#import "ChatTimeTableViewCell.h"
#import "HttpsUtils+Business.h"
#import "AppDelegate.h"
#import "MessageService.h"
#import "PersistenceUtils+Business.h"


static const NSString *CHAT_LEFTTABLECELL_IDENTIFIER = @"CHAT_LEFTTABLECELL_IDENTIFIER";
static const NSString *CHAT_RIGHTTABLECELL_IDENTIFIER = @"CHAT_RIGHTTABLECELL_IDENTIFIER";
static const NSString *CHAT_TIMETABLECELL_IDENTIFIER = @"CHAT_TIMETABLECELL_IDENTIFIER";


@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,ChatViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *chatArray;
@property (weak, nonatomic) IBOutlet UIView *msgView;
@property (weak, nonatomic) IBOutlet UITextView *msgTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *msgViewButtom;

@end

@implementation ChatViewController
{
    CGFloat _keyBoardHeight;
    CGFloat _oldSizeHeight;
    UserInfoModel *user;
    NSDateFormatter *dateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    user = delegate.userInfoModel;
    
    [[MessageService sharedMessageService] resetDialogParam:user.id userId:user.id toId:_chatId type:_chatTypeId];
    _chatArray = [[NSMutableArray alloc] init];

    [self initChatMsgData];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view from its nib.
    
    _msgTextView.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapBgClick)];
    [self.view addGestureRecognizer:tap];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [MessageService sharedMessageService].chatDelegate = self;
}

- (void)tapBgClick{
    [_msgTextView resignFirstResponder];
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"聊天"];
    [self titleViewAddBackBtn];
    


    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-16-40, 33, 41, 18)];
    sureButton.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:10];
    [sureButton setTitle:@"详情" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(groupInfoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setBackgroundImage:[UIImage imageNamed:@"PersonSure"] forState:UIControlStateNormal];
    sureButton.layer.cornerRadius = 5.0;
    if(_chatTypeId==1)
        [self.titleView addSubview:sureButton];

}

-(void)groupInfoButtonClick:(UIButton *)sender
{
    
}


#pragma mark - UITableViewDelegate UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_chatArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_chatArray objectAtIndex:indexPath.row];
    UIFont *textFont =[UIFont fontWithName:@"PingFang SC" size:13];
    NSString *contentText =  [dic objectForKey:@"content"];
    CGSize size = ([contentText boundingRectWithSize:CGSizeMake(kScreenWidth-150, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:textFont}
                                             context:nil]).size;
    return size.height + 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_chatArray objectAtIndex:indexPath.row];
    long senduserid = [[dic objectForKey:@"senduserid"] longLongValue];
    NSString *name = [dic objectForKey:@"username"];
    NSString *time = [dic objectForKey:@"time"];
    if(time != nil)
    {
        time = [CommonFunction dateFormat: [dateFormatter dateFromString:time] format:@"[dd]HH:mm"];
    }
    NSString *content = [dic objectForKey:@"content"];
    if(senduserid == user.id){
        ChatRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)CHAT_RIGHTTABLECELL_IDENTIFIER];
        if(cell == nil)
            cell = [[NSBundle mainBundle] loadNibNamed:@"ChatRightTableViewCell" owner:nil options:nil][0];
        [cell setContentText:content];
        cell.timeLabel.text = time;
        cell.nameLabel.text = name;
        return cell;
    }else{
        ChatLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)CHAT_LEFTTABLECELL_IDENTIFIER];
        if(cell == nil)
            cell = [[NSBundle mainBundle] loadNibNamed:@"ChatLeftTableViewCell" owner:nil options:nil][0];
        [cell setContentText:content];
        cell.timeLabel.text = time;
        cell.nameLabel.text = name;
        return cell;
    }
    return  nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //监听键盘 NSNotificationCenter通知中心
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 textfield编辑时显示键盘
 
 @param sender <#sender description#>
 */
-(void)keyboardWillShow:(NSNotification *)sender{
    CGRect rect=[[sender.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat height= rect.size.height;
    
//    float y = -height;
//    if(y<0){
//        //    UIKeyboardAnimationDurationUserInfoKey//获取键盘升起动画时间
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:[[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue]];
//        self.view.transform=CGAffineTransformMakeTranslation(0, y);
//        [UIView commitAnimations];
//        
//    }

    [UIView animateWithDuration:[[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue]
                     animations:^{
                         _msgViewButtom.constant = height;
                         [self.view layoutIfNeeded];

                     }];
}


/**
 退出编辑时隐藏键盘
 
 @param sender <#sender description#>
 */
-(void)keyboardWillHide:(NSNotification *)sender{
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:[[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue]];
//    self.view.transform=CGAffineTransformIdentity;//重置状态
//    [UIView commitAnimations];

    [UIView animateWithDuration:[[sender.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue]
                     animations:^{
                         _msgViewButtom.constant = 0;
                         [self.view layoutIfNeeded];

                     }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [_msgTextView resignFirstResponder];
        MessageModel *msg = [[MessageModel alloc] initWithId:user.id content:_msgTextView.text fromId:user.id toId:_chatId type:_chatTypeId status:0];
        _msgTextView.text = @"";
        [self saveSendMessage:msg.content];
        if(_chatTypeId==0){
            [HttpsUtils sendUserMessage:msg success:^(id resp) {
                
            } failure:nil];
        }else{
            [HttpsUtils sendGroupMessage:msg success:^(id resp) {
                
            } failure:nil];
        }
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MessageService sharedMessageService].chatDelegate = nil;
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    _msgTextView = textView;
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self.view endEditing:YES];
    return YES;
}

//(id integer PRIMARY KEY AUTOINCREMENT NOT NULL,chatid integer NOT NULL,content nvarchar(1024),senduserid integer NOT NULL,username nvarchar(50),time datetime NOT NULL,status integer(1),CONSTRAINT 'ChatMessage_FK1' FOREIGN KEY ('chatid') REFERENCES 'ChatInfo' ('id') ON DELETE CASCADE ON UPDATE CASCADE);

-(void)initChatMsgData
{
    [_chatArray addObjectsFromArray:[PersistenceUtils findMsgListByChatId:_localChatId start:0 num:20]];
}

-(void)saveSendMessage:(NSString *)content
{
    NSDictionary *message = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithLong:_localChatId],@"chatid",content,@"content",[NSNumber numberWithLong:user.id],@"userid",user.name,@"username", nil];
    [PersistenceUtils insertNewChatMessage:message needid:NO success:^{
        [self refreshDialogData];
    }];
}

// 未读消息数据没有做处理
-(void)refreshDialogData
{
    if([_chatArray count] == 0){
        [_chatArray addObjectsFromArray:[PersistenceUtils findMsgListByChatId:_localChatId start:0 num:20]];
    }else{
        NSDictionary *dic = [_chatArray lastObject];
        long lastId = [[dic objectForKey:@"id"] longLongValue];
        [_chatArray addObjectsFromArray:[PersistenceUtils findMsgListByChatId:_localChatId start:lastId]];
    }
    if(_tableView!=nil){
        [_tableView reloadData];
        if(self.tableView.contentSize.height -self.tableView.bounds.size.height>0){
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height -self.tableView.bounds.size.height) animated:YES];
        }
    }
}

- (void)backButtonClick{
    UIViewController *viewCtl = self.navigationController.viewControllers[2];
    if(viewCtl !=nil)
        [self.navigationController popToViewController:viewCtl animated:YES];
    else
        [self.navigationController popViewControllerAnimated:YES];
}

@end
