//
//  FlightDelaysViewController.m
//  airmobile
//
//  Created by xuesong on 16/11/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDelaysViewController.h"
#import "FlightDelaysTableViewCell.h"
#import "FlightDelaysDetailViewController.h"

static const NSString *FLGHTDELAYS_TABLECELL_IDENTIFIER = @"FLGHTDELAYS_TABLECELL_IDENTIFIER";

@interface FlightDelaysViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FlightDelaysViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTitle];

    _tableView.delegate = self;
    _tableView.dataSource =self;


    // Do any additional setup after loading the view from its nib.
}

-(void)initTitle
{
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"大面积航班延误"];
    [self titleViewAddBackBtn];

}



#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlightDelaysTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FLGHTDELAYS_TABLECELL_IDENTIFIER];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FlightDelaysTableViewCell" owner:nil options:nil][0];
    }
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FlightDelaysDetailViewController *FlightDelaysDetailVC = [[FlightDelaysDetailViewController alloc]initWithNibName:@"FlightDelaysDetailViewController" bundle:nil];
    [self.navigationController pushViewController:FlightDelaysDetailVC animated:YES];

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
