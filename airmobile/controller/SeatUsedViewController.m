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
#import "CraftseatCntModel.h"

@interface SeatUsedViewController ()

@property (nonatomic ,strong) CraftseatCntModel *craftseatCntModel ;

@end

@implementation SeatUsedViewController
{
    NSMutableArray<SeatUsedModel *> *array;
    CGFloat normalProportion;
    CGFloat abnormalProportion;
    CGFloat cancleProportion;
    
}

-(instancetype)initWithCraftseatCntModel:(CraftseatCntModel *)craftseatCntModel
{
    self = [super init];
    if (self) {
        _craftseatCntModel = craftseatCntModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitle];
    
    //圆圈
    RoundProgressView *progressRound = [[RoundProgressView alloc] initWithCenter:CGPointMake(kScreenWidth/2, px_px_2_2_3(50*2, 65*2, 65*3)+px_px_2_3(95, 135)+px_px_2_3(95*2, 104*3))
                                                                          radius:px_px_2_3(95*2, 104*3)
                                                                      aboveColos:@[(__bridge id)[CommonFunction colorFromHex:0XFF00C7E4].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF00F383].CGColor ]
                                                                      belowColos:@[(__bridge id)[CommonFunction colorFromHex:0XFFFF9F38].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFFCD21].CGColor ] start:150.0f end:45 clockwise:YES];

    
    normalProportion = _craftseatCntModel.currentTakeUp/@(_craftseatCntModel.allCount).floatValue;
    abnormalProportion = normalProportion+(_craftseatCntModel.unusable/@(_craftseatCntModel.allCount).floatValue);
    cancleProportion = abnormalProportion + (_craftseatCntModel.longTakeUp/@(_craftseatCntModel.allCount).floatValue);
    
    //对数据进行动画
    [progressRound animationWithStrokeEnd:normalProportion withProgressType:ProgreesTypeNormal];
    [progressRound animationWithStrokeEnd:abnormalProportion withProgressType:ProgreesTypeAbnormal];
    [progressRound animationWithStrokeEnd:cancleProportion withProgressType:ProgreesTypeCancel];

    //圆圈底部圆圈
//    UIImage *bottomRoundImage = [UIImage imageNamed:@"chartBack"];
//    UIImageView *bottomRoundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(progressRound)-7, viewHeight(progressRound)-7)];
//    bottomRoundImageView.image = bottomRoundImage;
//    bottomRoundImageView.center = progressRound.center;
//    [self.view addSubview:bottomRoundImageView];
    [self.view addSubview:progressRound];


    UILabel *totalNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewX(progressRound), (viewY(progressRound)+viewBotton(progressRound))/2-45/2-20, viewWidth(progressRound), 45)];// 机位总数
    totalNumLabel.text = @(_craftseatCntModel.allCount).stringValue;

    totalNumLabel.textAlignment = NSTextAlignmentCenter;
    totalNumLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:55];
    [self.view addSubview:totalNumLabel];
    
    UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewX(progressRound), viewBotton(totalNumLabel)+8, viewWidth(progressRound), 12)];
    totalLabel.text = @"机位";
    totalLabel.textAlignment = NSTextAlignmentCenter;
    totalLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.view addSubview:totalLabel];
    
    UILabel *inSeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewX(progressRound), viewBotton(totalLabel)+8, viewWidth(progressRound), 12)];// 当前停占
    NSMutableAttributedString *inSeatAttributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"过夜航班 %@",@(_craftseatCntModel.passNight).stringValue] ];
     [inSeatAttributedString addAttribute:NSForegroundColorAttributeName value:[CommonFunction colorFromHex:0xFFF24737] range:NSMakeRange(5, inSeatAttributedString.length-5)];
    [inSeatAttributedString addAttribute:NSForegroundColorAttributeName value:[CommonFunction colorFromHex:0xFFd4d4d4] range:NSMakeRange(0, 5)];
    inSeatLabel.attributedText = inSeatAttributedString;
    inSeatLabel.textAlignment = NSTextAlignmentCenter;
    inSeatLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.view addSubview:inSeatLabel];
    
