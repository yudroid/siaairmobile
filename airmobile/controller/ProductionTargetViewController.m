//
//  ProductionTargetViewController.m
//  KaiYa
//
//  Created by WangShiran on 16/2/26.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "ProductionTargetViewController.h"
#import "POP.h"
#import "DateUtils.h"


@interface ProductionTargetViewController ()

@end

@implementation ProductionTargetViewController{
    NSDate *today;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg.png"]];
    [self titleViewInit];
    
    kpi = [[FunctionService sharedFunctionService] getProductionKpi];
    today = [DateUtils getNow];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 140, kScreenWidth, 365+42)];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(kScreenWidth*2, 365);
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled = YES;
//    scrollView.backgroundColor = [CommonFunction colorFromHex:0x7FFFFFFF];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    annualTargetView = [[AnnualTargetView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,365+42)];
    [scrollView addSubview:annualTargetView];
    annualTargetView.titleText = [NSString stringWithFormat:@"%@年度航班架次指标",[DateUtils convertToString:today format:@"yyyy"]];
    annualTargetView.annualPlanProportion = round(kpi.flightY.finishedRatio*100)/100; // 实际完成比例
    annualTargetView.planFinishProportion = round(kpi.flightY.planRatio*100)/100;// 计划完成比例
    annualTargetView.annualPlanNum = kpi.flightY.yearPlan; // 年度计划
    annualTargetView.planFinishNum = kpi.flightY.planFinished; // 计划完成
    annualTargetView.finishedNum   = kpi.flightY.finished; // 已经完成
    annualTargetView.isUp = (kpi.flightY.finishedRatio>=kpi.flightY.planRatio)?YES:NO; // 较实际偏高YES或偏低No
    annualTargetView.progressRoundPlanNum = round(fabsf(kpi.flightY.finishedRatio-kpi.flightY.planRatio)*100);
    
    monthlyTargetView = [[MonthlyTargetView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, 365+42)];
    [scrollView addSubview:monthlyTargetView];
    monthlyTargetView.titleText = @"月度航班架次指标";
    monthlyTargetView.secondTitleText = [NSString stringWithFormat:@"(%@)",[DateUtils convertToString:today format:@"yyyy-MM"]];
    monthlyTargetView.proportion = round(kpi.flightM.ratio*100)/100;
    monthlyTargetView.monthlyPlanNum = kpi.flightM.monthPlan;
    monthlyTargetView.finishedNum = kpi.flightM.finished;
    
    pageDot=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    pageDot.center = CGPointMake(kScreenWidth/2, 610);
    pageDot.numberOfPages = 2;
    pageDot.userInteractionEnabled = NO;
    pageDot.pageIndicatorTintColor = [CommonFunction colorFromHex:0X7F17B9E8];
    pageDot.currentPageIndicatorTintColor = [CommonFunction colorFromHex:0XFF17B9E8];
    [self.view addSubview:pageDot];
    
    if ([DeviceInfoUtil IphoneVersions]==6.5)
    {
        scrollView.frame = CGRectMake(0, 180, kScreenWidth, 365+42);
        pageDot.center = CGPointMake(kScreenWidth/2, 640);
    }
}

#pragma mark scrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)sc
{
    NSInteger page = sc.contentOffset.x/kScreenWidth;
    NSLog(@"%ld",page);
    [pageDot setCurrentPage:page];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

#pragma mark TitleView方法

- (void)titleViewInit{
    [self titleViewInitWithHight:140];
    self.titleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self titleViewAddTitleText:@"今日值班表"];
    [self titleViewAddBackBtn];
    
//    iconBg = [CommonFunction imageView:@"home_iconBg" frame:CGRectMake(0, 0, 49, 49)];
//    iconBg.center = CGPointMake(kScreenWidth/2-80, 112);
//    [self.titleView addSubview:iconBg];

    overviewIcon = [CommonFunction imageView:@"home_overview_pass" frame:CGRectMake(0, 0, 42, 42)];
    overviewIcon.center = CGPointMake(kScreenWidth/2-80, 112);
    [self.titleView addSubview:overviewIcon];
    
    UIButton *overviewIconBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    overviewIconBtn.center = CGPointMake(kScreenWidth/2-80, 112);
    overviewIconBtn.tag = 3;
    [overviewIconBtn addTarget:self action:@selector(iconButtonClickedWithSender:) forControlEvents:UIControlEventTouchUpInside];
    //    overviewIconBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];//显示按键范围
    [self.titleView addSubview:overviewIconBtn];
    
    guaranteeIcon = [CommonFunction imageView:@"home_guarantee" frame:CGRectMake(0, 0, 42, 42)];
    guaranteeIcon.center = CGPointMake(kScreenWidth/2, 112);
    [self.titleView addSubview:guaranteeIcon];
    
    UIButton *guaranteeIconBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    guaranteeIconBtn.center = CGPointMake(kScreenWidth/2, 112);
    guaranteeIconBtn.tag = 4;
    [guaranteeIconBtn addTarget:self action:@selector(iconButtonClickedWithSender:) forControlEvents:UIControlEventTouchUpInside];
    //    guaranteeIconBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];//显示按键范围
    [self.titleView addSubview:guaranteeIconBtn];
    
    resourcesIcon = [CommonFunction imageView:@"production_goods" frame:CGRectMake(0, 0, 42, 42)];
    resourcesIcon.center = CGPointMake(kScreenWidth/2+80, 112);
    [self.titleView addSubview:resourcesIcon];
    
    UIButton *resourcesIconIconBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    resourcesIconIconBtn.center = CGPointMake(kScreenWidth/2+80, 112);
    resourcesIconIconBtn.tag = 5;
    [resourcesIconIconBtn addTarget:self action:@selector(iconButtonClickedWithSender:) forControlEvents:UIControlEventTouchUpInside];
    //    resourcesIconIconBtn.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];//显示按键范围
    [self.titleView addSubview:resourcesIconIconBtn];
}


