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
#import "ChatLeftTableViewCell.h"
#import "ChatTimeTableViewCell.h"
#import "HttpsUtils+Business.h"
#import "AppDelegate.h"
#import "MessageService.h"
#import "PersistenceUtils+Business.h"
#import "ContactPersonViewController.h"
#import "ChatLeftFileTableViewCell.h"
#import "ChatLeftImageTableViewCell.h"
#import "ChatRightImageTableViewCell.h"
#import "ChatRightFileTableViewCell.h"
#import "FCFileManager.h"
#import "JSDownloadView.h"
#import "HttpFileDown.h"
#import "UIViewController+Reminder.h"
#import "ZYShowPictureView.h"
#import "JLPhoto.h"
#import "JLPhotoBrowser.h"


static const NSString *CHAT_LEFTTABLECELL_IDENTIFIER = @"CHAT_LEFTTABLECELL_IDENTIFIER";
static const NSString *CHAT_RIGHTTABLECELL_IDENTIFIER = @"CHAT_RIGHTTABLECELL_IDENTIFIER";
static const NSString *CHAT_TIMETABLECELL_IDENTIFIER = @"CHAT_TIMETABLECELL_IDENTIFIER";
static const NSString *CHAT_RIGHTIMAGETABLECELL_IDENTIFIER = @"CHAT_RIGHTIMAGETABLECELL_IDENTIFIER";
static const NSString *CHAT_RIGHTFILETABLECELL_IDENTIFIER = @"CHAT_RIGHTFILETABLECELL_IDENTIFIER";
static const NSString *CHAT_LEFTIMAGETABLECELL_IDENTIFIER = @"CHAT_LEFTIMAGETABLECELL_IDENTIFIER";
static const NSString *CHAT_LEFTFILETABLECELL_IDENTIFIER = @"CHAT_LEFTFILETABLECELL_IDENTIFIER";

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,ChatViewDelegate,ChatRightFileTableViewCellDelegate,ChatRightImageTableViewCellDelegate,ChatLeftImageTableViewCellDelegate,ChatLeftFileTableViewCellDelegate,JSDownloadAnimationDelegate,UIDocumentInteractionControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *chatArray;
@property (weak, nonatomic) IBOutlet UIView *msgView;
@property (weak, nonatomic) IBOutlet UITextView *msgTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *msgViewButtom;

@property (nonatomic, strong) JSDownloadView *downloadView;
@property (nonatomic, strong) HttpFileDown *httpFileDown;
@property (nonatomic, assign) NSInteger downStatus;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIDocumentInteractionController *documentVc;

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
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
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

    
    [MessageService sharedMessageService].chatDelegate = self;
    if(_tableView.contentSize.height -_tableView.bounds.size.height>0){
        [_tableView setContentOffset:CGPointMake(0, _tableView.contentSize.height -_tableView.bounds.size.height+100) animated:YES];
    }
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
    


    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-16-40,
                                                                     33,
                                                                     41,
                                                                     18)];
    sureButton.titleLabel.font = [UIFont fontWithName:@"PingFang SC"
                                                 size:10];
    [sureButton setTitle:@"详情" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(groupInfoButtonClick:)
         forControlEvents:UIControlEventTouchUpInside];
    [sureButton setBackgroundImage:[UIImage imageNamed:@"PersonSure"]
                          forState:UIControlStateNormal];
    sureButton.layer.cornerRadius = 5.0;
