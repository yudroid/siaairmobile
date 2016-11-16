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

@interface HomePageViewController ()

@end

@implementation HomePageViewController
{
    CGFloat titleHeight;
    CGFloat titleLableHeight;
    CGFloat titleLableSize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor]; // 全局背景颜色
    [self initInchData];
    [self initPageTitle];
    
    //TabBer自定义
    self.tabBarView = [[TabBarView alloc] initTabBarWithModel:TabBarBgModelHomePage selectedType:TabBarSelectedTypeHomePage delegate:self];
    [self.view insertSubview:self.tabBarView aboveSubview:self.view];
    
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
    
    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 76)];
    titleLabelView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];
    
    // 当前选中的标记线
//    selectedLine = [CommonFunction addLine:CGRectMake(0, 0, kScreenWidth/4-16, 2.5) color:[UIColor redColor]];
//    selectedLine.center = CGPointMake(kScreenWidth/8, 74);
//    [titleLabelView addSubview:selectedLine];
    selectedLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/4-16, 6)];
    selectedLine.center = CGPointMake(kScreenWidth/8, 74);
    selectedLine.image = [UIImage imageNamed:@"SelectedLine"];
    [titleLabelView addSubview:selectedLine];

    overviewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/4, titleLableHeight)];//整体概览
    overviewLabel.center = CGPointMake(kScreenWidth/8, 57);
    overviewLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
    overviewLabel.text = @"整体";
    overviewLabel.font = [UIFont systemFontOfSize:titleLableSize];
    overviewLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabelView addSubview:overviewLabel];
    
    UIButton *overviewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/4, 50)];
    overviewBtn.center = CGPointMake(kScreenWidth/8, 57);
    overviewBtn.tag = 0;
    [overviewBtn addTarget:self action:@selector(titleButtonClickedWithSender:) forControlEvents:UIControlEventTouchUpInside];
    //    overviewBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];//显示按键范围
    [titleLabelView addSubview:overviewBtn];
    
    
    flightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/4, titleLableHeight)];//航班
    flightLabel.center = CGPointMake(kScreenWidth*3/8, 57);
    flightLabel.textColor = [CommonFunction colorFromHex:0X7FFFFFFF];
    flightLabel.text = @"航班";
    flightLabel.textAlignment = NSTextAlignmentCenter;
    flightLabel.font = [UIFont systemFontOfSize:titleLableSize];
    [titleLabelView addSubview:flightLabel];
    
    UIButton *flightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/4, 50)];
    flightBtn.center = CGPointMake(kScreenWidth*3/8, 57);
    flightBtn.tag = 1;
    [flightBtn addTarget:self action:@selector(titleButtonClickedWithSender:) forControlEvents:UIControlEventTouchUpInside];
    //    securityBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];//显示按键范围
    [titleLabelView addSubview:flightBtn];
    
    passengerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/4, titleLableHeight)];//旅客
    passengerLabel.center = CGPointMake(kScreenWidth*5/8, 57);
    passengerLabel.textColor = [CommonFunction colorFromHex:0X7FFFFFFF];
    passengerLabel.text = @"旅客";
    passengerLabel.textAlignment = NSTextAlignmentCenter;
    passengerLabel.font = [UIFont systemFontOfSize:titleLableSize];
    [titleLabelView addSubview:passengerLabel];
    
    UIButton *passengerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/4, 50)];
    passengerBtn.center = CGPointMake(kScreenWidth*5/8, 57);
    passengerBtn.tag = 2;
    [passengerBtn addTarget:self action:@selector(titleButtonClickedWithSender:) forControlEvents:UIControlEventTouchUpInside];
    //    securityBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];//显示按键范围
    [titleLabelView addSubview:passengerBtn];
    
    resourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/4,titleLableHeight)];//资源
    resourceLabel.center = CGPointMake(kScreenWidth-kScreenWidth/8, 57);
    resourceLabel.textColor = [CommonFunction colorFromHex:0X7FFFFFFF];
    resourceLabel.text = @"资源";
    resourceLabel.textAlignment = NSTextAlignmentCenter;
    resourceLabel.font = [UIFont systemFontOfSize:titleLableSize];
    [titleLabelView addSubview:resourceLabel];
    
    UIButton *resourceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/4, 50)];
    resourceBtn.center = CGPointMake(kScreenWidth-kScreenWidth/8, 57);
    resourceBtn.tag = 3;
    [resourceBtn addTarget:self action:@selector(titleButtonClickedWithSender:) forControlEvents:UIControlEventTouchUpInside];
    //    resourceBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];//显示按键范围
    [titleLabelView addSubview:resourceBtn];

}

#pragma mark 切换首页中各子页面
/**
 点击标题切换内容

 @param sender 按钮
 */
