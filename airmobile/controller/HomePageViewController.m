//
//  HomePageViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/9.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "HomePageViewController.h"
#import "FlightViewController.h"
#import "MessageViewController.h"
#import "FunctionViewController.h"
#import "UserInfoViewController.h"
#import "ReleasedRatioViewController.h"
#import "FlightHourViewController.h"
#import "AlertIndicateViewController.h"
#import "ArrDepFlightHourViewController.h"
#import "FlightAbnViewController.h"
#import "PassengerHourViewController.h"
#import "SecurityPsnViewController.h"
#import "PassengerTopViewController.h"
#import "SeatUsedViewController.h"
#import "HomePageService.h"

#import "ResourceOverview.h"

#import "SingleMessageViewController.h"
#import "HttpsUtils+Business.h"
#import "AppDelegate.h"



@interface HomePageViewController ()

@property (nonatomic, strong) NSArray *titleLabelArray;


@end

@implementation HomePageViewController
{
    CGFloat titleHeight;
    CGFloat titleLableHeight;
    CGFloat titleLableSize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [HttpsUtils sysChatInfoList:(int)(appDelegate.userInfoModel.id)];
    
    self.view.backgroundColor = [UIColor whiteColor]; // 全局背景颜色
    [self initInchData];

    //TabBer自定义
    self.tabBarView = [[TabBarView alloc] initTabBarWithModel:TabBarBgModelHomePage
                                                 selectedType:TabBarSelectedTypeHomePage
                                                     delegate:self];
    [self.view insertSubview:self.tabBarView
                aboveSubview:self.view];
    [self initPageTitle];

    homePageType = HomePageTypeOverview;//设置当前页面为整体概览
    [self showOverviewContentView];//根据显示类型显示页面

    
}


/**
 初始化各组件大小及尺寸方便以后适配
 */
-(void) initInchData
{
    titleHeight = 76;
    titleLableHeight = 17;
    titleLableSize = 17;
}

/**
 初始化本业的Title
 */
-(void) initPageTitle
{
    [self titleViewInitWithHight:76];
    
    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      kScreenWidth,
                                                                      76)];
    titleLabelView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];

    NSArray *titleArray = @[@"总体",@"航班",@"旅客",@"机位"];
    NSMutableArray *titleMutableArray = [[NSMutableArray alloc]initWithArray:titleArray];
    if (![CommonFunction hasFunction:OV_CRAFTSEAT]){
        [titleMutableArray removeObjectAtIndex:3];
    }
    if (![CommonFunction hasFunction:OV_PASSENGER]) {
        [titleMutableArray removeObjectAtIndex:2];
    }
    if (![CommonFunction hasFunction:OV_FLIGHT]) {
        [titleMutableArray removeObjectAtIndex:1];
    }
    if (![CommonFunction hasFunction:OV_WHOLE]) {
        [titleMutableArray removeObjectAtIndex:0];
    }



    NSMutableArray *labelArray = [NSMutableArray array];
    for (int i = 0 ; i<titleMutableArray.count; i++) {

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*kScreenWidth/titleMutableArray.count, 30, kScreenWidth/titleMutableArray.count, titleHeight-30)];
        label.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
        label.text      = titleMutableArray[i];
        label.font      =  [UIFont fontWithName:@"PingFangSC-Regular"
                                                   size:px2(37)];
        label.textAlignment = NSTextAlignmentCenter;
        [titleLabelView addSubview:label];

//        label.backgroundColor = [UIColor greenColor];


        [labelArray addObject:label];


        UIButton *button = [[UIButton alloc] initWithFrame:label.frame];
        button.tag     = i;
        [button addTarget:self
                        action:@selector(titleButtonClickedWithSender:)
              forControlEvents:UIControlEventTouchUpInside];
        //    overviewBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];//显示按键范围
        [titleLabelView addSubview:button];


    }
    _titleLabelArray = [labelArray copy];
    if (_titleLabelArray.count>0) {
        ((UILabel *)_titleLabelArray[0]).textColor = [CommonFunction colorFromHex:0XbFFFFFFF];
        selectedLine = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    kScreenWidth/titleMutableArray.count-16,
                                                                    6)];
        selectedLine.center = CGPointMake(kScreenWidth/(titleMutableArray.count*2), 74);
        selectedLine.image  = [UIImage imageNamed:@"SelectedLine"];
        [titleLabelView addSubview:selectedLine];
    }
}

#pragma mark 切换首页中各子页面
/**
 点击标题切换内容

 @param sender 按钮
 */
-(void) titleButtonClickedWithSender:(UIButton *)sender
{
    for (UILabel *label in _titleLabelArray) {
        label.textColor = [CommonFunction colorFromHex:0XbFFFFFFF];
    }
    
    [self removeAllView];

    selectedLine.center     = CGPointMake(kScreenWidth/(_titleLabelArray.count*2) *(sender.tag*2+1), 74);
    ((UILabel *)_titleLabelArray[sender.tag]).textColor = [CommonFunction colorFromHex:0XFFFFFFFF];

    NSString *title = ((UILabel *)_titleLabelArray[sender.tag]).text;


    if ([title isEqualToString:@"总体"]) {
        homePageType = HomePageTypeOverview;
        [self showOverviewContentView];
    }else if([title isEqualToString:@"航班"]){
        homePageType = HomePageTypeFlight;
        [self showFlightContentView];
    }else if([title isEqualToString:@"旅客"]){
        homePageType = HomePageTypePassenger;
        [self showPassengerContentView];
    }else if([title isEqualToString:@"机位"]){
        homePageType = HomePageTypeResource;
        [self showResourceContentView];
    }
}



/**
 显示整体情况视图
 */