//    if(_chatTypeId==1)
//        [self.titleView addSubview:sureButton];

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
    NSString *flag = [dic objectForKey:@"flag"];
    if ([flag isEqualToString:@"img"]) {
        return 45+8+50;
    }else if([flag isEqualToString:@"file"]){
        return 54+8+50;
    }else{
        CGSize size = ([contentText boundingRectWithSize:CGSizeMake(kScreenWidth-150, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:textFont}
                                             context:nil]).size;
        return size.height + 45+8;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_chatArray objectAtIndex:indexPath.row];
    long senduserid = [[dic objectForKey:@"senduserid"] longLongValue];
    NSString *name = [dic objectForKey:@"username"];
    NSString *time = [dic objectForKey:@"time"];
    NSString *flag = [dic objectForKey:@"flag"];
    if(time != nil)
    {
        time = [CommonFunction dateFormat: [dateFormatter dateFromString:time] format:@"[dd]HH:mm"];
    }
    NSString *content = [dic objectForKey:@"content"];
    if(senduserid == user.id){
        if ([flag isEqualToString:@"img"]) {
            ChatRightImageTableViewCell *rImageCell =  [tableView dequeueReusableCellWithIdentifier:(NSString *)CHAT_RIGHTIMAGETABLECELL_IDENTIFIER];
            if (!rImageCell) {
                rImageCell = [[NSBundle mainBundle] loadNibNamed:@"ChatRightTableViewCell"
                                                           owner:nil
                                                         options:nil][1];
            }
            rImageCell.imageBase64 = content;
            rImageCell.timeLabel.text = time?:@"";
            rImageCell.nameLabel.text = name?:@"";
            rImageCell.delegate = self;
            return rImageCell;
        }else if([flag isEqualToString:@"file"]){
            ChatRightFileTableViewCell *rFlightCell = [tableView dequeueReusableCellWithIdentifier:(NSString *)CHAT_RIGHTFILETABLECELL_IDENTIFIER];
            if (!rFlightCell) {
                rFlightCell = [[NSBundle mainBundle] loadNibNamed:@"ChatRightTableViewCell"
                                                            owner:nil
                                                          options:nil][2];
            }
            rFlightCell.filePath = content?:@"";
            rFlightCell.timeLabel.text = time?:@"";
            rFlightCell.nameLabel.text = name?:@"";
            rFlightCell.delegate = self;
            return rFlightCell;
        }else{
            ChatRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)CHAT_RIGHTTABLECELL_IDENTIFIER];
            if(cell == nil){
                cell = [[NSBundle mainBundle] loadNibNamed:@"ChatRightTableViewCell"
                                                     owner:nil
                                                   options:nil][0];
            }
            [cell setContentText:content?:@""];
            cell.timeLabel.text = time?:@"";
            cell.nameLabel.text = name?:@"";
            return cell;
            }
    }else{
        if ([flag isEqualToString:@"img"]) {
            ChatLeftImageTableViewCell *lImageCell =  [tableView dequeueReusableCellWithIdentifier:(NSString *)CHAT_LEFTIMAGETABLECELL_IDENTIFIER];
            if (!lImageCell) {
                lImageCell = [[NSBundle mainBundle] loadNibNamed:@"ChatLeftTableViewCell"
                                                           owner:nil
                                                         options:nil][1];
            }
            lImageCell.imageBase64 = content;
            lImageCell.timeLabel.text = time?:@"";
            lImageCell.nameLabel.text = name?:@"";
            lImageCell.delegate = self;
            return lImageCell;

        }else if([flag isEqualToString:@"file"]){
            ChatLeftFileTableViewCell *lFlightCell = [tableView dequeueReusableCellWithIdentifier:(NSString *)CHAT_LEFTFILETABLECELL_IDENTIFIER];
            if (!lFlightCell) {
                lFlightCell = [[NSBundle mainBundle] loadNibNamed:@"ChatLeftTableViewCell"
                                                            owner:nil
                                                          options:nil][2];
            }
            lFlightCell.filePath = content?:@"";
            lFlightCell.timeLabel.text = time?:@"";
            lFlightCell.nameLabel.text = name?:@"";
            lFlightCell.delegate = self;
            return lFlightCell;
        }else{
            ChatLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)CHAT_LEFTTABLECELL_IDENTIFIER];
            if(cell == nil){
                cell = [[NSBundle mainBundle] loadNibNamed:@"ChatLeftTableViewCell"
                                                     owner:nil
                                                   options:nil][0];
            }
            [cell setContentText:content?:@""];
            cell.timeLabel.text = time?:@"";
            cell.nameLabel.text = name?:@"";
            return cell;
        }
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
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillShow:)
                                                name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillHide:)
                                                name:UIKeyboardWillHideNotification object:nil];
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
//        [_msgTextView resignFirstResponder];
        MessageModel *msg = [[MessageModel alloc] initWithId:user.id
                                                     content:_msgTextView.text
                                                      fromId:user.id
                                                        toId:_chatId
                                                        type:_chatTypeId status:0];


        if(_chatTypeId==0){
            [HttpsUtils sendUserMessage:msg success:^(id resp) {
                _msgTextView.text = @"";
                [self saveSendMessage:msg.content];
            } failure:nil];
        }else{
            [HttpsUtils sendGroupMessage:msg success:^(id resp) {
                _msgTextView.text = @"";
                [self saveSendMessage:msg.content];
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
    [PersistenceUtils updateRemoveUnReadCountWithChatid:(int)_localChatId];
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
    [_chatArray addObjectsFromArray:[PersistenceUtils findMsgListByChatId:_localChatId
                                                                    start:0
                                                                      num:20]];
}

-(void)saveSendMessage:(NSString *)content
{
    NSDictionary *message = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithLong:_localChatId],
                             @"chatid",content,
                             @"content",[NSNumber numberWithLong:user.id],
                             @"userid",user.name,@"username", [CommonFunction dateFormat:nil format:@"yyyy-MM-dd HH:mm:ss"],@"createTime", nil];
    [PersistenceUtils insertNewChatMessage:message needid:NO success:^{
        [self refreshDialogData];
    }];
}

