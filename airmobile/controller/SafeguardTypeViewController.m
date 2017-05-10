//
//  SafeguardTypeViewController.m
//  airmobile
//
//  Created by xuesong on 17/4/11.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "SafeguardTypeViewController.h"
#import "ContactPersonTableViewHeaderView.h"
#import "UIViewController+Reminder.h"
#import "HttpsUtils+Business.h"
#import "SateguardTypeTableViewCell.h"
#import "AppDelegate.h"
#import "UserInfoModel.h"
#import "SateguardTypeModel.h"
#import "TypeGroupModel.h"

const NSString *SAFEGUARDTYPE_TABLECELL_IDENTIFIER = @"SAFEGUARDTYPE_TABLECELL_IDENTIFIER";
const NSString *SAFEGUARDTYPE_TABLEGROUPHEAER_IDENTIFIER = @"SAFEGUARDTYPE_TABLEGROUPHEAER_IDENTIFIER";

@interface SafeguardTypeViewController ()<ContactPersonTableViewHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableArray;
@property (nonatomic, strong) NSArray<TypeGroupModel *> *array;
@property (nonatomic, strong) NSMutableArray *resultArry;
@end



@implementation SafeguardTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"修改保障环节"];
    [self titleViewAddBackBtn];

    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerNib:[UINib nibWithNibName:@"SateguardTypeTableViewCell" bundle:nil]
     forCellReuseIdentifier:(NSString *)SAFEGUARDTYPE_TABLECELL_IDENTIFIER];
    [_tableView registerNib:[UINib nibWithNibName:@"ContactPersonTableViewHeaderView" bundle:nil]
forHeaderFooterViewReuseIdentifier:(NSString *)SAFEGUARDTYPE_TABLEGROUPHEAER_IDENTIFIER];

    _tableArray = [NSMutableArray array];
    _resultArry = [NSMutableArray array];
    _array = [NSArray array];
    [self UpdateNetwork];
}

-(void)UpdateNetwork
{
    [self starNetWorking];

    __weak typeof(self) weakSelf = self;

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    [HttpsUtils queryDispatchTypeWithUserid:@(appDelegate.userInfoModel.id).stringValue
                                     Sucess:^(NSArray *responseObj) {
                                          [weakSelf stopNetWorking];

                                         NSArray<SateguardTypeModel *> *resonseObjArray =[responseObj DictionaryToModel:[SateguardTypeModel class]];
//                                         NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                                         NSMutableArray *typeGroupArray = [NSMutableArray array];
                                         for (SateguardTypeModel *model in resonseObjArray) {
                                             NSInteger tag = 1;
                                             for (TypeGroupModel *gModel in typeGroupArray) {
                                                 if ([model.type isEqualToString:gModel.name]) {
                                                     tag = 0;
                                                 }
                                             }
                                             if (tag) {
                                                 TypeGroupModel *gModel = [[TypeGroupModel alloc]init];
                                                 gModel.name = model.type;
                                                 gModel.subType = [NSMutableArray array];
                                                 [typeGroupArray addObject:gModel];
                                             }

                                         }

                                         for (SateguardTypeModel *model in resonseObjArray) {
                                             for (TypeGroupModel *gModel in typeGroupArray) {
                                                 if([model.type isEqualToString:gModel.name]){
                                                     [gModel.subType addObject:model];
                                                 }
                                             }
                                         }

                                         weakSelf.array = [typeGroupArray copy];
                                         weakSelf.resultArry = [NSMutableArray array];
                                         for (int i = 0; i<weakSelf.array.count; i++) {
                                             // 初始时都是折叠状态（bool不能直接放在数组里）
                                             [weakSelf.resultArry addObject:[NSNumber numberWithBool:NO]];
                                         }
                                         [weakSelf.tableView reloadData];
                                         [weakSelf stopNetWorking];

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
        NSArray *tempArr = ((TypeGroupModel *)[_array objectAtIndex:section]).subType;
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
    ContactPersonTableViewHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)SAFEGUARDTYPE_TABLEGROUPHEAER_IDENTIFIER];
    view.tag = section;
    view.delegate = self;
    view.open = [[_resultArry objectAtIndex:view.tag] boolValue];
    view.nameLabel.text = _array[section].name;
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SateguardTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)SAFEGUARDTYPE_TABLECELL_IDENTIFIER];
    SateguardTypeModel *model = [((TypeGroupModel *)[_array objectAtIndex:indexPath.section]).subType objectAtIndex:indexPath.row];
    cell.satefuardTypeModel = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_array[indexPath.section].userArr[indexPath.row].phone];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    SateguardTypeModel *model = [((TypeGroupModel *)[_array objectAtIndex:indexPath.section]).subType objectAtIndex:indexPath.row];
    [self starNetWorking];
    [HttpsUtils updateDispatchTypeWithDispathId:@(model.id).stringValue
                                    flagSpecial:model.falgSpecial
                                        flagSee:[model.flagSuervise isEqualToString:@"0"]?@"1":@"0"
                                         Sucess:^(id response) {
                                             SateguardTypeModel *model = [((TypeGroupModel *)[_array objectAtIndex:indexPath.section]).subType objectAtIndex:indexPath.row];
                                             model.flagSuervise= [model.flagSuervise isEqualToString:@"0"]?@"1":@"0";
                                             [self.tableView reloadData];
                                             [self stopNetWorking];
                                         } failure:^(NSError *error) {
                                             [self showAnimationTitle:@"更新失败"];
                                             [self stopNetWorking];
                                         }];

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
