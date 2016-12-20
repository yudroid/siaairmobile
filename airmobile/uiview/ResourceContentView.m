//
//  ResourceContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ResourceContentView.h"
#import "SeatUsedModel.h"
#import "TagView.h"
#import "SeatStatusModel.h"


const NSString *RESOURCECONTENT_TABLECELL_IDENTIFIER = @"RESOURCECONTENT_TABLECELL_IDENTIFIER";

@interface ResourceContentView()

@property (nonatomic, strong) SeatStatusModel *seatStatusModel;

@end

@implementation ResourceContentView
{
    NSMutableArray<SeatUsedModel *> *array;

    RoundProgressView *progressRound ;
    UILabel *totalNumLabel;
    UILabel *disable;
    UILabel *percentLabel;
    UILabel *longInSeat;
    UILabel *disAbleLabel;
    UILabel *longInSeatLabel;
    UILabel *arrLabel;
    UILabel *depLabel;
    UIImageView *disableImageView;
    UIImageView *longInSeatImageView;
}

-(id)initWithFrame:(CGRect)                         frame
   seatStatusModel:(SeatStatusModel *)              seatStatusModel
              type:(ResourceContentViewType)        type
          delegate:(id<ResourceContentViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if(self){
        _type = type;
        _delegate           = delegate;

        _seatStatusModel    = seatStatusModel;
        CGFloat y = px_px_2_2_3(70,90, 131);
        
        //圆圈
        progressRound = [[RoundProgressView alloc] initWithCenter:CGPointMake(kScreenWidth/2,
                                                                                                 y+px_px_2_2_3(80*2,95*2, 575/2))
                                                                              radius:px_px_2_2_3(80*2,95*2, 575/2)
                                                                          aboveColos:@[(__bridge id)[CommonFunction colorFromHex:0XFF00aedd].CGColor,
                                                                                       (__bridge id)[CommonFunction colorFromHex:0XFF00d6a0].CGColor ]
                                                                          belowColos:@[(__bridge id)[CommonFunction colorFromHex:0X00FF9F38].CGColor,
                                                                                       (__bridge id)[CommonFunction colorFromHex:0X00FFCD21].CGColor ]
                                                                               start:270
                                                                                 end:271
                                                                           clockwise:NO];




        
        //对数据进行动画
        [progressRound animationWithStrokeEnd:normalProportion withProgressType:ProgreesTypeNormal];
        [progressRound animationWithStrokeEnd:abnormalProportion withProgressType:ProgreesTypeAbnormal];
        [progressRound animationWithStrokeEnd:cancleProportion withProgressType:ProgreesTypeCancel];

        //圆圈底部圆圈
        UIImage *bottomRoundImage           = [UIImage imageNamed:@"chartBack"];
        UIImageView *bottomRoundImageView   = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth(progressRound)-7, viewHeight(progressRound)-7)];
        bottomRoundImageView.image          = bottomRoundImage;
        bottomRoundImageView.center         = progressRound.center;
        [self addSubview:bottomRoundImageView];

        [self addSubview:progressRound];
        
        UIButton *button = [[UIButton alloc] initWithFrame:progressRound.frame];
        [button addTarget:self action:@selector(showSeatUsedDetail:) forControlEvents:(UIControlEventTouchUpInside)];
        [progressRound addSubview:button];

        totalNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewX(progressRound),
                                                                           viewY(progressRound)+viewHeight(progressRound)/2-45+15,
                                                                           viewWidth(progressRound),
                                                                           45)];// 机位总数

        totalNumLabel.textAlignment = NSTextAlignmentCenter;
        totalNumLabel.font          = [UIFont fontWithName:@"PingFangSC-Semibold" size:px_px_2_2_3(95, 113, 113/2*3)];

        [self addSubview:totalNumLabel];
        
        UILabel *totalLabel         = [[UILabel alloc] initWithFrame:CGRectMake(viewX(progressRound),
                                                                                viewBotton(totalNumLabel)+7,
                                                                                viewWidth(progressRound),
                                                                                13)];
        totalLabel.text             = @"机位";
        totalLabel.textAlignment    = NSTextAlignmentCenter;
        totalLabel.font             =  [UIFont fontWithName:@"PingFangSC-Regular" size:px2(32)];
        [self addSubview:totalLabel];


        y=viewBotton(progressRound)+px_px_2_2_3(70,83, 135)+9.5;

        disable        = [[UILabel alloc] init];

        disable.textAlignment   = NSTextAlignmentCenter;
        disable.font            = [UIFont fontWithName:@"PingFang SC" size:px2(75)];
        CGSize maxSize          = CGSizeMake(100, 100);
        CGSize exportSize       = [disable sizeThatFits:maxSize];
        disable.frame           = CGRectMake(kScreenWidth/2-30-exportSize.width, y, exportSize.width, 30);
        [self addSubview:disable];

        percentLabel   = [[UILabel alloc]initWithFrame:CGRectMake(viewTrailing(disable), y-9.5, 50, 9.5)];

        percentLabel.font       = [UIFont fontWithName:@"PingFang SC" size:px2(23)];
        percentLabel.textColor  = [CommonFunction colorFromHex:0XFF2dce71];
