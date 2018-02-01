//
//  OrderOptionsViewController.m
//  airmobile
//
//  Created by xuesong on 2018/1/23.
//  Copyright © 2018年 杨泉林. All rights reserved.
//

#import "OrderOptionsViewController.h"
#import "HttpsUtils+Business.h"
#import "UIViewController+Reminder.h"
#import "NormalReportTableViewCell.h"

const NSString *ORDEROPTIONS_TABLECELL_IDENTIFIER = @"SAFEGUARDTYPE_TABLECELL_IDENTIFIER";

@interface OrderOptionsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray  *tableArray;
@property (strong, nonatomic) NSDictionary *selectDic;

@end

@implementation OrderOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitle];

    _tableArray = [NSArray array];
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerNib:[UINib nibWithNibName:@"NormalReportTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)ORDEROPTIONS_TABLECELL_IDENTIFIER];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

-(void)initTitle
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"环节名称选择"];
    [self titleViewAddBackBtn];

        UIButton *finshButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-10-40, 27, 40, 30)];
        [finshButton setTitle:@"完成"  forState:UIControlStateNormal];
        [finshButton addTarget:self action:@selector(finshButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:finshButton];

}


-(void)loadData{
    [HttpsUtils queryNarmolDispatchBaseListSucess:^(id responseObj) {
        if ([responseObj isKindOfClass:[NSArray class]]) {
            self.tableArray = responseObj;
            [_tableView reloadData];
        }

    } failure:^(NSError *error) {

        [self showAnimationTitle:@"请求失败"];
    }];
}

-(void)finshButtonClick:(UIButton *)sender
{
    if (_selectDic == nil) {
        [self showAnimationTitle:@"请选择一个环节"];
        return;
    }
    if ([_delegate respondsToSelector:@selector(OrderOptionsDidSelectReports:)]) {
        [_delegate OrderOptionsDidSelectReports:_selectDic];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NormalReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)ORDEROPTIONS_TABLECELL_IDENTIFIER];
    NSDictionary *dic = _tableArray[indexPath.row];
    cell.nameLable.text = [dic objectForKey:@"name"];
    cell.isSelected = dic==_selectDic;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _tableArray[indexPath.row];
    _selectDic = dic;
    [_tableView reloadData];
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
