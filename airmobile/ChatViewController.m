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

static const NSString *CHAT_LEFTTABLECELL_IDENTIFIER = @"CHAT_LEFTTABLECELL_IDENTIFIER";
static const NSString *CHAT_RIGHTTABLECELL_IDENTIFIER = @"CHAT_RIGHTTABLECELL_IDENTIFIER";
static const NSString *CHAT_TIMETABLECELL_IDENTIFIER = @"CHAT_TIMETABLECELL_IDENTIFIER";


@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *chatArray;


@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _chatArray = @[@"你好",@"好你妹"];
    // Do any additional setup after loading the view from its nib.
}



-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"聊天"];
    [self titleViewAddBackBtn];
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-16-40, 30, 40, 25)];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.backgroundColor = [UIColor orangeColor];
    sureButton.layer.cornerRadius = 5.0;
    [self.titleView addSubview:sureButton];
}

-(void)sureButtonClick:(UIButton *)sender
{
    
}


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ChatTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)CHAT_TIMETABLECELL_IDENTIFIER];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ChatTimeTableViewCell" owner:nil options:nil][0];
        }
        return cell;
    }else if (indexPath.row == 1){
        ChatLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)CHAT_LEFTTABLECELL_IDENTIFIER];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ChatLeftTableViewCell" owner:nil options:nil][0];
        }
        return cell;
    }else{
        ChatRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)CHAT_RIGHTTABLECELL_IDENTIFIER];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ChatRightTableViewCell" owner:nil options:nil][0];
        }
        return cell;
    }
    return  nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