//        exportSize = [percentLabel sizeThatFits:maxSize];
//        percentLabel.frame = CGRectMake(viewBotton(disable), viewY(disable)-15, exportSize.width, 15) ;
        [self addSubview:percentLabel];

        longInSeat                  = [[UILabel alloc] init];

        longInSeat.textAlignment    = NSTextAlignmentCenter;
        longInSeat.font             = [UIFont fontWithName:@"PingFang SC" size:px2(75)];
        exportSize                  = [longInSeat sizeThatFits:maxSize];
        longInSeat.frame            = CGRectMake(kScreenWidth/2+30, y, exportSize.width, 30);
        [self addSubview:longInSeat];

        y = viewY(disable)+viewHeight(disable)+px2(24);

        disAbleLabel= [[UILabel alloc] init];//
        disAbleLabel.text           = @"占用";
        disAbleLabel.textAlignment  = NSTextAlignmentCenter;
        disAbleLabel.font           = [UIFont fontWithName:@"PingFang SC" size:px2(30)];
        exportSize          = [disAbleLabel sizeThatFits:maxSize];
        disAbleLabel.frame  = CGRectMake((viewX(disable)+viewTrailing(disable))/2-exportSize.width/2+3, y, exportSize.width, 12);
        [self addSubview:disAbleLabel];

        disableImageView   = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DisableResource"]];
        disableImageView.frame          = CGRectMake(viewX(disAbleLabel)-6, viewY(disAbleLabel)+3, 6, 6);
        [self addSubview:disableImageView];


        longInSeatLabel = [[UILabel alloc] init];
        longInSeatLabel.text            = @"剩余";
        longInSeatLabel.textAlignment   = NSTextAlignmentCenter;
        longInSeatLabel.font            = [UIFont fontWithName:@"PingFang SC" size:px2(30)];
        exportSize = [longInSeatLabel sizeThatFits:maxSize];
        longInSeatLabel.frame           = CGRectMake((viewX(longInSeat)+viewTrailing(longInSeat))/2-exportSize.width/2+3,
                                                     y, exportSize.width, 12);
        [self addSubview:longInSeatLabel];


        longInSeatImageView    = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DisableResource"]];
        longInSeatImageView.frame           = CGRectMake(viewX(longInSeatLabel)-6, viewY(longInSeatLabel)+3, 6, 6);
        [self addSubview:longInSeatImageView];
