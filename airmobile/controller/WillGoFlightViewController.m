//
//  WillGoFlightViewController.m
//  airmobile
//
//  Created by xuesong on 2017/4/18.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "WillGoFlightViewController.h"
#import "HttpsUtils+Business.h"
#import "WillGoFlightModel.h"
#import "UIViewController+Reminder.h"
#import "WillGoFlightTableViewCell.h"
#import "FlightDetailViewController.h"


const NSString *WILLGOFLIGHT_TABLECELL_IDENTIFIER = @"WILLGOFLIGHT_TABLECELL_IDENTIFIER";

@interface WillGoFlightViewController ()

@property (nonatomic, copy) NSArray *tableArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WillGoFlightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];
    _tableArray = @[];
//    _tableView.allowsSelection = NO;
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerNib:[UINib nibWithNibName:@"WillGoFlightTableViewCell" bundle:nil] forCellReuseIdentifier:(NSString *)WILLGOFLIGHT_TABLECELL_IDENTIFIER];
    [self loadDate];
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"即将放行航班"];
    [self titleViewAddBackBtn];

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
    WillGoFlightTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)WILLGOFLIGHT_TABLECELL_IDENTIFIER];
    WillGoFlightModel *model = _tableArray[indexPath.row];
    cell.index = indexPath.row+1;
    cell.willGoFlightModel = model;
    if (indexPath.row%2==0) {
        cell.backgroundColor = [CommonFunction colorFromHex:0xFFFFFFFF];
    }else{
        cell.backgroundColor = [CommonFunction colorFromHex:0xFFF0F7FA];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    FlightDetailViewController *flightDetailVC = [[FlightDetailViewController alloc]initWithNibName:@"FlightDetailViewController"
                                                                                             bundle:nil];
    WillGoFlightModel *model = _tableArray[indexPath.row];
    flightDetailVC.flightNo = model.flyno;
    flightDetailVC.flightId = (int)model.id;

    if ([model.flagAD isEqualToString:@"1"]) {
        flightDetailVC.flightType = FlightTypeInOut;
    }else if ([model.flagAD isEqualToString:@"2"]){
        flightDetailVC.flightType = FlightTypeIn;
    }else{
        flightDetailVC.flightType =FlightTypeOut;
    }
    [self.navigationController pushViewController:flightDetailVC animated:YES];

}


-(void)loadDate
{
    [HttpsUtils getflyoutList:^(NSDictionary *responsed) {
        NSLog(@"");
        _tableArray = [[responsed objectForKey:@"data"] DictionaryToModel:[WillGoFlightModel class]];
        [_tableView reloadData];
        
    } failure:^(id error) {

    }];
}
@end
