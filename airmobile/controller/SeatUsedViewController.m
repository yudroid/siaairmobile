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

const NSString *SEATUSED_TABLEVIEW_IDENTIFIER = @"SEATUSED_TABLEVIEW_IDENTIFIER";

@interface SeatUsedViewController ()

@property (nonatomic ,strong) CraftseatCntModel *craftseatCntModel ;

@end

@implementation SeatUsedViewController
{
    NSArray<SeatUsedModel *> *array;
    CGFloat normalProportion;
    CGFloat abnormalProportion;
    CGFloat cancleProportion;
    CGFloat unusedPropertion;
    RoundProgressView   *progressRound;
    UITableView         *flightHourTableView;
    UILabel *totalNumLabel;
    UILabel *inSeatLabel;
    UILabel *freeSeat;
    UILabel *disable;
    UILabel *night;
    UILabel *longInSeat;
    
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
    progressRound = [[SeatUsedRoundProgressView alloc] initWithCenter:CGPointMake(kScreenWidth/2,
                                                                                             px_px_2_2_3(50*2, 65*2, 65*3)+px_px_2_3(95, 135)+px_px_2_3(95*2, 104*3))
                                                                          radius:px_px_2_3(95*2, 104*3)
                                                                      aboveColos:@[(__bridge id)[CommonFunction colorFromHex:0Xffffcc21].CGColor,
                                                                                   (__bridge id)[CommonFunction colorFromHex:0Xffffcc21].CGColor ]
                                                                      belowColos:@[(__bridge id)[CommonFunction colorFromHex:0xff00b2d8].CGColor,
                                                                                   (__bridge id)[CommonFunction colorFromHex:0xff00b2d8].CGColor ]
                                                                           start:150.0f
                                                                             end:30.0f
                                                                       clockwise:YES];

    
    normalProportion = _craftseatCntModel.longTakeUp/@(_craftseatCntModel.allCount).floatValue ;
    abnormalProportion = normalProportion+(_craftseatCntModel.idle/@(_craftseatCntModel.allCount).floatValue);
    cancleProportion = abnormalProportion + (_craftseatCntModel.todayFltTakeUp/@(_craftseatCntModel.allCount).floatValue);
    unusedPropertion = cancleProportion +(_craftseatCntModel.unusable/@(_craftseatCntModel.allCount).floatValue);

    //对数据进行动画
    [progressRound animationWithStrokeEnd:normalProportion withProgressType:ProgreesTypeNormal];
    [progressRound animationWithStrokeEnd:abnormalProportion withProgressType:ProgreesTypeAbnormal];
    [progressRound animationWithStrokeEnd:cancleProportion withProgressType:ProgreesTypeCancel];
    [progressRound animationWithStrokeEnd:unusedPropertion withProgressType:5];

    //圆圈底部圆圈
//    UIImage *bottomRoundImage = [UIImage imageNamed:@"chartBack"];
//    UIImageView *bottomRoundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(progressRound)-7, viewHeight(progressRound)-7)];
//    bottomRoundImageView.image = bottomRoundImage;
//    bottomRoundImageView.center = progressRound.center;
//    [self.view addSubview:bottomRoundImageView];
    [self.view addSubview:progressRound];


    totalNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewX(progressRound),
                                                                       (viewY(progressRound)+viewBotton(progressRound))/2-45/2-20,
                                                                       viewWidth(progressRound),
                                                                       45)];// 机位总数
    totalNumLabel.text = @(_craftseatCntModel.allCount).stringValue;
    totalNumLabel.textAlignment = NSTextAlignmentCenter;
    totalNumLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold"
                                         size:55];
    [self.view addSubview:totalNumLabel];
    
    UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewX(progressRound),
                                                                    viewBotton(totalNumLabel)+8,
                                                                    viewWidth(progressRound),
                                                                    12)];
    totalLabel.text = @"机位";
    totalLabel.textAlignment = NSTextAlignmentCenter;
    totalLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.view addSubview:totalLabel];
    
    inSeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewX(progressRound),
                                                                     viewBotton(totalLabel)+8,
                                                                     viewWidth(progressRound),
                                                                     12)];// 当前停占
    NSMutableAttributedString *inSeatAttributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"过夜航班 %@",@(_craftseatCntModel.passNight).stringValue] ];
     [inSeatAttributedString addAttribute:NSForegroundColorAttributeName
                                    value:[CommonFunction colorFromHex:0xFFF24737]
                                    range:NSMakeRange(5, inSeatAttributedString.length-5)];
    [inSeatAttributedString addAttribute:NSForegroundColorAttributeName
                                   value:[CommonFunction colorFromHex:0xFFd4d4d4]
                                   range:NSMakeRange(0, 5)];
    inSeatLabel.attributedText = inSeatAttributedString;
    inSeatLabel.textAlignment = NSTextAlignmentCenter;
    inSeatLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.view addSubview:inSeatLabel];
    