// 未读消息数据没有做处理
-(void)refreshDialogData
{
    if([_chatArray count] == 0){
        [_chatArray addObjectsFromArray:[PersistenceUtils findMsgListByChatId:_localChatId
                                                                        start:0
                                                                          num:20]];
    }else{
        NSDictionary *dic = [_chatArray lastObject];
        long lastId = [[dic objectForKey:@"id"] longLongValue];
        [_chatArray addObjectsFromArray:[PersistenceUtils findMsgListByChatId:_localChatId
                                                                        start:lastId]];
    }
    if(_tableView!=nil){
        [_tableView reloadData];
        if(self.tableView.contentSize.height -self.tableView.bounds.size.height>0){
            [self.tableView setContentOffset:CGPointMake(0,
                                                         self.tableView.contentSize.height -self.tableView.bounds.size.height)
                                    animated:YES];
        }
    }
}

- (void)backButtonClick{
    long size = [self.navigationController.viewControllers count];
    UIViewController *viewCtl = self.navigationController.viewControllers[size-2];
    if(viewCtl !=nil && [viewCtl isKindOfClass:[ContactPersonViewController class]]){
        viewCtl = self.navigationController.viewControllers[size-3];
        if(viewCtl !=nil)
            [self.navigationController popToViewController:viewCtl
                                                  animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}






#pragma mark - 文件图片相关 自定义方法
//下载取消页面
-(void)cancelButonClick:(UIButton *)sender
{
    [[self.view viewWithTag:99] removeFromSuperview];
    _httpFileDown = nil;
}

//图片预览 ，点击关闭
- (void)tapPic {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[ZYShowPictureView class]]) {
            [view removeFromSuperview];
        }
    }
}

