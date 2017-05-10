//
//  AddressBookViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/20.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AddressBookViewController.h"
#import "AddressBookTableViewCell.h"
#import <objc/runtime.h>
#import "ContactPersonTableViewHeaderView.h"
#import "ContactPersonTableViewCell.h"
#import "UserInfoModel.h"
#import "DeptInfoModel.h"
#import "HttpsUtils+Business.h"
#import "DeptInfoModel.h"
#import "UIViewController+Reminder.h"

const char * ALERTVIEW_BLOCK = "ALERTVIEW_BLOCK";
static const NSString *ADDRESSBOOK_TABLEGROUPHEAER_IDENTIFIER = @"ADDRESSBOOK_TABLEGROUPHEADER_IDENTIFIER";
static const NSString *ADDRESSBOOK_TABLECELL_IDENTIFIER = @"ADDRESSBOOK_TABLECELL_IDENTIFIER";

@interface AddressBookViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,ContactPersonTableViewHeaderViewDelegate>

@property (nonatomic, strong) NSMutableArray *tableArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<DeptInfoModel *> *array;
@property (nonatomic, strong) NSMutableArray *resultArry;

@end

@implementation AddressBookViewController
{


    // 保存数据的展开状态(因为分组很多，所以不能设置一个bool类型记录)
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"通讯录"];
    [self titleViewAddBackBtn];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerNib:[UINib nibWithNibName:@"AddressBookTableViewCell" bundle:nil]
     forCellReuseIdentifier:(NSString *)ADDRESSBOOK_TABLECELL_IDENTIFIER];
    [_tableView registerNib:[UINib nibWithNibName:@"ContactPersonTableViewHeaderView" bundle:nil]
forHeaderFooterViewReuseIdentifier:(NSString *)ADDRESSBOOK_TABLEGROUPHEAER_IDENTIFIER];

    _resultArry = [NSMutableArray array];
    _array = [NSArray array];
    [self UpdateNetwork];
}

-(void)UpdateNetwork
{
    [self starNetWorking];

    __weak typeof(self) weakSelf = self;
    [HttpsUtils getContactList:^(NSArray *responseObj) {
        if ([responseObj isKindOfClass:[NSArray class]]) {
            weakSelf.array = [responseObj DictionaryToModel:[DeptInfoModel class]];
            weakSelf.array = [weakSelf.array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSInteger x1 = ((DeptInfoModel *)obj1).sort;
                NSInteger x2 = ((DeptInfoModel *)obj2).sort;
                return  x1>x2;
            }];
            weakSelf.resultArry = [NSMutableArray array];
            for (int i = 0; i<weakSelf.array.count; i++) {
                // 初始时都是折叠状态（bool不能直接放在数组里）
                [weakSelf.resultArry addObject:[NSNumber numberWithBool:NO]];
            }
            [weakSelf.tableView reloadData];
            [weakSelf stopNetWorking];
        }
    } failure:^(NSError *error) {
        [weakSelf showAnimationTitle:@"获取失败"];
        [weakSelf stopNetWorking];

    }];
}



#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_array count];
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    if ([[_resultArry objectAtIndex:section] boolValue]) {
        NSArray *tempArr = [_array objectAtIndex:section].userArr;
        if(tempArr==nil)
            return 0;
        return [tempArr count];
    }else{
        return 0;
    }

}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 58;
}

-(CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 70.5;
}

-(UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    ContactPersonTableViewHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)ADDRESSBOOK_TABLEGROUPHEAER_IDENTIFIER];
    view.tag = section;
    view.delegate = self;
    view.open = [[_resultArry objectAtIndex:view.tag] boolValue];
    view.nameLabel.text = _array[section].deptName;
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    AddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)ADDRESSBOOK_TABLECELL_IDENTIFIER];
    UserInfoModel *userInfo = [[_array objectAtIndex:indexPath.section].userArr objectAtIndex:indexPath.row];
    cell.nameLabel.text = userInfo.name;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_array[indexPath.section].userArr[indexPath.row].phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

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
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:view.tag]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
}


@end