//    UILabel *nightNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2+15, 65+25+86+5+15+5, 50, 15)];
//    nightNumLabel.text = @"245";
//    nightNumLabel.font = [UIFont systemFontOfSize:15];
//    [self.view addSubview:nightNumLabel];

    UILabel *minLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewX(progressRound)+16,
                                                                 viewBotton(progressRound)-30,
                                                                 11,
                                                                 11)];
    minLabel.text = @"0";
    minLabel.font = [UIFont fontWithName:@"PingFangSC-Regular"
                                    size:13];
    [self.view addSubview:minLabel];


    UILabel *maxLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewTrailing(progressRound)-25,
                                                                 viewY(minLabel),
                                                                 30,
                                                                 11)];
    maxLabel.text = @"100";
    maxLabel.font = [UIFont fontWithName:@"PingFangSC-Regular"
                                    size:13];
    [self.view addSubview:maxLabel];


    CGFloat y = viewBotton( maxLabel)+px_px_2_3(60, 100);
    CGFloat width = (kScreenWidth-43)/4;

    CGSize maxSize = CGSizeMake(100, 100);
    CGSize exportSize;

    //长期占用
    UIView *longInSeatView = [[UIView alloc]initWithFrame:CGRectMake(43/2,
                                                                     y,
                                                                     width,
                                                                     30)];


    [self.view addSubview:longInSeatView];
    UIImageView *longInSeatImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8,
                                                                                    3,
                                                                                    6,
                                                                                    6)];
    longInSeatImageView.backgroundColor = [CommonFunction colorFromHex:0Xffffcc21];
    longInSeatImageView.layer.cornerRadius = 3.0;
    longInSeatImageView.layer.masksToBounds = YES;
    [longInSeatView addSubview:longInSeatImageView];

    UILabel *longInSeatLabel= [[UILabel alloc] init];//长期占用
    longInSeatLabel.text = @"长期占用";
    longInSeatLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular"
                                            size:13];
    exportSize = [longInSeatLabel sizeThatFits:maxSize];
    longInSeatLabel.frame = CGRectMake((viewWidth(longInSeatView)-exportSize.width)/2,
                                       0,
                                       exportSize.width,
                                       11);
    [longInSeatView addSubview:longInSeatLabel];
    longInSeat = [[UILabel alloc] initWithFrame:CGRectMake(viewX(longInSeatLabel),
                                                           viewBotton(longInSeatLabel)+5,
                                                           viewWidth(longInSeatLabel),
                                                           16)];
    longInSeat.text = @(_craftseatCntModel.longTakeUp).stringValue;
    longInSeat.textAlignment = NSTextAlignmentCenter;
    longInSeat.font =  [UIFont fontWithName:@"PingFangSC-Regular"
                                       size:15];
    [longInSeatView addSubview:longInSeat];

    //空余机位
    UIView *freeSeatView = [[UIView alloc]initWithFrame:CGRectMake(viewTrailing(longInSeatView),
                                                                   y,
                                                                   width,
                                                                   30)];


    [self.view addSubview:freeSeatView];
    UIImageView *freeSeatImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8,
                                                                                  3,
                                                                                  6,
                                                                                  6)];
    freeSeatImageView.backgroundColor = [CommonFunction colorFromHex:0xff00b2d8];
    freeSeatImageView.layer.cornerRadius = 3.0;
    freeSeatImageView.layer.masksToBounds = YES;
    [freeSeatView addSubview:freeSeatImageView];

    UILabel *freeSeatLabel= [[UILabel alloc] initWithFrame:CGRectMake(viewTrailing(freeSeatImageView)+5,
                                                                      0,
                                                                      width-viewTrailing(freeSeatImageView)-5,
                                                                      11)];// 不可用
    freeSeatLabel.text = @"空余机位";
    freeSeatLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular"
                                          size:13];
    exportSize = [freeSeatLabel sizeThatFits:maxSize];
    freeSeatLabel.frame = CGRectMake((viewWidth(freeSeatView)-exportSize.width)/2,
                                     0,
                                     exportSize.width,
                                     11);
    [freeSeatView addSubview:freeSeatLabel];

    freeSeat = [[UILabel alloc] initWithFrame:CGRectMake(viewX(freeSeatLabel),
                                                         viewBotton(freeSeatLabel)+5,
                                                         viewWidth(freeSeatLabel),
                                                         16)];
    freeSeat.text = @(_craftseatCntModel.idle).stringValue;
    freeSeat.textAlignment = NSTextAlignmentCenter;
    freeSeat.font =  [UIFont fontWithName:@"PingFangSC-Regular"
                                     size:15];
    [freeSeatView addSubview:freeSeat];






    //今日停场
    UIView *nightView = [[UIView alloc]initWithFrame:CGRectMake(viewTrailing(freeSeatView),
                                                                y,
                                                                width,
                                                                30)];
    [self.view addSubview:nightView];
    UIImageView *nightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8,
                                                                               3,
                                                                               6,
                                                                               6)];
    nightImageView.backgroundColor = [CommonFunction colorFromHex:0xffbb48eb];
    nightImageView.layer.cornerRadius = 3.0;
    nightImageView.layer.masksToBounds = YES;
    [nightView addSubview:nightImageView];

    UILabel *nightLabel= [[UILabel alloc] initWithFrame:CGRectMake(viewTrailing(nightImageView)+5,
                                                                   0,
                                                                   width-viewTrailing(nightImageView)-5,
                                                                   11)];// 不可用
    nightLabel.text = @"今日停场";
    nightLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular"
                                       size:13];
    exportSize = [nightLabel sizeThatFits:maxSize];
    nightLabel.frame = CGRectMake((viewWidth(nightView)-exportSize.width)/2,
                                  0,
                                  exportSize.width,
                                  11);
    [nightView addSubview:nightLabel];

    night = [[UILabel alloc] initWithFrame:CGRectMake(viewX(nightLabel),
                                                               viewBotton(nightLabel)+5,
                                                               viewWidth(nightLabel),
                                                               16)];
    night.text = @(_craftseatCntModel.todayFltTakeUp).stringValue;
    night.textAlignment = NSTextAlignmentCenter;
    night.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [nightView addSubview:night];


    //不可用
    UIView *disAbleView = [[UIView alloc]initWithFrame:CGRectMake(viewTrailing(nightView),
                                                                   y,
                                                                   width,
                                                                   30)];
    [self.view addSubview:disAbleView];

    UILabel *disAbleLabel= [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     100-5,
                                                                     11)];// 不可用
    disAbleLabel.text = @"不可用";
    disAbleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    exportSize = [disAbleLabel sizeThatFits:maxSize];
    disAbleLabel.frame = CGRectMake((viewWidth(disAbleView)-exportSize.width)/2,
                                    0,
                                    exportSize.width,
                                    11);
    [disAbleView addSubview:disAbleLabel];
    UIImageView *disAbleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewX(disAbleLabel)-8,
                                                                                 2,
                                                                                 6,
                                                                                 6)];
    disAbleImageView.backgroundColor = [CommonFunction colorFromHex:0xfff0f0f0];
    disAbleImageView.layer.cornerRadius = 3.0;
    disAbleImageView.layer.masksToBounds = YES;
    [disAbleView addSubview:disAbleImageView];

    disable = [[UILabel alloc] initWithFrame:CGRectMake(viewX(disAbleLabel),
                                                        viewBotton(disAbleLabel)+5,
                                                        viewWidth(disAbleLabel),
                                                        16)];
    disable.text = @(_craftseatCntModel.unusable).stringValue;
    disable.textAlignment = NSTextAlignmentCenter;
    disable.font =  [UIFont fontWithName:@"PingFangSC-Regular"
                                    size:15];
    [disAbleView addSubview:disable];

    array = _craftseatCntModel.seatUsed;
    //小时分布表格
    flightHourTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                       viewBotton(freeSeatView)+px_px_2_3(60, 100),
                                                                       kScreenWidth,
                                                                       viewHeight(self.view) - viewBotton(freeSeatView)-px_px_2_3(60, 100))];
    flightHourTableView.delegate = self;
    flightHourTableView.dataSource = self;
    flightHourTableView.showsVerticalScrollIndicator = NO;
    flightHourTableView.backgroundColor = [UIColor whiteColor];
    flightHourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:flightHourTableView];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadData:)
                                                 name:@"CraftSeatTypeTakeUpSort"
                                               object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"CraftSeatTypeTakeUpSort"
                                                  object:nil];
}


