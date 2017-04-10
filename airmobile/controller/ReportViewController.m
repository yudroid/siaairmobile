//
//  ReportViewController.m
//  airmobile
//
//  Created by xuesong on 17/3/30.
//  Copyright © 2017年 杨泉林. All rights reserved.
//
const NSString *REPORTTABLEIDENTIFIER = @"REPORTTABLEIDENTIFIER";

#import "ReportViewController.h"
#import "HttpsUtils+Business.h"
#import "KnowledgeBaseModel.h"
#import "UIViewController+Reminder.h"
#import "KnowledgeBaseTableViewCell.h"
#import "KnowledgeBaseContentViewController.h"

@interface ReportViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *tableArray;

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];
    _tableView.tableFooterView = [[UIView alloc]init];
//    _tableArray = @[@"日报",@"周报",@"月报"];
    [self loadDataWithReportItem:ReportItemDay];
}


-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"运行简报"];
    [self titleViewAddBackBtn];
}


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KnowledgeBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)REPORTTABLEIDENTIFIER];
    if (!cell) {
        cell =[[NSBundle mainBundle]loadNibNamed:@"KnowledgeBaseTableViewCell" owner:nil options:nil][0];
    }
    KnowledgeBaseModel *model =_tableArray[indexPath.row];
    cell.knowledgeBaseModel = model;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    KnowledgeBaseModel *model = _tableArray[indexPath.row];
    KnowledgeBaseContentViewController *knowledgeBaseContentVC = [[KnowledgeBaseContentViewController alloc]initWithNibName:@"KnowledgeBaseContentViewController" bundle:nil];
    knowledgeBaseContentVC.knowledgeBaseModel = model;
    knowledgeBaseContentVC.title = model.title;
    knowledgeBaseContentVC.type = 2;
    [self.navigationController pushViewController:knowledgeBaseContentVC animated:YES];

}

- (IBAction)segementValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case ReportItemDay:
            [self loadDataWithReportItem:ReportItemDay];
            break;
        case ReportItemWeek:
            [self loadDataWithReportItem:ReportItemWeek];
            break;
        case ReportItemMonth:
            [self loadDataWithReportItem:ReportItemMonth];
            break;
        default:
            break;
    }
}

-(void)loadDataWithReportItem:(ReportItem)reportItem
{
    __weak typeof(self) weakSelf = self;
    void (^successBlock)(id) = ^(NSArray *response){
        weakSelf.tableArray = [response DictionaryToModel:[KnowledgeBaseModel class]];
        [weakSelf.tableView reloadData];
        [weakSelf stopNetWorking];
    };
    void (^failureBlock)(id) = ^(NSError *error) {
        weakSelf.tableArray = [NSArray array];
        [weakSelf.tableView reloadData];
        [weakSelf showAnimationTitle:@"请求失败"];
        [weakSelf stopNetWorking];
    };
    [self starNetWorking];
    switch (reportItem) {
        case ReportItemDay:
        {
            [HttpsUtils mobileDayLogSucess:^(NSArray *response) {
                successBlock(response);
            } failure:^(NSError *error) {
                failureBlock(error);
            }];
            break;
        }
        case ReportItemWeek:
        {
            [HttpsUtils mobileWeekLogSucess:^(NSArray *response) {
                successBlock(response);
            } failure:^(NSError *error) {
                failureBlock(error);
            }];
            break;
        }
        case ReportItemMonth:
        {
            [HttpsUtils mobileMonthLogSucess:^(NSArray *response) {
                successBlock(response);
            } failure:^(NSError *error) {
                failureBlock(error);
            }];
            break;
        }
        default:
            break;
    }
}
@end