//    UILabel *nightNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2+15, 65+25+86+5+15+5, 50, 15)];
//    nightNumLabel.text = @"245";
//    nightNumLabel.font = [UIFont systemFontOfSize:15];
//    [self.view addSubview:nightNumLabel];

    UILabel *minLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewX(progressRound)+16, viewBotton(progressRound)-30, 11, 11)];
    minLabel.text = @"0";
    minLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [self.view addSubview:minLabel];


    UILabel *maxLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewTrailing(progressRound)-25, viewY(minLabel), 30, 11)];
    maxLabel.text = @"100";
    maxLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [self.view addSubview:maxLabel];


    CGFloat y = viewBotton( maxLabel)+px_px_2_3(60, 100);
    CGFloat width = (kScreenWidth-43)/4;

    CGSize maxSize = CGSizeMake(100, 100);
    CGSize exportSize;
    UIView *disAbleView = [[UIView alloc]initWithFrame:CGRectMake(43/2, y, width, 30)];
    [self.view addSubview:disAbleView];

    UILabel *disAbleLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100-5, 11)];// 不可用
    disAbleLabel.text = @"不可用";
    disAbleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    exportSize = [disAbleLabel sizeThatFits:maxSize];
    disAbleLabel.frame = CGRectMake((viewWidth(disAbleView)-exportSize.width)/2, 0, exportSize.width, 11);
    [disAbleView addSubview:disAbleLabel];
    UIImageView *disAbleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(disAbleLabel)-8, 2, 6, 6)];
    disAbleImageView.image = [UIImage imageNamed:@"DisableResource"];
    [disAbleView addSubview:disAbleImageView];
    
    UILabel *disable = [[UILabel alloc] initWithFrame:CGRectMake(viewX(disAbleLabel),viewBotton(disAbleLabel)+5, viewWidth(disAbleLabel), 16)];
    disable.text = @(_craftseatCntModel.unusable).stringValue;
    disable.textAlignment = NSTextAlignmentCenter;
    disable.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    [disAbleView addSubview:disable];

    UIView *longInSeatView = [[UIView alloc]initWithFrame:CGRectMake(viewTrailing(disAbleView), y, width, 30)];
    [self.view addSubview:longInSeatView];
    UIImageView *longInSeatImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 6, 6)];
    longInSeatImageView.image = [UIImage imageNamed:@"DisableResource"];
    [longInSeatView addSubview:longInSeatImageView];

    UILabel *longInSeatLabel= [[UILabel alloc] init];//长期占用
    longInSeatLabel.text = @"长期占用";
    longInSeatLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    exportSize = [longInSeatLabel sizeThatFits:maxSize];
    longInSeatLabel.frame = CGRectMake((viewWidth(longInSeatView)-exportSize.width)/2, 0, exportSize.width, 11);
    [longInSeatView addSubview:longInSeatLabel];

    UILabel *longInSeat = [[UILabel alloc] initWithFrame:CGRectMake(viewX(longInSeatLabel),viewBotton(longInSeatLabel)+5, viewWidth(longInSeatLabel), 16)];
    longInSeat.text = @(_craftseatCntModel.longTakeUp).stringValue;
    longInSeat.textAlignment = NSTextAlignmentCenter;
    longInSeat.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    [longInSeatView addSubview:longInSeat];
    