-(void)initTitle
{
    [self titleViewInitWithHight:65];
    [self titleViewAddTitleText:@"使用详情"];
    
    UIView *titleLabelView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      kScreenWidth,
                                                                      65)];
    self.titleView .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_title_bg.png"]];
    [self.titleView addSubview:titleLabelView];
    
    [self titleViewAddBackBtn];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150/2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeatUsedModel *model = array[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)SEATUSED_TABLEVIEW_IDENTIFIER];
    
    if (!cell) {


        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault)
                                     reuseIdentifier:(NSString *)SEATUSED_TABLEVIEW_IDENTIFIER];

//        UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 3,kScreenWidth-10, 125/2-6)];
//        backgroundImageView.image = [UIImage imageNamed:@"FlightFilterbuttonNoSelected"];
//        [cell addSubview:backgroundImageView];

//        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(16,
//                                                                      5,
//                                                                      kScreenWidth-32,
//                                                                      150/2-10)];
//        contentView.layer.cornerRadius = 8.0;
//        contentView.layer.borderColor = [CommonFunction colorFromHex:0xFFf0f0f0].CGColor;
//        contentView.layer.borderWidth = 1.0;
//        [cell addSubview:contentView];
//        [contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(10, 0, 30, 30)
//                                                         text:model.sizetype
//                                                         font:25/2
//                                                textAlignment:(NSTextAlignmentLeft)
//                                                 colorFromHex:0xFF000000]];
//        UILabel *notUseLabel = [[UILabel alloc]init];
//        CGSize maxSize = CGSizeMake(100, 100);
//        notUseLabel.font = [UIFont fontWithName:@"PingFangSC-Regular"
//                                           size:25/2];
//        notUseLabel.text = [NSString stringWithFormat:@"空余 %ld",model.normalCnt+model.parentCnt];
//        CGSize exportSize = [notUseLabel sizeThatFits:maxSize];
//        notUseLabel.frame = CGRectMake(viewWidth(contentView)-10-exportSize.width,
//                                       0,
//                                       exportSize.width,
//                                       30);
//        [contentView addSubview:notUseLabel];
//
//        UILabel *useLabel = [[UILabel alloc]init];
//        maxSize = CGSizeMake(100, 100);
//        useLabel.font = [UIFont fontWithName:@"PingFangSC-Regular"
//                                        size:25/2];
//        useLabel.text = [NSString stringWithFormat:@"占用 %ld",model.normalTakeUpCnt+model.parentTakeUpCnt];
//        exportSize = [useLabel sizeThatFits:maxSize];
//        useLabel.frame = CGRectMake(viewX(notUseLabel)-10-exportSize.width,
//                                    0,
//                                    exportSize.width,
//                                    30);
//        [contentView addSubview:useLabel];
//
//        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(1,
//                                                                   viewBotton(useLabel),
//                                                                   viewWidth(contentView),
//                                                                   0.5)];
//        lineView.backgroundColor = [CommonFunction colorFromHex:0xFFf0f0f0];
//        [contentView addSubview:lineView];
//
////        [contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(50, 0, kScreenWidth/2-50-30, 13) text:[NSString stringWithFormat:@"占用 %i",model.used] font:12 textAlignment:(NSTextAlignmentLeft) colorFromHex:0xFF1B1B1B]];
////        [contentView addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2-50, 12) text:[NSString stringWithFormat:@"空余 %i",model.free] font:12 textAlignment:(NSTextAlignmentRight) colorFromHex:0xFF1B1B1B]];
////        
//        LDProgressView *progressF= [[LDProgressView alloc] initWithFrame:CGRectMake(7,
//                                                                                    viewBotton(lineView)+9,
//                                                                                    viewWidth(contentView)-14,
//                                                                                    15)];
//        progressF.color = [CommonFunction colorFromHex:0XFF05CA6E];
//        progressF.progress = 0.5;
//        progressF.showText = @NO;
//        progressF.animate = @YES;
//        progressF.showBackgroundInnerShadow = @NO;
//        progressF.type = LDProgressSolid;
//        progressF.outerStrokeWidth = @NO;
//        progressF.showStroke = @NO;
//        progressF.background = [CommonFunction colorFromHex:0XFFE9EDF1];
//        [contentView addSubview:progressF];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)loadData:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[CraftseatCntModel class]]) {
        _craftseatCntModel  = notification.object;

        normalProportion = _craftseatCntModel.longTakeUp/@(_craftseatCntModel.allCount).floatValue ;
        abnormalProportion = normalProportion+(_craftseatCntModel.idle/@(_craftseatCntModel.allCount).floatValue);
        cancleProportion = abnormalProportion + (_craftseatCntModel.todayFltTakeUp/@(_craftseatCntModel.allCount).floatValue);
        unusedPropertion = cancleProportion +(_craftseatCntModel.unusable/@(_craftseatCntModel.allCount).floatValue);

        //对数据进行动画
        [progressRound animationWithStrokeEnd:normalProportion withProgressType:ProgreesTypeNormal];
        [progressRound animationWithStrokeEnd:abnormalProportion withProgressType:ProgreesTypeAbnormal];
        [progressRound animationWithStrokeEnd:cancleProportion withProgressType:ProgreesTypeCancel];
        [progressRound animationWithStrokeEnd:unusedPropertion withProgressType:5];

        totalNumLabel.text = @(_craftseatCntModel.allCount).stringValue;

        NSMutableAttributedString *inSeatAttributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"过夜航班 %@",@(_craftseatCntModel.passNight).stringValue] ];
        [inSeatAttributedString addAttribute:NSForegroundColorAttributeName
                                       value:[CommonFunction colorFromHex:0xFFF24737]
                                       range:NSMakeRange(5, inSeatAttributedString.length-5)];
        [inSeatAttributedString addAttribute:NSForegroundColorAttributeName
                                       value:[CommonFunction colorFromHex:0xFFd4d4d4]
                                       range:NSMakeRange(0, 5)];
        inSeatLabel.attributedText = inSeatAttributedString;

        freeSeat.text = @(_craftseatCntModel.idle).stringValue;
        disable.text = @(_craftseatCntModel.unusable).stringValue;
        night.text = @(_craftseatCntModel.todayFltTakeUp).stringValue;
        longInSeat.text = @(_craftseatCntModel.longTakeUp).stringValue;

        [flightHourTableView reloadData];
        
    }
    
}


@end
