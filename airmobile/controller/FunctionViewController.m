//
//  FunctionViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "FunctionViewController.h"
#import "FlightViewController.h"
#import "HomePageViewController.h"
#import "MessageViewController.h"
#import "UserInfoViewController.h"
#import "UserInfoTableViewCell.h"
#import "NightShiftRoomViewController.h"
#import "AddressBookViewController.h"
#import "TodayDutyViewController.h"
#import "DutyModel.h"
#import "ProductionTargetViewController.h"
#import "SingleMessageViewController.h"
#import "WeatherAirportController.h"
#import "FlightConcernViewController.h"

//#import <UMESDKKit/AirportFuctionWebViewController.h>
#import <UMESDKKit/UMESDKApi.h>

static const NSString *FUNCTION_TABLECELL_IDENTIFIER = @"FUNCTION_TABLECELL_IDENTIFIER";

@interface FunctionViewController ()<UITableViewDelegate,UITableViewDataSource,UMESDKApiDelegate>

@property (nonatomic,strong) UITableView    *tableView;
@property (nonatomic,strong) NSArray        *tableArray;

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTitleView];
    [self initTable];
    //TabBer自定义
    self.tabBarView = [[TabBarView alloc] initTabBarWithModel:TabBarBgModelHomePage
                                                 selectedType:TabBarSelectedTypeFunction
                                                     delegate:self];
    [self.view insertSubview:self.tabBarView aboveSubview:self.view];

    [UMESDKApi setTestMode:NO];
    [UMESDKApi registerApp:@"ume_8a82b52ffa074e07a846cbafa6dd712e" andAppKey:@"4ef7b30b11bc2634acb0b1abbd9e394f" andApiDelegate:self];
}

-(void)initTitleView
{
    //titleView订制
    [self titleViewInitWithHight:64];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"功能"];
}
-(void)initTable
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                              64,
                                                              kScreenWidth,
                                                              kScreenHeight-64-49)
                                             style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"UserInfoTableViewCell"
                                           bundle:nil]
     forCellReuseIdentifier:(NSString *)FUNCTION_TABLECELL_IDENTIFIER];
    _tableView.tableFooterView = [[UIView alloc]init];
//    _tableArray= @[@{@"name":@"通讯录",@"image":@"AddressBook"},
//                   @{@"name":@"值班表",@"image":@"WatchBill"},
//                   @{@"name":@"当日值班表",@"image":@"TodayDuty"},
//                   @{@"name":@"运营情况",@"image":@"WatchBill"},
//                   @{@"name":@"天气信息",@"image":@"WatchBill"},
//                   @{@"name":@"周边航线",@"image":@"WatchBill"}
////                   @{@"name":@"生产指标",@"image":@"TodayDuty"}
//                   ];

    NSMutableArray *mutableArray = [NSMutableArray array];
    if ([CommonFunction hasFunction:FUNC_ADDRESS]) {
        [mutableArray addObject:@{@"name":@"通讯录",@"image":@"AddressBook"}];
    }
    if ([CommonFunction hasFunction:FUNC_DUTYTABLE]) {
        [mutableArray addObject:@{@"name":@"值班表",@"image":@"WatchBill"}];
    }
    if ([CommonFunction hasFunction:FUNC_TODAYDUTY]) {
        [mutableArray addObject:@{@"name":@"当日值班表",@"image":@"TodayDuty"}];
    }
    if ([CommonFunction hasFunction:FUNC_TARGET]) {
        [mutableArray addObject:@{@"name":@"生产指标",@"image":@"site_icon2_value"}];
    }
    if ([CommonFunction hasFunction:FUNC_YYQK]) {
        [mutableArray addObject: @{@"name":@"运营情况",@"image":@"site_airport"}];
    }
    if ([CommonFunction hasFunction:FUNC_TQXX]) {
        [mutableArray addObject:@{@"name":@"天气信息",@"image":@"site_weather"}];
    }
    if ([CommonFunction hasFunction:FUNC_ZBHX]) {
        [mutableArray addObject:@{@"name":@"周边航线",@"image":@"site_around"}];
    }
    if ([CommonFunction hasFunction:FUNC_HBGZ]){
        [mutableArray addObject:@{@"name":@"航班关注",@"image":@"site_around"}];
    }
    _tableArray = [mutableArray copy];

    [self.view addSubview:_tableView];
}




#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)FUNCTION_TABLECELL_IDENTIFIER];
    NSDictionary *rowDic = _tableArray[indexPath.row];
    NSString *name = [rowDic objectForKey:@"name"];
    NSString *imageString = [rowDic objectForKey:@"image"];
    cell.nameLabel.text = name;
    cell.iconImageView.image = [UIImage imageNamed:imageString];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    NSDictionary *rowDic = _tableArray[indexPath.row];
    NSString *name = [rowDic objectForKey:@"name"];
    if ([name isEqualToString:@"值班表"]){
        NightShiftRoomViewController *nightShiftRoomVC = [[NightShiftRoomViewController alloc] initWithNibName:@"NightShiftRoomViewController" bundle:nil];
        [self.navigationController pushViewController:nightShiftRoomVC
                                             animated:YES];
    }else if ([name isEqualToString:@"通讯录"]){
        AddressBookViewController *addressBookVC = [[AddressBookViewController alloc] initWithNibName:@"AddressBookViewController"
                                                                                               bundle:nil];
        [self.navigationController pushViewController:addressBookVC
                                             animated:YES];
    }else if ([name isEqualToString:@"当日值班表"]){
        TodayDutyViewController *todayDutyVC = [[TodayDutyViewController alloc] initWithNibName:@"TodayDutyViewController"
                                                                                               bundle:nil];
        [self.navigationController pushViewController:todayDutyVC
                                             animated:YES];
    }else if ([name isEqualToString:@"生产指标"]){
        ProductionTargetViewController *productionTargetVC = [[ProductionTargetViewController alloc] init];
        [self.navigationController pushViewController:productionTargetVC
                                             animated:YES];
    }
    else if ([name isEqualToString:@"天气信息"]){
//        [HttpUtils accessLog:[HttpUtils userName] funcName:@"天气信息" success:nil failure:nil];
        WeatherAirportController* controller = [[WeatherAirportController alloc] init];
        controller.airportCode = localAirportIata;
        controller.functionId = @"weather";
        controller.title = @"天气信息";
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([name isEqualToString:@"运营情况"]){
//        [HttpUtils accessLog:[HttpUtils userName] funcName:@"运营情况" success:nil failure:nil];

        WeatherAirportController* controller = [[WeatherAirportController alloc] init];
        controller.airportCode = localAirportIata;
        controller.functionId = @"information";
        controller.title = @"运营情况";
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([name isEqualToString:@"周边航线"]){
        WeatherAirportController* controller = [[WeatherAirportController alloc] init];
        controller.airportCode = localAirportIata;
        controller.functionId = @"route";
        controller.title = @"周边航线";
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([name isEqualToString:@"航班关注"]){
        FlightConcernViewController *flightConcernVC = [[FlightConcernViewController alloc] initWithNibName:@"FlightConcernViewController" bundle:nil];
        [self.navigationController pushViewController:flightConcernVC animated:YES];
    }
}


-(void)callBackWithResponse:(UMEBaseResponse *) response{
    NSLog(@"back ----%@",response);
}


@end