-(void) titleButtonClickedWithSender:(UIButton *)sender
{
    overviewLabel.textColor = [CommonFunction colorFromHex:0X7FFFFFFF];
    flightLabel.textColor = [CommonFunction colorFromHex:0X7FFFFFFF];
    passengerLabel.textColor = [CommonFunction colorFromHex:0x7FFFFFFF];
    resourceLabel.textColor = [CommonFunction colorFromHex:0X7FFFFFFF];
    
    [self removeAllView];
    
    switch (sender.tag)
    {
        case 0:
            selectedLine.center = CGPointMake(kScreenWidth/8, 74);
            overviewLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
            homePageType = HomePageTypeOverview;
            [self showOverviewContentView];
            break;
            
        case 1:
            selectedLine.center = CGPointMake(kScreenWidth*3/8, 74);
            flightLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
            homePageType = HomePageTypeFlight;
            [self showFlightContentView];
            break;
            
        case 2:
            selectedLine.center = CGPointMake(kScreenWidth*5/8, 74);
            passengerLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
            homePageType = HomePageTypePassenger;
            [self showPassengerContentView];
            break;
            
        case 3:
            selectedLine.center = CGPointMake(kScreenWidth-kScreenWidth/8, 74);
            resourceLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
            homePageType = HomePageTypeResource;
            [self showResourceContentView];
            break;
            
        default:
            break;
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
        overviewContentView = [[OverViewContentView alloc]
                               initWithFrame:
                               CGRectMake(0, self.titleView.frame.size.height, kScreenWidth, kScreenHeight-self.titleView.frame.size.height-self.tabBarView.frame.size.height)
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
        flightContentView = [[FlightContentView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight-189) delegate:self];
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
        passengerContentView = [[PassengerContentView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight-189) delegate:self];
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
        resourceContentView = [[ResourceContentView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, kScreenHeight-135) delegate:self];
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

#pragma mark 切换底部主功能页面
-(void)selectWithType:(TabBarSelectedType)type
{
    switch (type) {
        case TabBarSelectedTypeHomePage:
        {
            HomePageViewController *homepage = [[HomePageViewController alloc] init];
            [self.navigationController pushViewController:homepage animated:NO];
            break;
        }
        case TabBarSelectedTypeFlight:
        {
            FlightViewController *flightpage = [[FlightViewController alloc] init];
            [self.navigationController pushViewController:flightpage animated:NO];
            break;
        }
        case TabBarSelectedTypeMessage:
        {
            MessageViewController *messagepage = [[MessageViewController alloc] init];
            [self.navigationController pushViewController:messagepage animated:NO];
            break;
        }
        case TabBarSelectedTypeFunction:
        {
            FunctionViewController *function = [[FunctionViewController alloc] init];
            [self.navigationController pushViewController:function animated:NO];
            break;
        }
        case TabBarSelectedTypeUserInfo:
        {
            UserInfoViewController *userInfo = [[UserInfoViewController alloc] init];
            [self.navigationController pushViewController:userInfo animated:NO];
            break;
        }
        default:
            break;
    }
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
    [self.navigationController pushViewController:ratio animated:YES];
}

/**
 展示航班小时分布视图
 */
-(void) showFlightHourView{
    FlightHourViewController *flightHour = [[FlightHourViewController alloc] init];
    [self.navigationController pushViewController:flightHour animated:YES];
}

/**
 展示航延4个指标视图
 */
-(void) showWorningIndicatorView{
    AlertIndicateViewController *alert = [[AlertIndicateViewController alloc] init];
    [self.navigationController pushViewController:alert animated:YES];
}
#pragma mark - 航班汇总页跳转方法

/**
 展示航班进出港小时分布视、即将出港的航班列表
 */
-(void) showFlightHourView:(FlightHourType) type
{
    ArrDepFlightHourViewController *arrDepController = [[ArrDepFlightHourViewController alloc]init];
    arrDepController.hourType = type;
    [self.navigationController pushViewController:arrDepController animated:YES];
}

/**
 展示航班异常原因分类、各地区平均延误时间图
 */
-(void) showFlightAbnnormalView{
    FlightAbnViewController *abn = [[FlightAbnViewController alloc] init];
    [self.navigationController pushViewController:abn animated:YES];
}

#pragma mark - 旅客汇总页跳转方法

/**
 展示旅客小时分布
 */
-(void) showPassengerHourView{
    PassengerHourViewController *psnHour = [[PassengerHourViewController alloc] init];
    [self.navigationController pushViewController:psnHour animated:YES];
}

/**
 展示隔离区内旅客小时分布、当前隔离区内各区域旅客分布
 */
-(void) showSecurityPassengerView{
    SecurityPsnViewController *security = [[SecurityPsnViewController alloc] init];
    [self.navigationController pushViewController:security animated:YES];
}

-(void)showTop5DaysView{
    PassengerTopViewController *security = [[PassengerTopViewController alloc] init];
    [self.navigationController pushViewController:security animated:YES];
}


#pragma mark - 资源汇总页跳转方法

/**
 展示机位的使用详细信息
 */
-(void) showSeatUsedDetailView{
    SeatUsedViewController *seatUsed = [[SeatUsedViewController alloc] init];
    [self.navigationController pushViewController:seatUsed animated:YES];
}

@end
