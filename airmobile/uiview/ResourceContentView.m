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

@implementation ResourceContentView
{
    NSMutableArray<SeatUsedModel *> *array;
}

-(id)initWithFrame:(CGRect)frame delegate:(id<ResourceContentViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if(self){
//        self.backgroundColor = [UIColor lightGrayColor];
        _delegate = delegate;

        CGFloat y = px2(90);
        
        //圆圈
        RoundProgressView *progressRound = [[RoundProgressView alloc] initWithCenter:CGPointMake(kScreenWidth/2, y+86) radius:86 aboveColos:@[(__bridge id)[CommonFunction colorFromHex:0XFF00aedd].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF00d6a0].CGColor ] belowColos:@[(__bridge id)[CommonFunction colorFromHex:0XFFFF9F38].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFFCD21].CGColor ] start:270 end:271 clockwise:NO];
        [self addSubview:progressRound];
        
        normalProportion = 0.6;
        abnormalProportion = 0.6;
        cancleProportion = 0.6;
        
        //对数据进行动画
        [progressRound animationWithStrokeEnd:normalProportion withProgressType:ProgreesTypeNormal];
        [progressRound animationWithStrokeEnd:abnormalProportion withProgressType:ProgreesTypeAbnormal];
        [progressRound animationWithStrokeEnd:cancleProportion withProgressType:ProgreesTypeCancel];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 86*2, 86*2)];
        [button addTarget:self action:@selector(showSeatUsedDetail:) forControlEvents:(UIControlEventTouchUpInside)];
        [progressRound addSubview:button];

        UILabel *totalNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewX(progressRound), viewY(progressRound)+viewHeight(progressRound)/2-45+15, viewWidth(progressRound), 45)];// 机位总数
        totalNumLabel.text = @"325";
        totalNumLabel.textAlignment = NSTextAlignmentCenter;
        totalNumLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:px2(113)];

        [self addSubview:totalNumLabel];
        
        UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewX(progressRound), viewBotton(totalNumLabel)+7, viewWidth(progressRound), 13)];
        totalLabel.text = @"机位";
        totalLabel.textAlignment = NSTextAlignmentCenter;
        totalLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:px2(32)];
        [self addSubview:totalLabel];


        y=viewBotton(progressRound)+83/2+9.5;

        UILabel *disable = [[UILabel alloc] init];
        disable.text = @"28";
        disable.textAlignment = NSTextAlignmentCenter;
        disable.font = [UIFont fontWithName:@"PingFang SC" size:px2(75)];
        CGSize maxSize = CGSizeMake(100, 100);
        CGSize exportSize = [disable sizeThatFits:maxSize];
        disable.frame = CGRectMake(kScreenWidth/2-30-exportSize.width, y, exportSize.width, 30);
        [self addSubview:disable];

        UILabel *percentLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewTrailing(disable), y-9.5, 50, 9.5)];
        percentLabel.text = @"25%";
        percentLabel.font = [UIFont fontWithName:@"PingFang SC" size:px2(23)];
        percentLabel.textColor = [CommonFunction colorFromHex:0XFF2dce71];
//        exportSize = [percentLabel sizeThatFits:maxSize];
//        percentLabel.frame = CGRectMake(viewBotton(disable), viewY(disable)-15, exportSize.width, 15) ;
        [self addSubview:percentLabel];

        UILabel *longInSeat = [[UILabel alloc] init];
        longInSeat.text = @"64";
        longInSeat.textAlignment = NSTextAlignmentCenter;
        longInSeat.font = [UIFont fontWithName:@"PingFang SC" size:px2(75)];
        exportSize = [longInSeat sizeThatFits:maxSize];
        longInSeat.frame = CGRectMake(kScreenWidth/2+30, y, exportSize.width, 30);
        [self addSubview:longInSeat];

        y = viewY(disable)+viewHeight(disable)+px2(24);

        UILabel *disAbleLabel= [[UILabel alloc] init];// 不可用
        disAbleLabel.text = @"占用";
        disAbleLabel.textAlignment = NSTextAlignmentCenter;
        disAbleLabel.font = [UIFont fontWithName:@"PingFang SC" size:px2(30)];
        exportSize = [disAbleLabel sizeThatFits:maxSize];
        disAbleLabel.frame =CGRectMake((viewX(disable)+viewTrailing(disable))/2-exportSize.width/2+3, y, exportSize.width, 12);
        [self addSubview:disAbleLabel];

        UIImageView *disableImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DisableResource"]];
        disableImageView.frame = CGRectMake(viewX(disAbleLabel)-6, viewY(disAbleLabel)+3, 6, 6);
        [self addSubview:disableImageView];


        UILabel *longInSeatLabel = [[UILabel alloc] init];// 长期占用
        longInSeatLabel.text = @"剩余";
        longInSeatLabel.textAlignment = NSTextAlignmentCenter;
        longInSeatLabel.font = [UIFont fontWithName:@"PingFang SC" size:px2(30)];
        exportSize = [longInSeatLabel sizeThatFits:maxSize];
        longInSeatLabel.frame = CGRectMake((viewX(longInSeat)+viewTrailing(longInSeat))/2-exportSize.width/2+3, y, exportSize.width, 12);
        [self addSubview:longInSeatLabel];


        UIImageView *longInSeatImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DisableResource"]];
        longInSeatImageView.frame = CGRectMake(viewX(longInSeatLabel)-6, viewY(longInSeatLabel)+3, 6, 6);
        [self addSubview:longInSeatImageView];