//


        UIImageView *grayLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                                       viewY(disable)+px_px_2_2_3(8*2, 8*2, 8*3),
                                                                                       kScreenWidth,
                                                                                       px_px_2_2_3(80, 94, 94/2*3))];
        grayLineImageView.image = [UIImage imageNamed:@"GrayCurves"];
        [self addSubview:grayLineImageView];
       

        UIImageView *greenLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                                        viewY(disable)-px_px_2_2_3(8, 16*2, 16*3),
                                                                                        kScreenWidth,
                                                                                        px_px_2_2_3(80, 94, 94/2*3))];
        greenLineImageView.image        = [UIImage imageNamed:@"GreenCurves"];
        [self addSubview:greenLineImageView];


        CGFloat width       = (viewWidth(self)-16*3)/2;
        UIImage *lessImage  = [UIImage imageNamed:@"lessThanBackground"];
        CGFloat height      = width *lessImage.size.height/lessImage.size.width;
        UIView *lessView    = [[UIView alloc]initWithFrame:CGRectMake(16, viewHeight(self)-height-px_px_2_2_3(30*2, 40*2, 40*3),width, height)];
        [self addSubview:lessView];
        
        UIImageView *lessThanImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,viewWidth(lessView),viewHeight(lessView))];
        lessThanImageView.image         = lessImage;
        [lessView addSubview:lessThanImageView];

        UIImage *arrImage               = [UIImage imageNamed:@"ArrFlight"];
        UIImageView *arrImageView       = [[UIImageView alloc]initWithFrame:CGRectMake(px_px_2_2_3(20, 20, 30),
                                                                                   (viewHeight(lessView)-arrImage.size.height)/2,
                                                                                   arrImage.size.width,
                                                                                   arrImage.size.height)];
        arrImageView.image          = arrImage;
        [lessView addSubview:arrImageView];

        arrLabel   = [[UILabel alloc]initWithFrame:CGRectMake(viewTrailing(arrImageView)+px_px_2_2_3(5, 20, 30),
                                                                     viewHeight(lessView)/2-20,
                                                                     viewWidth(lessView)-viewTrailing(arrImageView),
                                                                     20)];
        arrLabel.font       = [UIFont fontWithName:@"PingFangSC-Semibold" size:px_px_2_2_3(20*2, 28*2, 28*3)];
        NSMutableAttributedString *arrAttributeString = [[NSMutableAttributedString alloc ] initWithString:[NSString stringWithFormat:@"%@机位占用",@(_seatStatusModel.nextIn).stringValue]];
        [arrAttributeString addAttribute:NSFontAttributeName
                                   value:[UIFont fontWithName:@"PingFangSC-Regular" size:8]
                                   range:NSMakeRange(arrAttributeString.length-4, 4)];
        arrLabel.attributedText = arrAttributeString;
        [lessView addSubview:arrLabel];

        UILabel *lessLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewX(arrLabel),
                                                                      viewBotton(arrLabel)+10,
                                                                      viewWidth(lessView)-viewTrailing(arrImageView),
                                                                      13)];
        lessLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:px_px_2_2_3(25, 32, 48)];
        lessLabel.text = @"<1小时进港";
        [lessView addSubview:lessLabel];

        UIView *moreView    = [[UIView alloc]initWithFrame:CGRectMake(viewTrailing(lessView)+16,  viewY(lessView), width, height)];
        [self addSubview:moreView];
        UIImageView *moreThanImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,viewWidth(moreView), viewHeight(moreView))];
        moreThanImageView.image         = [UIImage imageNamed:@"lessThanBackground"];
        [moreView addSubview:moreThanImageView];

        UIImage *depImage = [UIImage imageNamed:@"DepFlight"];
        UIImageView *depImageView = [[UIImageView alloc]initWithFrame:CGRectMake(px_px_2_2_3(20, 20, 30),
                                                                                 (viewHeight(moreView)-depImage.size.height)/2,
                                                                                 depImage.size.width,
                                                                                 depImage.size.height)];
        depImageView.image = depImage;
        [moreView addSubview:depImageView];

        depLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewTrailing(depImageView)+px_px_2_2_3(5, 20, 30),
                                                                     viewHeight(lessView)/2-20,
                                                                     viewWidth(moreView)-viewTrailing(depImageView),
                                                                     20)];
        depLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold"
                                        size:px_px_2_2_3(20*2, 28*2, 28*3)];
        NSMutableAttributedString *depAttributeString = [[NSMutableAttributedString alloc ] initWithString:[NSString stringWithFormat:@"%@机位占用",@(_seatStatusModel.nextOut).stringValue]];
        [depAttributeString addAttribute:NSFontAttributeName
                                   value:[UIFont fontWithName:@"PingFangSC-Regular" size:8]
                                   range:NSMakeRange(depAttributeString.length-4, 4)];
        depLabel.attributedText = depAttributeString;
        [moreView addSubview:depLabel];

        UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewX(depLabel),
                                                                      viewBotton(arrLabel)+10,
                                                                      viewWidth(lessView)-viewTrailing(arrImageView),
                                                                      13)];
        moreLabel.font = [UIFont fontWithName:@"PingFangSC-Regular"
                                         size:px_px_2_2_3(25, 32, 48)];
        moreLabel.text = @"<1小时出港";
        [moreView addSubview:moreLabel];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadData:)
                                                     name:@"CraftSeatTakeUpInfo"
                                                   object:nil];

    }
    [self resetData];
    return self;
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"CraftSeatTakeUpInfo"
                                                  object:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeatUsedModel *model    = array[indexPath.row];
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:(NSString *)RESOURCECONTENT_TABLECELL_IDENTIFIER];
    
    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault)