// 文档下载
- (void)downStartWithPath:(NSString *)path1{

    //进度block
    void (^downloadProgressBlock)(NSProgress*) = ^(NSProgress *downloadProgress){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *progressString  = [NSString stringWithFormat:@"%.2f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount];
            self.downloadView.progress = progressString.floatValue;
        });
    };
    //文件路径block
    NSURL *(^destinationBlock)(NSURL *, NSURLResponse *) =
    ^(NSURL *targetPath, NSURLResponse *response){
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:@"DownFile"];
        if ( ![FCFileManager existsItemAtPath:path]) {
            [FCFileManager createDirectoriesForPath:path];
        }
        NSString *localpath =  [path1 stringByReplacingOccurrencesOfString:@"/" withString:@"--"];
        path = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"DownFile/%@",localpath]];
        return [NSURL fileURLWithPath:path];
    };
    //完成block
    void (^completionHandlerBlock)(NSURLResponse *, NSURL *, NSError *)=^(NSURLResponse *response, NSURL *filePath, NSError *error){
        _downStatus = 0;
        if (error) {
            _downStatus = 1;
            [FCFileManager removeItemAtPath:[filePath path]];
        }
        self.downloadView.isSuccess = YES;
        // NSString *path = [filePath path];
        //        NSLog(@"************文件路径:%@",path);
        [_tableView reloadData];
    };

    _httpFileDown = [[HttpFileDown alloc]init];

    [_httpFileDown chatDownFileWithHttpPath:path1
                                   Progress:^(NSProgress *downloadProgress) {
                                       downloadProgressBlock(downloadProgress);
                                   } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                       return destinationBlock(targetPath,response);
                                   } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                       completionHandlerBlock(response,filePath,error);
                                   }];

}
//处理文件cell  如果已下载 则跳出sheet 没有下载 则下载。
-(void)handleWFileCellWithPath:(NSString *)path
{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *localpath = [path stringByReplacingOccurrencesOfString:@"/" withString:@"--"];
    localpath = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"DownFile/%@",localpath]];
    if (![FCFileManager existsItemAtPath:localpath]) {
        if (_backgroundView== nil) {
            _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            _backgroundView.tag = 99;
            _backgroundView.backgroundColor = [CommonFunction colorFromHex:0x992F8AEB];
            _downloadView = [[JSDownloadView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-50, CGRectGetHeight(self.view.frame)/2-50, 100, 100)];
            [_backgroundView addSubview:_downloadView];
            _downloadView.delegate = self;
            UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2-50, kScreenHeight-100, 100, 50)];
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
            [cancelButton addTarget:self action:@selector(cancelButonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_backgroundView addSubview:cancelButton];
        }
        [self.view addSubview:_backgroundView];
        [self downStartWithPath:path];
    }else{
        NSURL *url = [NSURL fileURLWithPath:path];
        _documentVc = [UIDocumentInteractionController interactionControllerWithURL:url];
        _documentVc.delegate = self;
        //         [_documentVc presentPreviewAnimated:YES];
        [_documentVc presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
    }
}

-(void)handleImageCellWithImage:(UIImage *)image
{
//    ZYShowPictureView *picView = [ZYShowPictureView new];
//    [self.view addSubview:picView];
//
//    picView.image = image;
//    [picView setLimitWithMaxScale:2. minScale:1.];
//    picView.frame = CGRectMake(0, 64, kScreenWidth, kScreenWidth-64);
//    picView.center = self.view.center;
//
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPic)];
//    [picView addGestureRecognizer:tap];

    if (image == nil) {
        return;
    }
    //1.创建JLPhoto数组
    NSMutableArray *photos = [NSMutableArray array];
        JLPhoto *photo = [[JLPhoto alloc] init];
        //1.3设置图片tag
        photo.tag = 0;
    photo.image = image;
        [photos addObject:photo];



    //2. 创建图片浏览器
    JLPhotoBrowser *photoBrowser = [JLPhotoBrowser photoBrowser];
    //2.1 设置JLPhoto数组
    photoBrowser.photos = photos;
    //2.2 设置当前要显示图片的tag
    photoBrowser.currentIndex = 0;
    //2.3 显示图片浏览器
    [photoBrowser show];
}

#pragma mark - cellDelegate
//右 图片点击事件
-(void)chatRightImageClick:(UIImage *)image
{
    [self handleImageCellWithImage:image];
}
//右 文件下载事件
-(void)chatRightFileDownFlile:(NSString *)path
{
    [self handleWFileCellWithPath:path];
}
//左 图片点击事件
-(void)chatLeftImageClick:(UIImage *)image
{
    [self handleImageCellWithImage:image];

}

//左 文件下载事件
-(void)chatLeftFileDownFlile:(NSString *)path
{
    [self handleWFileCellWithPath:path];
}

#pragma mark - UIDocumentInteractionController 代理方法
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return self.view.bounds;
}
- (BOOL)presentOpenInMenuFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated
{
    return YES;
}

#pragma mark - 下载页面代理
-(void)animationStart
{
    NSLog(@"开始下载");
}
- (void)animationSuspend{
    NSLog(@"暂停下载");
}

- (void)animationEnd{
    NSLog(@"结束下载");
    [self cancelButonClick:nil];

    if(_downStatus ==1){
        [self showAnimationTitle:@"下载失败"];
    }else{
        [self showAnimationTitle:@"下载成功"];
    }
}

@end