//    UILabel *longInSeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4, 65+25+86+5+15+5+65, kScreenWidth/4, 15)];// 长期占用
//    longInSeatLabel.text = @"长期占用";
//    longInSeatLabel.textAlignment = NSTextAlignmentCenter;
//    longInSeatLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13];
//    [self.view addSubview:longInSeatLabel];
//    
//    UILabel *longInSeat = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4, 65+25+86+5+15+5+65+15+5, kScreenWidth/4, 15)];
//    longInSeat.text = @"10";
//    longInSeat.textAlignment = NSTextAlignmentCenter;
//    longInSeat.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13];
//    [self.view addSubview:longInSeat];

    UIView *nightView = [[UIView alloc]initWithFrame:CGRectMake(viewTrailing(longInSeatView), y, width, 30)];
    [self.view addSubview:nightView];
    UIImageView *nightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 6, 6)];
    nightImageView.image = [UIImage imageNamed:@"DisableResource"];
    [nightView addSubview:nightImageView];

    UILabel *nightLabel= [[UILabel alloc] initWithFrame:CGRectMake(viewTrailing(nightImageView)+5, 0, width-viewTrailing(nightImageView)-5, 11)];// 不可用
    nightLabel.text = @"今日停场";
    nightLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    exportSize = [nightLabel sizeThatFits:maxSize];
    nightLabel.frame = CGRectMake((viewWidth(nightLabel)-exportSize.width)/2, 0, exportSize.width, 11);
    [nightView addSubview:nightLabel];

    UILabel *night = [[UILabel alloc] initWithFrame:CGRectMake(viewX(nightLabel),viewBotton(nightLabel)+5, viewWidth(nightLabel), 16)];
    night.text = @(_craftseatCntModel.todayFltTakeUp).stringValue;
    night.textAlignment = NSTextAlignmentCenter;
    night.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    [nightView addSubview:night];
//
//    UILabel *nightLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 65+25+86+5+15+5+65, kScreenWidth/4, 15)];// 过夜
//    nightLabel.text = @"过夜停占";
//    nightLabel.textAlignment = NSTextAlignmentCenter;
//    nightLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13];
//    [self.view addSubview:nightLabel];
//    
//    UILabel *nightNum = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 65+25+86+5+15+5+65+15+5, kScreenWidth/4, 15)];
//    nightNum.text = @"247";
//    nightNum.textAlignment = NSTextAlignmentCenter;
//    nightNum.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13];
//    [self.view addSubview:nightNum];

    UIView *freeSeatView = [[UIView alloc]initWithFrame:CGRectMake(viewTrailing(nightView), y, width, 30)];
    [self.view addSubview:freeSeatView];
    UIImageView *freeSeatImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 6, 6)];
    freeSeatImageView.image = [UIImage imageNamed:@"DisableResource"];
    [freeSeatView addSubview:freeSeatImageView];

    UILabel *freeSeatLabel= [[UILabel alloc] initWithFrame:CGRectMake(viewTrailing(freeSeatImageView)+5, 0, width-viewTrailing(freeSeatImageView)-5, 11)];// 不可用
    freeSeatLabel.text = @"空余机位";
    freeSeatLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    exportSize = [freeSeatLabel sizeThatFits:maxSize];
    freeSeatLabel.frame = CGRectMake((viewWidth(freeSeatView)-exportSize.width)/2, 0, exportSize.width, 11);
    [freeSeatView addSubview:freeSeatLabel];

    UILabel *freeSeat = [[UILabel alloc] initWithFrame:CGRectMake(viewX(freeSeatLabel),viewBotton(freeSeatLabel)+5, viewWidth(freeSeatLabel), 16)];
    freeSeat.text = @(_craftseatCntModel.idle).stringValue;
    freeSeat.textAlignment = NSTextAlignmentCenter;
    freeSeat.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    [freeSeatView addSubview:freeSeat];

//    UILabel *freeSeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*3/4, 65+25+86+5+15+5+65, kScreenWidth/4, 15)];// 空余 325-13-247
//    freeSeatLabel.text = @"空余";
//    freeSeatLabel.textAlignment = NSTextAlignmentCenter;
//    freeSeatLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13];
//    [self.view addSubview:freeSeatLabel];
//    
//    UILabel *freeSeat = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*3/4, 65+25+86+5+15+5+65+15+5, kScreenWidth/4, 15)];
//    freeSeat.text = @"65";
//    freeSeat.textAlignment = NSTextAlignmentCenter;
//    freeSeat.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13];
//    [self.view addSubview:freeSeat];

