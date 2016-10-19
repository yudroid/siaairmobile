//
//  ContactPersonViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ContactPersonViewController.h"
#import "ContactPersonTableViewCell.h"
#import "ChatViewController.h"

static const NSString *CONTACTPERSON_TABLECELL_IDENTIFIER = @"CONTACTPERSON_TABLECELL_IDENTIFIER";
static const NSString *CONTACTPERSON_TABLECELLHRADER_IDENTIFIER = @"CONTACTPERSON_TABLECELLHEADER_IDENTIFIER";

@interface ContactPersonViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ContactPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitleView];
    
    _searchBar.delegate = self;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"ContactPersonTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)CONTACTPERSON_TABLECELL_IDENTIFIER];
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:(NSString *)CONTACTPERSON_TABLECELLHRADER_IDENTIFIER];
    // Do any additional setup after loading the view from its nib.
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"选择联系人"];
    
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
    ChatViewController *chatVC = [[ChatViewController alloc]initWithNibName:@"ChatViewController" bundle:nil];
    [self.navigationController pushViewController:chatVC animated:YES];
}


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)CONTACTPERSON_TABLECELL_IDENTIFIER];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)CONTACTPERSON_TABLECELLHRADER_IDENTIFIER];
    header.textLabel.text = @"头";
    return header;
}
#pragma mark -searchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"search -text %@",searchText);
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