-(void)titleViewInitWithHight:(CGFloat)high
{
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, high)];
    self.titleView .backgroundColor = [CommonFunction colorFromHex:0XFF21395C];
    self.titleView.clipsToBounds = YES;
    [self.view insertSubview:self.titleView  aboveSubview:self.view];
}

- (void)titleViewAddTitleText:(NSString *)titleText
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    titleLabel.text = titleText;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [CommonFunction colorFromHex:0XFFFFFFFF];
    titleLabel.backgroundColor = [UIColor clearColor];
    [self.titleView addSubview:titleLabel];
}

- (UIButton *)titleViewAddBackBtn
{
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, 20, 51, 44)];
    backBtn.backgroundColor = [UIColor clearColor];
    //    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [backBtn setImage:[UIImage imageNamed:@"btn_back"] forState:(UIControlStateNormal)];
    [backBtn setImage:[UIImage imageNamed:@"btn_back_pre"] forState:(UIControlStateSelected)];
    [self.titleView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    backBtn.backgroundColor = [UIColor redColor];
    return backBtn;
}

#pragma mark Button方法

- (void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)iconButtonClickedWithSender:(UIButton *)sender
{
    overviewIcon.image = [UIImage imageNamed:@"home_overview.png"];
    guaranteeIcon.image = [UIImage imageNamed:@"home_guarantee.png"];
    resourcesIcon.image = [UIImage imageNamed:@"production_goods.png"];
    pageDot.currentPage = 0;
        switch (sender.tag)
        {
            case 3:
                overviewIcon.image = [UIImage imageNamed:@"home_overview_pass.png"];
                [scrollView setContentOffset:CGPointMake(0, 0) animated:false];
                annualTargetView.titleText = [NSString stringWithFormat:@"%@年度航班架次指标",[DateUtils convertToString:today format:@"yyyy"]];
                annualTargetView.annualPlanProportion = round(kpi.flightY.finishedRatio*100)/100; // 实际完成比例
                annualTargetView.planFinishProportion = round(kpi.flightY.planRatio*100)/100;// 计划完成比例
                annualTargetView.unitLabelText = @"单位:架次";
                annualTargetView.annualPlanNum = kpi.flightY.yearPlan; // 年度计划
                annualTargetView.planFinishNum = kpi.flightY.planFinished; // 计划完成
                annualTargetView.finishedNum   = kpi.flightY.finished; // 已经完成
                annualTargetView.isUp = (kpi.flightY.finishedRatio>=kpi.flightY.planRatio)?YES:NO; // 较实际偏高YES或偏低No
                annualTargetView.progressRoundPlanNum = round(fabsf(kpi.flightY.finishedRatio-kpi.flightY.planRatio)*100);
                annualTargetView.labelFlag = 0;
                
                monthlyTargetView.titleText = @"月度航班架次指标";
                monthlyTargetView.secondTitleText = [NSString stringWithFormat:@"(%@)",[DateUtils convertToString:today format:@"yyyy-MM"]];
                monthlyTargetView.proportion = round(kpi.flightM.ratio*100)/100;
                monthlyTargetView.unitLabelText = @"单位:架次";
                monthlyTargetView.proportion = kpi.flightM.ratio;
                monthlyTargetView.monthlyPlanNum = kpi.flightM.monthPlan;
                monthlyTargetView.finishedNum = kpi.flightM.finished;
                monthlyTargetView.labelFlag = 0;
                
                [self animationWithCenter:overviewIcon.center];
                
                break;
    
            case 4:
                guaranteeIcon.image = [UIImage imageNamed:@"home_guarantee_pass.png"];
                [scrollView setContentOffset:CGPointMake(0, 0) animated:false];
                
                annualTargetView.titleText = [NSString stringWithFormat:@"%@年度旅客吞吐量指标",[DateUtils convertToString:today format:@"yyyy"]];
                annualTargetView.annualPlanProportion = round(kpi.passengerY.finishedRatio*100)/100; // 实际完成比例
                annualTargetView.planFinishProportion = round(kpi.passengerY.planRatio*100)/100;// 计划完成比例
                annualTargetView.unitLabelText = @"单位:万人次";
                annualTargetView.annualPlanNum = kpi.passengerY.yearPlan*1.0/10000; // 年度计划
                annualTargetView.planFinishNum = kpi.passengerY.planFinished*1.0/10000; // 计划完成
                annualTargetView.finishedNum   = kpi.passengerY.finished*1.0/10000; // 已经完成
                annualTargetView.isUp = (kpi.passengerY.finishedRatio>=kpi.passengerY.planRatio)?YES:NO; // 较实际偏高YES或偏低No
                annualTargetView.progressRoundPlanNum = round(fabsf(kpi.passengerY.finishedRatio-kpi.passengerY.planRatio)*100);
                annualTargetView.labelFlag = 2;
                
                //monthlyTargetView.titleText = [NSString stringWithFormat:@"%@月度旅客指标",[DateUtils convertToString:today format:@"yyyy-M"]];
                monthlyTargetView.titleText = @"月度旅客吞吐量指标";
                monthlyTargetView.secondTitleText = [NSString stringWithFormat:@"(%@)",[DateUtils convertToString:today format:@"yyyy-MM"]];
                monthlyTargetView.proportion = round(kpi.passengerM.ratio*100)/100;
                monthlyTargetView.unitLabelText = @"单位:万人次";
                monthlyTargetView.proportion = kpi.passengerM.ratio;
                monthlyTargetView.monthlyPlanNum = kpi.passengerM.monthPlan*1.0/10000;
                monthlyTargetView.finishedNum = kpi.passengerM.finished*1.0/10000;
                monthlyTargetView.labelFlag = 2;
                
                [self animationWithCenter:guaranteeIcon.center];
                break;
    
            case 5:
                resourcesIcon.image = [UIImage imageNamed:@"production_goods_pass.png"];
                [scrollView setContentOffset:CGPointMake(0, 0) animated:false];
                
                annualTargetView.titleText = [NSString stringWithFormat:@"%@年度货邮吞吐量指标",[DateUtils convertToString:today format:@"yyyy"]];
                annualTargetView.annualPlanProportion = round(kpi.cargoY.finishedRatio*100)/100; // 实际完成比例
                annualTargetView.planFinishProportion = round(kpi.cargoY.planRatio*100)/100;// 计划完成比例
                annualTargetView.unitLabelText = @"单位:吨";
                annualTargetView.annualPlanNum = kpi.cargoY.yearPlan*1.0/1000; // 年度计划
                annualTargetView.planFinishNum = kpi.cargoY.planFinished*1.0/1000; // 计划完成
                annualTargetView.finishedNum   = kpi.cargoY.finished*1.0/1000; // 已经完成
                annualTargetView.isUp = (kpi.cargoY.finishedRatio>=kpi.cargoY.planRatio)?YES:NO; // 较实际偏高YES或偏低No
                annualTargetView.progressRoundPlanNum = round(fabsf(kpi.cargoY.finishedRatio-kpi.cargoY.planRatio)*100);
                annualTargetView.labelFlag = 0;
                
                //monthlyTargetView.titleText = [NSString stringWithFormat:@"%@月度货邮指标",[DateUtils convertToString:today format:@"yyyy-M"]];
                monthlyTargetView.titleText = @"月度货邮吞吐量指标";
                monthlyTargetView.secondTitleText = [NSString stringWithFormat:@"(%@)",[DateUtils convertToString:today format:@"yyyy-MM"]];
                monthlyTargetView.proportion = round(kpi.cargoM.ratio*100)/100;
                monthlyTargetView.unitLabelText = @"单位:吨";
                monthlyTargetView.proportion = kpi.cargoM.ratio;
                monthlyTargetView.monthlyPlanNum = kpi.cargoM.monthPlan*1.0/1000;
                monthlyTargetView.finishedNum = kpi.cargoM.finished*1.0/1000;
                monthlyTargetView.labelFlag = 0;
                
                [self animationWithCenter:resourcesIcon.center];
                break;
    
            default:
                break;
        }
}

//格式话小数 四舍五入类型
- (float) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    float temp =  [[numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]] floatValue];
    return temp;
}

#pragma mark 其他方法

-(void)animationWithCenter:(CGPoint)center
{
    POPSpringAnimation * bAni = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    bAni.toValue = [NSValue valueWithCGPoint:center];
    bAni.springBounciness = 15;
    bAni.springSpeed = 20;
    bAni.removedOnCompletion = NO;
    
    
    [iconBg  pop_addAnimation:bAni forKey:@"IconBgAnimation"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