//    [self initData];

    array = _craftseatCntModel.seatUsed;
    //小时分布表格
    UITableView *flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, viewBotton(freeSeatView)+px_px_2_3(60, 100), kScreenWidth,viewHeight(self.view) - viewBotton(freeSeatView)-px_px_2_3(60, 100))];
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
    return 125/2;
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

//        UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 3,kScreenWidth-10, 125/2-6)];
//        backgroundImageView.image = [UIImage imageNamed:@"FlightFilterbuttonNoSelected"];
//        [cell addSubview:backgroundImageView];

        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(5, 3,kScreenWidth-10, 125/2-6)];
        contentView.layer.cornerRadius = 5.0;
        contentView.layer.borderColor = [CommonFunction colorFromHex:0xFFf0f0f0].CGColor;
        contentView.layer.borderWidth = 1.0;
        [cell addSubview:contentView];
        [contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(7, 0, 30, 22) text:model.type font:25/2 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF000000]];
        UILabel *notUseLabel = [[UILabel alloc]init];
        CGSize maxSize = CGSizeMake(100, 100);
        notUseLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:25/2];
        notUseLabel.text = [NSString stringWithFormat:@"空余 %i",model.free];
        CGSize exportSize = [notUseLabel sizeThatFits:maxSize];
        notUseLabel.frame = CGRectMake(viewWidth(contentView)-10-exportSize.width, 0, exportSize.width, 22);
        [contentView addSubview:notUseLabel];

        UILabel *useLabel = [[UILabel alloc]init];
        maxSize = CGSizeMake(100, 100);
        useLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:25/2];
        useLabel.text = [NSString stringWithFormat:@"占用 %i",model.used];
        exportSize = [useLabel sizeThatFits:maxSize];
        useLabel.frame = CGRectMake(viewX(notUseLabel)-10-exportSize.width, 0, exportSize.width, 22);
        [contentView addSubview:useLabel];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(1, viewBotton(useLabel), viewWidth(contentView), 0.5)];
        lineView.backgroundColor = [CommonFunction colorFromHex:0xFFf0f0f0];
        [contentView addSubview:lineView];

//        [contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(50, 0, kScreenWidth/2-50-30, 13) text:[NSString stringWithFormat:@"占用 %i",model.used] font:12 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
//        [contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2-50, 12) text:[NSString stringWithFormat:@"空余 %i",model.free] font:12 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B]];
//        
        LDProgressView *progressF= [[LDProgressView alloc] initWithFrame:CGRectMake(7, viewBotton(lineView)+11, viewWidth(contentView)-14, 10)];
        progressF.color = [CommonFunction colorFromHex:0XFF05CA6E];
        progressF.progress = [model getPercent];
        progressF.showText = @NO;
        progressF.animate = @YES;
        progressF.showBackgroundInnerShadow = @NO;
        progressF.type = LDProgressSolid;
        progressF.outerStrokeWidth = @NO;
        progressF.showStroke = @NO;
        progressF.background = [CommonFunction colorFromHex:0XFFE9EDF1];
        [contentView addSubview:progressF];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//-(void) initData
//{
//    if(array == nil){
//        array = [[NSMutableArray alloc] init];
//    }else{
//        [array removeAllObjects];
//    }
//    
//    [array addObject:[[SeatUsedModel alloc] initWithType:@"B" free:25 used:75]];
//    [array addObject:[[SeatUsedModel alloc] initWithType:@"C" free:35 used:40]];
//    [array addObject:[[SeatUsedModel alloc] initWithType:@"D" free:40 used:35]];
//    [array addObject:[[SeatUsedModel alloc] initWithType:@"E" free:25 used:15]];
//    [array addObject:[[SeatUsedModel alloc] initWithType:@"F" free:25 used:35]];
//}

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
