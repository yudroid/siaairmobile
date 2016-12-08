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

const char * ALERTVIEW_BLOCK = "ALERTVIEW_BLOCK";
static const NSString *ADDRESSBOOK_TABLEGROUPHEAER_IDENTIFIER = @"ADDRESSBOOK_TABLEGROUPHEADER_IDENTIFIER";
static const NSString *ADDRESSBOOK_TABLECELL_IDENTIFIER = @"ADDRESSBOOK_TABLECELL_IDENTIFIER";

@interface AddressBookViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,ContactPersonTableViewHeaderViewDelegate>

@property (nonatomic, strong) NSMutableArray *tableArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AddressBookViewController
{
    NSArray<DeptInfoModel *> *array;

    NSMutableArray *_resultArry;// 保存数据的展开状态(因为分组很多，所以不能设置一个bool类型记录)
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
//
//    DeptInfoModel *dep = [[DeptInfoModel alloc]init];
//
//
//    UserInfoModel *user1 = [[UserInfoModel alloc]init];
//    user1.name = @"寇雪松";
//    UserInfoModel *user2 = [[UserInfoModel alloc]init];
//    user2.name = @"寇雪松";
//    UserInfoModel *user3 = [[UserInfoModel alloc]init];
//    user3.name = @"寇雪松";
//    UserInfoModel *user4 = [[UserInfoModel alloc]init];
//    user4.name = @"寇雪松";
//
//    dep.userArr =[NSMutableArray arrayWithArray:@[user1,user2,user3,user4]];
//
//    array = @[dep];
//    _resultArry = [NSMutableArray array];
//    for (int i = 0; i<array.count; i++) {
//        // 初始时都是折叠状态（bool不能直接放在数组里）
//        [_resultArry addObject:[NSNumber numberWithBool:NO]];
//    }

    _resultArry = [NSMutableArray array];
    array = [NSArray array];
    [self UpdateNetwork];
}

-(void)UpdateNetwork
{

    [HttpsUtils getContactList:^(NSArray *responseObj) {
        if ([responseObj isKindOfClass:[NSArray class]]) {
            NSMutableArray *depMutableArray = [NSMutableArray array];
            for (NSDictionary *depDic in responseObj) {
                DeptInfoModel *deptModel = [[DeptInfoModel alloc]initWithDictionary:depDic];
                [depMutableArray addObject:deptModel];
            }
            array = [depMutableArray copy];
            _resultArry = [NSMutableArray array];
            for (int i = 0; i<array.count; i++) {
                // 初始时都是折叠状态（bool不能直接放在数组里）
                [_resultArry addObject:[NSNumber numberWithBool:NO]];
            }
            [_tableView reloadData];
        }

    } failure:^(NSError *error) {

    }];
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
    ContactPersonTableViewHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)ADDRESSBOOK_TABLEGROUPHEAER_IDENTIFIER];
    view.tag = section;
    view.delegate = self;
    view.open = [[_resultArry objectAtIndex:view.tag] boolValue];
    view.nameLabel.text = array[section].deptName;
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    AddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)ADDRESSBOOK_TABLECELL_IDENTIFIER];
    UserInfoModel *userInfo = [[array objectAtIndex:indexPath.section].userArr objectAtIndex:indexPath.row];
    cell.nameLabel.text = userInfo.name;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",array[indexPath.section].userArr[indexPath.row].phone];
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


//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"%ld",(long)buttonIndex);
//    void (^block)(NSInteger) = objc_getAssociatedObject(alertView, ALERTVIEW_BLOCK);
//    block(buttonIndex);
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