-(void)showOverviewContentView
{
    if (overviewContentView !=nil)
    {
        return;
    }
    else
    {
        
        overviewContentView = [[OverViewContentView alloc]initWithFrame: CGRectMake(0,
                                                                                    self.titleView.frame.size.height,
                                                                                    kScreenWidth,
                                                                                    kScreenHeight-viewHeight(self.titleView)-viewHeight(self.tabBarView))

                                                               delegate:self];
        [self.view addSubview:overviewContentView];
    }
}

/**
 显示航班信息视图
 */
-(void)showFlightContentView
{
    if (flightContentView !=nil)
    {
        return;
    }
    else
    {
        flightContentView = [[FlightContentView alloc] initWithFrame:CGRectMake(0,
                                                                                100,
                                                                                kScreenWidth,
                                                                                kScreenHeight-100-49)
                                                            delegate:self];
        [self.view addSubview:flightContentView];
    }
}

/**
 显示旅客信息视图
 */
-(void)showPassengerContentView
{
    if (passengerContentView !=nil)
    {
        return;
    }
    else
    {
        passengerContentView = [[PassengerContentView alloc] initWithFrame:CGRectMake(0,
                                                                                      76,
                                                                                      kScreenWidth,
                                                                                      kScreenHeight-100-49)
                                                            PassengerModel:[HomePageService sharedHomePageService].psnModel
                                                                  delegate:self];
        [self.view addSubview:passengerContentView];
    }
}

/**
 显示资源信息视图
 */
-(void)showResourceContentView
{
    if (resourceContentView !=nil)
    {
        return;
    }
    else
    {
        resourceContentView = [[ResourceOverview alloc]initWithFrame:CGRectMake(0, 76, kScreenWidth, kScreenHeight-80-49) delegate:self];

        [self.view addSubview:resourceContentView];


    }
}

/**
 将子view移除
 */
-(void)removeAllView
{
    [overviewContentView removeFromSuperview];
    overviewContentView = nil;
    
    [passengerContentView removeFromSuperview];
    passengerContentView = nil;
    
    [flightContentView removeFromSuperview];
    flightContentView = nil;
    
    [resourceContentView removeFromSuperview];
    resourceContentView = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 整体汇总页跳转方法

/**
 展示放行正常率视图
 */
-(void) showReleasedRatioView
{
    ReleasedRatioViewController *ratio = [[ReleasedRatioViewController alloc] init];
    [self.navigationController pushViewController:ratio
                                         animated:YES];
}

/**
 展示航班小时分布视图
 */
-(void) showFlightHourView{


    FlightHourViewController *flightHour = [[FlightHourViewController alloc] initWithFlightHours:[HomePageService sharedHomePageService].summaryModel.flightHours];
    [self.navigationController pushViewController:flightHour
                                         animated:YES];
}

/**
 展示小面积延误视图
 */
-(void) showWorningIndicatorView{
    AlertIndicateViewController *alert = [[AlertIndicateViewController alloc] initWithDalayTagart:[HomePageService sharedHomePageService].summaryModel.delayTagart];
    [self.navigationController pushViewController:alert
                                         animated:YES];
}
#pragma mark - 航班汇总页跳转方法

/**
 展示航班进出港小时分布视、即将出港的航班列表
 */
-(void) showFlightHourView:(FlightHourType) type
{
//    ArrDepFlightHourViewController *arrDepController = [[ArrDepFlightHourViewController alloc]initWithDataArray:_flighStusModel.flightHours];
    ArrDepFlightHourViewController *arrDepController = [[ArrDepFlightHourViewController alloc]initWithDataArray:[HomePageService sharedHomePageService].summaryModel.flightHours];
    arrDepController.hourType = type;
    [self.navigationController pushViewController:arrDepController
                                         animated:YES];
}

/**
 展示航班异常原因分类、各地区平均延误时间图
 */
-(void) showFlightAbnnormalView{
    FlightAbnViewController *abn = [[FlightAbnViewController alloc] init];
    [self.navigationController pushViewController:abn
                                         animated:YES];
}

#pragma mark - 旅客汇总页跳转方法

/**
 展示旅客小时分布
 */
-(void) showPassengerHourView{
    PassengerHourViewController *psnHour = [[PassengerHourViewController alloc] initWithDataArray:[HomePageService sharedHomePageService].psnModel.psnHours];
    [self.navigationController pushViewController:psnHour
                                         animated:YES];
    
}

/**
 展示隔离区内旅客小时分布、当前隔离区内各区域旅客分布
 */
-(void) showSecurityPassengerView{
    SecurityPsnViewController *security = [[SecurityPsnViewController alloc] initWithPassengerModel:[HomePageService sharedHomePageService].psnModel];
    [self.navigationController pushViewController:security
                                         animated:YES];
}

-(void)showTop5DaysView{
    PassengerTopViewController *security = [[PassengerTopViewController alloc] init];
    [self.navigationController pushViewController:security
                                         animated:YES];
}


#pragma mark - 资源汇总页跳转方法

/**
 展示机位的使用详细信息
 */
-(void) showSeatUsedMainDetailView{
    SeatUsedViewController *seatUsed = [[SeatUsedViewController alloc]initWithCraftseatCntModel:[HomePageService sharedHomePageService].seatModel
                                                                                           type:SeatUsedViewControllerTypeMain];
    [self.navigationController pushViewController:seatUsed
                                         animated:YES];
}

-(void) showSeatUsedSubDetailView
{
    SeatUsedViewController *seatUsed = [[SeatUsedViewController alloc]initWithCraftseatCntModel:[HomePageService sharedHomePageService].seatModel
                                                                                           type:SeatUsedViewControllerTypeSub];
    [self.navigationController pushViewController:seatUsed
                                         animated:YES];

}

@end
