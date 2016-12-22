//
//  TodayDutyViewController.m
//  airmobile
//
//  Created by xuesong on 16/12/13.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "TodayDutyViewController.h"
#import "AddressBookTableViewCell.h"
#import "ContactPersonTableViewHeaderView.h"
#import "DutyModel.h"
#import "HttpsUtils+Business.h"
#import "DeptInfoModel.h"
#import "UIViewController+Reminder.h"


static const NSString *ADDRESSBOOK_TABLEGROUPHEAER_IDENTIFIER   = @"ADDRESSBOOK_TABLEGROUPHEADER_IDENTIFIER";
static const NSString *ADDRESSBOOK_TABLECELL_IDENTIFIER         = @"ADDRESSBOOK_TABLECELL_IDENTIFIER";

@interface TodayDutyViewController ()<UITableViewDelegate,UITableViewDataSource,ContactPersonTableViewHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableArray;

@end

@implementation TodayDutyViewController
{
    NSArray *array;

    NSMutableArray *_resultArry;// 保存数据的展开状态(因为分组很多，所以不能设置一个bool类型记录)
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddBackBtn];
    [self titleViewAddTitleText:@"今日值班表"];


    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerNib:[UINib nibWithNibName:@"AddressBookTableViewCell" bundle:nil]
     forCellReuseIdentifier:(NSString *)ADDRESSBOOK_TABLECELL_IDENTIFIER];
    [_tableView registerNib:[UINib nibWithNibName:@"ContactPersonTableViewHeaderView" bundle:nil]
forHeaderFooterViewReuseIdentifier:(NSString *)ADDRESSBOOK_TABLEGROUPHEAER_IDENTIFIER];

    _tableArray = [NSMutableArray array];
    

    [self UpdateNetwork];
    

}
-(void)UpdateNetwork
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"%@",currentDateStr);

    [self starNetWorking];
    [HttpsUtils getDutyTableByDay:currentDateStr success:^(NSArray *responseObj) {
        if ([responseObj isKindOfClass:[NSArray class]]) {
            NSMutableArray *depMutableArray = [NSMutableArray array];
            NSMutableSet *mutableSet = [NSMutableSet set];
            for (NSDictionary *depDic in responseObj) {
                DutyModel *du = [[DutyModel alloc]initWithDictionary:depDic];
                [depMutableArray addObject:du];
                [mutableSet addObject:[depDic objectForKey:@"section"]];
            }

            NSMutableArray *mutableArray = [NSMutableArray array];
            for (NSString *section in mutableSet) {
                NSMutableArray *peoples = [NSMutableArray array];
                for (DutyModel *model in depMutableArray) {
                    if ([section isEqualToString:model.section]) {
                        [peoples addObject:model];
                    }
                }
                NSDictionary *dic = @{@"name":section,@"value":[peoples copy]};
                [mutableArray addObject:dic];
            }
            
            array = [mutableArray copy];
            _resultArry = [NSMutableArray array];
            for (int i = 0; i<array.count; i++) {
                // 初始时都是折叠状态（bool不能直接放在数组里）
                [_resultArry addObject:[NSNumber numberWithBool:NO]];
            }
            [_tableView reloadData];
        }
        [self stopNetWorking];

    } failure:^(NSError *error) {
        [self stopNetWorking];
    }];
}



#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [array count];
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    if ([[_resultArry objectAtIndex:section] boolValue]) {
        NSArray *tempArr = [[array objectAtIndex:section] objectForKey:@"value"];
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
    view.tag            = section;
    view.delegate       = self;
    view.open           = [[_resultArry objectAtIndex:view.tag] boolValue];
    view.nameLabel.text = [array[section] objectForKey:@"name"];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)ADDRESSBOOK_TABLECELL_IDENTIFIER];
//    UserInfoModel *userInfo = [[array objectAtIndex:indexPath.section].userArr objectAtIndex:indexPath.row];
    cell.nameLabel.text = ((DutyModel *)[array[indexPath.section] objectForKey:@"value"][indexPath.row]).userName;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",((DutyModel *)[array[indexPath.section] objectForKey:@"value"][indexPath.row]).phone];
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