//


        UIImageView *grayLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewY(disable)+8, kScreenWidth, 94)];
        grayLineImageView.image = [UIImage imageNamed:@"GrayCurves"];
        [self addSubview:grayLineImageView];
       

        UIImageView *greenLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewY(disable)-16, kScreenWidth, 94)];
        greenLineImageView.image = [UIImage imageNamed:@"GreenCurves"];
        [self addSubview:greenLineImageView];


        UIView *lessView = [[UIView alloc]initWithFrame:CGRectMake(15, viewHeight(self)-54-164/2, 338/2, 164/2)];
        [self addSubview:lessView];

        UIImageView *lessThanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 338/2, 164/2)];
        lessThanImageView.image = [UIImage imageNamed:@"lessThanBackground"];
        [lessView addSubview:lessThanImageView];

        UIImage *arrImage = [UIImage imageNamed:@"ArrFlight"];
        UIImageView *arrImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (viewHeight(lessView)-arrImage.size.height)/2, arrImage.size.width, arrImage.size.height)];
        arrImageView.image = arrImage;
        [lessView addSubview:arrImageView];

        UILabel *arrLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewTrailing(arrImageView)+10, 20, viewWidth(lessView)-viewTrailing(arrImageView), 20)];
        arrLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:28];
        NSMutableAttributedString *arrAttributeString = [[NSMutableAttributedString alloc ] initWithString:[NSString stringWithFormat:@"%@机位占用",@"200"]];
        [arrAttributeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:8] range:NSMakeRange(arrAttributeString.length-4, 4)];
        arrLabel.attributedText = arrAttributeString;
        [lessView addSubview:arrLabel];

        UILabel *lessLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewTrailing(arrImageView)+10, viewBotton(arrLabel)+10, viewWidth(lessView)-viewTrailing(arrImageView), 13)];
        lessLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:48/3];
        lessLabel.text = @"<1小时进港";
        [lessView addSubview:lessLabel];

        UIView *moreView = [[UIView alloc]initWithFrame:CGRectMake(viewWidth(self)-15-338/2,  viewHeight(self)-54-164/2, 338/2, 164/2)];
        [self addSubview:moreView];
        UIImageView *moreThanImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 338/2, 164/2)];
        moreThanImageView.image = [UIImage imageNamed:@"lessThanBackground"];
        [moreView addSubview:moreThanImageView];

        UIImage *depImage = [UIImage imageNamed:@"DepFlight"];
        UIImageView *depImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (viewHeight(moreView)-depImage.size.height)/2, depImage.size.width, depImage.size.height)];
        depImageView.image = depImage;
        [moreView addSubview:depImageView];

        UILabel *depLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewTrailing(depImageView)+10, 20, viewWidth(moreView)-viewTrailing(depImageView), 20)];
        depLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:28];
        NSMutableAttributedString *depAttributeString = [[NSMutableAttributedString alloc ] initWithString:[NSString stringWithFormat:@"%@机位占用",@"200"]];
        [depAttributeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:8] range:NSMakeRange(depAttributeString.length-4, 4)];
        depLabel.attributedText = depAttributeString;
        [moreView addSubview:depLabel];

        UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewTrailing(depImageView)+10, viewBotton(arrLabel)+10, viewWidth(lessView)-viewTrailing(arrImageView), 13)];
        moreLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:48/3];
        moreLabel.text = @">1小时出港";
        [moreView addSubview:moreLabel];

    }
    return self;
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

-(void)showSeatUsedDetail:(UIButton *)sender
{
    [_delegate showSeatUsedDetailView];
}

@end
