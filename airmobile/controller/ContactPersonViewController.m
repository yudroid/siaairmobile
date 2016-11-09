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
#import "PersistenceUtils+Business.h"

static const NSString *CONTACTPERSON_TABLECELL_IDENTIFIER = @"CONTACTPERSON_TABLECELL_IDENTIFIER";
static const NSString *CONTACTPERSON_TABLECELLHRADER_IDENTIFIER = @"CONTACTPERSON_TABLECELLHEADER_IDENTIFIER";

@interface ContactPersonViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *selectTableArray;

@end

@implementation ContactPersonViewController
{
    NSArray<DeptInfoModel *> *array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitleView];

    _selectTableArray = [NSMutableArray array];
    _searchBar.delegate = self;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerNib:[UINib nibWithNibName:@"ContactPersonTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)CONTACTPERSON_TABLECELL_IDENTIFIER];
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:(NSString *)CONTACTPERSON_TABLECELLHRADER_IDENTIFIER];
    // Do any additional setup after loading the view from its nib.
    
    array = [NSArray new];
    [self initTableData];
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"选择联系人"];
    [self titleViewAddBackBtn];

    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-16-40, 33, 40, 18)];
    sureButton.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:10];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setBackgroundImage:[UIImage imageNamed:@"PersonSure"] forState:UIControlStateNormal];
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
    return [array count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tempArr = [array objectAtIndex:section].userArr;
    if(tempArr==nil)
        return 0;
    return [tempArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)CONTACTPERSON_TABLECELL_IDENTIFIER];
    UserInfoModel *userInfo = [[array objectAtIndex:indexPath.section].userArr objectAtIndex:indexPath.row];
    cell.textLabel.text = userInfo.name;
    cell.user = userInfo;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ContactPersonTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([_selectTableArray containsObject:cell]) {
        [_selectTableArray removeObject:cell];
        cell.isSelected = NO;
    }else{
        [_selectTableArray addObject:cell];
        cell.isSelected = YES;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[array objectAtIndex:section].deptName];
    if(header==nil)
        header = [UITableViewHeaderFooterView new];
    header.textLabel.text = [array objectAtIndex:section].deptName;
    return header;
}
#pragma mark -searchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"search -text %@",searchText);
}

-(void)initTableData
{
    array = [PersistenceUtils loadUserListGroupByDept];
}

@end
