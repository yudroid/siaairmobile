//
//  FlightDetailViewController.m
//  airmobile
//
//  Created by xuesong on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FlightDetailViewController.h"
#import "FlightDetailTableViewCell.h"

@interface FlightDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

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
    // Do any additional setup after loading the view from its nib.
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
    static NSString *FLIGHTDETAIL_TABLECELL_IDENTIFIER = @"FLIGHTDETAIL_TABLECELL_IDENTIFIER";
    FlightDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FLIGHTDETAIL_TABLECELL_IDENTIFIER];
    if (cell==nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FlightDetailTableViewCell" owner:nil options:nil][0];
    }
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