//                                     reuseIdentifier:model.type];
//        
//        [cell addSubview:[CommonFunction addLabelFrame:CGRectMake(20, 0, 30, 30)
//                                                  text:model.type
//                                                  font:30
//                                         textAlignment:(NSTextAlignmentLeft)
//                                          colorFromHex:0xFF1B1B1B]];
//        [cell addSubview:[CommonFunction addLabelFrame:CGRectMake(50, 0, kScreenWidth/2-50-30, 13)
//                                                  text:[NSString stringWithFormat:@"占用 %i",model.used]
//                                                  font:12
//                                         textAlignment:(NSTextAlignmentLeft)
//                                          colorFromHex:0xFF1B1B1B]];
//        [cell addSubview:[CommonFunction addLabelFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2-50, 12)
//                                                  text:[NSString stringWithFormat:@"空余 %i",model.free]
//                                                  font:12
//                                         textAlignment:(NSTextAlignmentRight)
//                                          colorFromHex:0xFF1B1B1B]];
//        
//        LDProgressView *progressF   = [[LDProgressView alloc] initWithFrame:CGRectMake(50, 12+3, kScreenWidth-100, 10)];
//        progressF.color             = [CommonFunction colorFromHex:0XFF05CA6E];
//        progressF.progress          = [model getPercent];
//        progressF.showText          = @NO;
//        progressF.animate           = @YES;
//        progressF.showBackgroundInnerShadow = @NO;
//        progressF.type              = LDProgressSolid;
//        progressF.outerStrokeWidth  = @NO;
//        progressF.showStroke        = @NO;
//        progressF.background        = [CommonFunction colorFromHex:0XFFE9EDF1];
//        [cell addSubview:progressF];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)showSeatUsedDetail:(UIButton *)sender
{
    if (_type == ResourceContentViewTypeMain) {
        if([CommonFunction hasFunction:OV_CRAFTSEAT_MAIN]){
            [_delegate showSeatUsedMainDetailView];
        }

    }else{
        if ([CommonFunction hasFunction:OV_CRAFTSEAT_BRANCH]) {
            [_delegate showSeatUsedSubDetailView];
        }
    }


}

-(void)loadData:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[SeatStatusModel class]]) {
        _seatStatusModel = notification.object;
        [self resetData];

    }
}

