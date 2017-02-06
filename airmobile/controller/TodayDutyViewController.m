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

@interface TodayDutyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<DutyModel *> *tableArray;

@end

@implementation TodayDutyViewController
{

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
            _tableArray = [responseObj DictionaryToModel:[DutyModel class]];
            _tableArray= [_tableArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {

                NSInteger x1 = ((DutyModel *)obj1).sort;
                NSInteger x2 = ((DutyModel *)obj2).sort;
                return  x1>x2;
            }];
            [_tableView reloadData];
        }
        [self stopNetWorking];
    } failure:^(NSError *error) {
        [self stopNetWorking];
    }];
}



#pragma mark - UITableViewDelegate UITableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;

}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}



-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)ADDRESSBOOK_TABLECELL_IDENTIFIER];
    DutyModel *dutyModel = _tableArray[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ - %@", dutyModel.section,dutyModel.userName];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DutyModel *dutyModel = _tableArray[indexPath.row];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",dutyModel.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}


@end
