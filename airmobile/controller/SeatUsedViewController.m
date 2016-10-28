//
//  SeatUsedViewController.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "SeatUsedViewController.h"
#import "SeatUsedModel.h"
#import "RoundProgressView.h"
#import "LDProgressView.H"

@interface SeatUsedViewController ()

@end

@implementation SeatUsedViewController
{
    NSMutableArray<SeatUsedModel *> *array;
    CGFloat normalProportion;
    CGFloat abnormalProportion;
    CGFloat cancleProportion;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitle];
    
    //圆圈
    RoundProgressView *progressRound = [[RoundProgressView alloc] initWithCenter:CGPointMake(kScreenWidth/2, 65+25+86) radius:86
                                                                      aboveColos:@[(__bridge id)[CommonFunction colorFromHex:0XFF00C7E4].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF00F383].CGColor ]
                                                                      belowColos:@[(__bridge id)[CommonFunction colorFromHex:0XFFFF9F38].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFFCD21].CGColor ] start:150.0f end:45 clockwise:YES];
    [self.view addSubview:progressRound];
    
    normalProportion = 0.6;
    abnormalProportion = 0.66;
    cancleProportion = 0.75;
    
    //对数据进行动画
    [progressRound animationWithStrokeEnd:normalProportion withProgressType:ProgreesTypeNormal];
    [progressRound animationWithStrokeEnd:abnormalProportion withProgressType:ProgreesTypeAbnormal];
    [progressRound animationWithStrokeEnd:cancleProportion withProgressType:ProgreesTypeCancel];
    
    
    UILabel *totalNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 65+25+86-40, 100, 45)];// 机位总数
    totalNumLabel.text = @"325";
    totalNumLabel.textAlignment = NSTextAlignmentCenter;
    totalNumLabel.font = [UIFont systemFontOfSize:45];
    [self.view addSubview:totalNumLabel];
    
    UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 65+25+86+5, 100, 15)];
    totalLabel.text = @"机位";
    totalLabel.textAlignment = NSTextAlignmentCenter;
    totalLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:totalLabel];
    
    UILabel *inSeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-60, 65+25+86+5+15+5, 70, 15)];// 当前停占
    inSeatLabel.text = @"当前停占";
    inSeatLabel.textAlignment = NSTextAlignmentCenter;
    inSeatLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:inSeatLabel];
    
    UILabel *nightNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2+15, 65+25+86+5+15+5, 50, 15)];
    nightNumLabel.text = @"245";
    nightNumLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:nightNumLabel];
    
    
    UILabel *disAbleLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 65+25+86+5+15+5+65, kScreenWidth/4, 15)];// 不可用
    disAbleLabel.text = @"不可用";
    disAbleLabel.textAlignment = NSTextAlignmentCenter;
    disAbleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:disAbleLabel];
    
    UILabel *disable = [[UILabel alloc] initWithFrame:CGRectMake(0, 65+25+86+5+15+5+65+15+5, kScreenWidth/4, 15)];
    disable.text = @"3";
    disable.textAlignment = NSTextAlignmentCenter;
    disable.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:disable];
    
    UILabel *longInSeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4, 65+25+86+5+15+5+65, kScreenWidth/4, 15)];// 长期占用
    longInSeatLabel.text = @"长期占用";
    longInSeatLabel.textAlignment = NSTextAlignmentCenter;
    longInSeatLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:longInSeatLabel];
    
    UILabel *longInSeat = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4, 65+25+86+5+15+5+65+15+5, kScreenWidth/4, 15)];
    longInSeat.text = @"10";
    longInSeat.textAlignment = NSTextAlignmentCenter;
    longInSeat.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:longInSeat];
    
    UILabel *nightLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 65+25+86+5+15+5+65, kScreenWidth/4, 15)];// 过夜
    nightLabel.text = @"过夜停占";
    nightLabel.textAlignment = NSTextAlignmentCenter;
    nightLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:nightLabel];
    
    UILabel *nightNum = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 65+25+86+5+15+5+65+15+5, kScreenWidth/4, 15)];
    nightNum.text = @"247";
    nightNum.textAlignment = NSTextAlignmentCenter;
    nightNum.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:nightNum];
    
    UILabel *freeSeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*3/4, 65+25+86+5+15+5+65, kScreenWidth/4, 15)];// 空余 325-13-247
    freeSeatLabel.text = @"空余";
    freeSeatLabel.textAlignment = NSTextAlignmentCenter;
    freeSeatLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:freeSeatLabel];
    
    UILabel *freeSeat = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*3/4, 65+25+86+5+15+5+65+15+5, kScreenWidth/4, 15)];
    freeSeat.text = @"65";
    freeSeat.textAlignment = NSTextAlignmentCenter;
    freeSeat.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:freeSeat];
    
    [self initData];
    //小时分布表格
    UITableView *flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 65+25+86+5+15+5+65+15+5+40+20, kScreenWidth-40, 250)];
    flightHourTableView.delegate = self;
    flightHourTableView.dataSource = self;
    flightHourTableView.showsVerticalScrollIndicator = NO;
    flightHourTableView.backgroundColor = [UIColor whiteColor];
    flightHourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:flightHourTableView];
}

-(void)initTitle
{
    [self titleViewInitWithHight:65];
    [self titleViewAddTitleText:@"使用详情"];
    
    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 65)];
    self.titleView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];
    
    [self titleViewAddBackBtn];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeatUsedModel *model = array[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.type];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:model.type];
        
        [cell addSubview:[CommonFunction addLabelFrame:CGRectMake(20, 0, 30, 30) text:model.type font:30 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
        [cell addSubview:[CommonFunction addLabelFrame:CGRectMake(50, 0, kScreenWidth/2-50-30, 13) text:[NSString stringWithFormat:@"占用 %i",model.used] font:12 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
        [cell addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2-50, 12) text:[NSString stringWithFormat:@"空余 %i",model.free] font:12 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B]];
        
        LDProgressView *progressF= [[LDProgressView alloc] initWithFrame:CGRectMake(50, 12+3, kScreenWidth-100, 10)];
        progressF.color = [CommonFunction colorFromHex:0XFF05CA6E];
        progressF.progress = [model getPercent];
        progressF.showText = @NO;
        progressF.animate = @YES;
        progressF.showBackgroundInnerShadow = @NO;
        progressF.type = LDProgressSolid;
        progressF.outerStrokeWidth = @NO;
        progressF.showStroke = @NO;
        progressF.background = [CommonFunction colorFromHex:0XFFE9EDF1];
        [cell addSubview:progressF];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void) initData
{
    if(array == nil){
        array = [[NSMutableArray alloc] init];
    }else{
        [array removeAllObjects];
    }
    
    [array addObject:[[SeatUsedModel alloc] initWithType:@"B" free:25 used:75]];
    [array addObject:[[SeatUsedModel alloc] initWithType:@"C" free:35 used:40]];
    [array addObject:[[SeatUsedModel alloc] initWithType:@"D" free:40 used:35]];
    [array addObject:[[SeatUsedModel alloc] initWithType:@"E" free:25 used:15]];
    [array addObject:[[SeatUsedModel alloc] initWithType:@"F" free:25 used:35]];
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