-(void)resetData
{
    if (_type == ResourceContentViewTypeMain) {

        normalProportion =@((_seatStatusModel.normalTakeUpCnt+_seatStatusModel.parentTakeUpCnt)/(float)(_seatStatusModel.normalCnt + _seatStatusModel.parentTakeUpCnt)).floatValue;
        [progressRound animationWithStrokeEnd:normalProportion withProgressType:ProgreesTypeNormal];

        //机位
        totalNumLabel.text      = @(_seatStatusModel.normalCnt + _seatStatusModel.parentCnt).stringValue;

        //占用
        disable.text            = @(_seatStatusModel.normalTakeUpCnt + _seatStatusModel.parentTakeUpCnt).stringValue;
        CGSize maxSize          = CGSizeMake(100, 100);
        CGSize exportSize       = [disable sizeThatFits:maxSize];
        disable.frame           = CGRectMake(kScreenWidth/2-30-exportSize.width, viewY(disable), exportSize.width, 30);
        //百分比
        percentLabel.text       = [NSString stringWithFormat:@"%ld%%",(long)@((_seatStatusModel.normalTakeUpCnt+_seatStatusModel.parentTakeUpCnt)/@(_seatStatusModel.normalCnt + _seatStatusModel.parentTakeUpCnt).floatValue*100).integerValue];
        //剩余
        longInSeat.text             = @(_seatStatusModel.normalCnt + _seatStatusModel.parentCnt-(_seatStatusModel.normalTakeUpCnt+_seatStatusModel.parentTakeUpCnt)).stringValue;
        exportSize                  = [longInSeat sizeThatFits:maxSize];
        longInSeat.frame            = CGRectMake(kScreenWidth/2+30, viewY(longInSeat), exportSize.width, 30);

        NSMutableAttributedString *arrAttributeString = [[NSMutableAttributedString alloc ] initWithString:[NSString stringWithFormat:@"%@机位占用",@(_seatStatusModel.nextIn).stringValue]];
        [arrAttributeString addAttribute:NSFontAttributeName
                                   value:[UIFont fontWithName:@"PingFangSC-Regular" size:8]
                                   range:NSMakeRange(arrAttributeString.length-4, 4)];
        arrLabel.attributedText = arrAttributeString;

        NSMutableAttributedString *depAttributeString = [[NSMutableAttributedString alloc ] initWithString:[NSString stringWithFormat:@"%@机位占用",@(_seatStatusModel.nextOut).stringValue]];
        [depAttributeString addAttribute:NSFontAttributeName
                                   value:[UIFont fontWithName:@"PingFangSC-Regular" size:8]
                                   range:NSMakeRange(depAttributeString.length-4, 4)];
        depLabel.attributedText = depAttributeString;
    }else if (_type == ResourceContentViewTypeSub){
        normalProportion =@((_seatStatusModel.normalTakeUpCnt+_seatStatusModel.childTakeUpCnt)/(float)(_seatStatusModel.normalCnt + _seatStatusModel.childCnt)).floatValue;
        [progressRound animationWithStrokeEnd:normalProportion withProgressType:ProgreesTypeNormal];


        //机位
        totalNumLabel.text      = @(_seatStatusModel.normalCnt + _seatStatusModel.childCnt).stringValue;


        //占用
        disable.text            = @(_seatStatusModel.normalTakeUpCnt+_seatStatusModel.childTakeUpCnt).stringValue;
        CGSize maxSize          = CGSizeMake(100, 100);
        CGSize exportSize       = [disable sizeThatFits:maxSize];
        disable.frame           = CGRectMake(kScreenWidth/2-30-exportSize.width, viewY(disable), exportSize.width, 30);
        //百分比
        percentLabel.text       = [NSString stringWithFormat:@"%ld%%",(long)@((_seatStatusModel.normalTakeUpCnt+_seatStatusModel.childTakeUpCnt)/@(_seatStatusModel.normalCnt + _seatStatusModel.childCnt).floatValue*100).integerValue];
        //剩余
        longInSeat.text             = @(_seatStatusModel.normalCnt + _seatStatusModel.childCnt-(_seatStatusModel.normalTakeUpCnt+_seatStatusModel.childTakeUpCnt)).stringValue;
        exportSize                  = [longInSeat sizeThatFits:maxSize];
        longInSeat.frame            = CGRectMake(kScreenWidth/2+30, viewY(longInSeat), exportSize.width, 30);

        NSMutableAttributedString *arrAttributeString = [[NSMutableAttributedString alloc ] initWithString:[NSString stringWithFormat:@"%@机位占用",@(_seatStatusModel.nextIn).stringValue]];
        [arrAttributeString addAttribute:NSFontAttributeName
                                   value:[UIFont fontWithName:@"PingFangSC-Regular" size:8]
                                   range:NSMakeRange(arrAttributeString.length-4, 4)];
        arrLabel.attributedText = arrAttributeString;

        NSMutableAttributedString *depAttributeString = [[NSMutableAttributedString alloc ] initWithString:[NSString stringWithFormat:@"%@机位占用",@(_seatStatusModel.nextOut).stringValue]];
        [depAttributeString addAttribute:NSFontAttributeName
                                   value:[UIFont fontWithName:@"PingFangSC-Regular" size:8]
                                   range:NSMakeRange(depAttributeString.length-4, 4)];
        depLabel.attributedText = depAttributeString;


    }
    //对数据进行动画
    [progressRound animationWithStrokeEnd:normalProportion withProgressType:ProgreesTypeNormal];
    [progressRound animationWithStrokeEnd:abnormalProportion withProgressType:ProgreesTypeAbnormal];
    [progressRound animationWithStrokeEnd:cancleProportion withProgressType:ProgreesTypeCancel];
    CGSize maxSize          = CGSizeMake(100, 100);
    CGSize exportSize       = [disable sizeThatFits:maxSize];
    exportSize          = [disAbleLabel sizeThatFits:maxSize];
    disAbleLabel.frame  = CGRectMake((viewX(disable)+viewTrailing(disable))/2-exportSize.width/2+3, viewY(disAbleLabel), exportSize.width, 12);
    disableImageView.frame          = CGRectMake(viewX(disAbleLabel)-6, viewY(disAbleLabel)+3, 6, 6);
    exportSize = [longInSeatLabel sizeThatFits:maxSize];
    longInSeatLabel.frame           = CGRectMake((viewX(longInSeat)+viewTrailing(longInSeat))/2-exportSize.width/2+3,
                                                 viewY(longInSeatLabel),
                                                 exportSize.width,
                                                 12);
    longInSeatImageView.frame           = CGRectMake(viewX(longInSeatLabel)-6, viewY(longInSeatLabel)+3, 6, 6);

}

@end
