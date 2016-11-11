//
//  ContactPersonViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/18.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ContactPersonViewController.h"
#import "ContactPersonTableViewCell.h"
#import "ContactPersonTableViewHeaderView.h"
#import "ChatViewController.h"
#import "PersistenceUtils+Business.h"

static const NSString *CONTACTPERSON_TABLECELL_IDENTIFIER = @"CONTACTPERSON_TABLECELL_IDENTIFIER";
static const NSString *CONTACTPERSON_TABLECELLHRADER_IDENTIFIER = @"CONTACTPERSON_TABLECELLHEADER_IDENTIFIER";

@interface ContactPersonViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,ContactPersonTableViewHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *selectTableArray;
@property (nonatomic, strong) NSMutableArray *tableArray;

@end

@implementation ContactPersonViewController
{
    NSArray<DeptInfoModel *> *array;
    NSMutableArray *_resultArry;// 保存数据的展开状态(因为分组很多，所以不能设置一个bool类型记录)
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitleView];

    _selectTableArray = [NSMutableArray array];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerNib:[UINib nibWithNibName:@"ContactPersonTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)CONTACTPERSON_TABLECELL_IDENTIFIER];
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:(NSString *)CONTACTPERSON_TABLECELLHRADER_IDENTIFIER];
    [_tableView registerNib:[UINib nibWithNibName:@"ContactPersonTableViewHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:(NSString *)CONTACTPERSON_TABLECELLHRADER_IDENTIFIER];
    // Do any additional setup after loading the view from its nib.
    
    array = [NSArray new];

    DeptInfoModel *model = [[DeptInfoModel alloc]init];
    model.deptName = @"研发部";
    UserInfoModel *umodel = [[UserInfoModel alloc]init];
    umodel.name = @"张三";
    model.userArr = @[umodel];
    array = @[model];
    _resultArry = [NSMutableArray array];
    for (NSDictionary *item in array) {
        // 初始时都是折叠状态（bool不能直接放在数组里）
        [_resultArry addObject:[NSNumber numberWithBool:NO]];
    }
//    [self initTableData];
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"选择联系人"];
    [self titleViewAddBackBtn];

    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-16-40, 33, 41, 18)];
    sureButton.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:10];
    [sureButton setTitle:@"确定(2)" forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setBackgroundImage:[UIImage imageNamed:@"PersonSure"] forState:UIControlStateNormal];

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
    if ([[_resultArry objectAtIndex:section] boolValue]) {
        NSArray *tempArr = [array objectAtIndex:section].userArr;
        if(tempArr==nil)
            return 0;
        return [tempArr count];
    }else{
        return 0;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 58;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70.5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ContactPersonTableViewHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)CONTACTPERSON_TABLECELLHRADER_IDENTIFIER];
    view.delegate =self;
    view.tag = section;
    view.open = [[_resultArry objectAtIndex:view.tag] boolValue];;
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactPersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString*)CONTACTPERSON_TABLECELL_IDENTIFIER];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ContactPersonTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = !cell.isSelected;


}

#pragma mark - ContactPersonTableViewHeaderViewDelegate
-(void)contactPersonTableViewHeaderViewClick:(UIView *)view
{
    ContactPersonTableViewHeaderView *headerView = (ContactPersonTableViewHeaderView *)view;
    headerView.open = !headerView.open;
        // 通过点击的段数，来获取数组里的bool（对应的展开状态）
        BOOL bo = [[_resultArry objectAtIndex:view.tag] boolValue];
        // 把点击段数的状态转换为相反的状态
        [_resultArry replaceObjectAtIndex:view.tag withObject:[NSNumber numberWithBool:!bo]];
        // 刷新某个分段（只有这一个刷新分组的方法，所以刷新一组，或者刷新全组都是这样写，NSIndexSet为一个集合）

        //刷新某个 section 里面的 cell 数据
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:view.tag] withRowAnimation:UITableViewRowAnimationAutomatic];


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
