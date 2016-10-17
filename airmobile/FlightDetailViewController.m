//
//  FlightDetailViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDetailViewController.h"
#import "FlightDetailTableViewCell.h"
#import "AbnormalityReportViewController.h"
#import "FlightDetailSafeguardTableViewCell.h"

static const NSString *FLIGHTDETAIL_TABLECELL_IDENTIFIER = @"FLIGHTDETAIL_TABLECELL_IDENTIFIER";
static const NSString *FLIGHTDETAIL_SAFEGUARDTABLECELL_IDENTIFIER = @"FLIGHTDETAIL_SAFEGUARDTABLECELL_IDENTIFIER";
@interface FlightDetailViewController ()<UITableViewDataSource,UITableViewDelegate,FlightDetailTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *safeguardTableView;
@property (nonatomic, copy) NSArray *safeguardTableViewArray;



@end

@implementation FlightDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"航班列表"];
    
    [self titleViewAddBackBtn];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableViewHeight.constant = 1000;
    _tableView.allowsSelection = NO;
    _safeguardTableView.dataSource = self;
    _safeguardTableView.delegate = self;
    _safeguardTableView.allowsSelection = NO;
    
}



#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _safeguardTableView) {
        return 2;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _safeguardTableView) {
        return 30;
    }
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _safeguardTableView) {
        FlightDetailSafeguardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FLIGHTDETAIL_SAFEGUARDTABLECELL_IDENTIFIER];
        if (cell==nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"FlightDetailSafeguardTableViewCell" owner:nil options:nil][0];
        }
        return  cell;
        
    }else{
        FlightDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FLIGHTDETAIL_TABLECELL_IDENTIFIER];
        if (cell==nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"FlightDetailTableViewCell" owner:nil options:nil][0];
        }
        cell.delegate = self;
        return  cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - FlightDetailTableViewCellDelegate
-(void)flightDetailTableViewCellUsualButtonClick
{
    AbnormalityReportViewController *abnormalityReportVC=[[AbnormalityReportViewController alloc]initWithNibName:@"AbnormalityReportViewController" bundle:nil];
    [self.navigationController pushViewController:abnormalityReportVC animated:YES];
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
