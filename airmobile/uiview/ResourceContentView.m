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

        UILabel *totalNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 25+86-20, 100, 45)];// 机位总数
        totalNumLabel.text = @"325";
        totalNumLabel.textAlignment = NSTextAlignmentCenter;
        totalNumLabel.font = [UIFont fontWithName:@"PingFang SC" size:px2(113)];
        CGSize maxSize = CGSizeMake(100, 45);
        CGSize exportSize = [totalNumLabel sizeThatFits:maxSize];
        totalNumLabel.frame = CGRectMake((kScreenWidth-exportSize.width)/2, y+86/2+10, exportSize.width, 45);
        [self addSubview:totalNumLabel];
        
        UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, viewY(totalNumLabel)+viewHeight(totalNumLabel)+7, 100, 15)];
        totalLabel.text = @"机位";
        totalLabel.textAlignment = NSTextAlignmentCenter;
        totalLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:totalLabel];


        y=viewHeight(progressRound)+viewY(progressRound)+px2(83);

        TagView *useView = [[NSBundle mainBundle]loadNibNamed:@"TagView" owner:nil options:nil][0];
        useView.bigLabel.text = @"3";
        useView.smallLabel.text = @"占用";
        useView.frame =  CGRectMake(kScreenWidth/2-32-[useView contentWidth], y,[useView contentWidth], [useView contentHeight]-20);
        [self addSubview:useView];
        UILabel *disable = [[UILabel alloc] init];
        disable.text = @"3";
        disable.textAlignment = NSTextAlignmentCenter;
        disable.font = [UIFont fontWithName:@"PingFang SC" size:px2(75)];
        exportSize = [disable sizeThatFits:maxSize];
        disable.frame = CGRectMake(kScreenWidth/2-32-exportSize.width, y, exportSize.width, 30);
        [self addSubview:disable];

        UILabel *percentLabel = [[UILabel alloc]init];
        percentLabel.text = @"25%";
        percentLabel.font = [UIFont fontWithName:@"PingFang SC" size:px2(23)];
        percentLabel.textColor = [CommonFunction colorFromHex:0XFF2dce71];
        exportSize = [percentLabel sizeThatFits:maxSize];
        percentLabel.frame = CGRectMake(viewWidth(disable)+viewX(disable), viewY(disable)-15, exportSize.width, 15) ;
        [self addSubview:percentLabel];

        UILabel *longInSeat = [[UILabel alloc] init];
        longInSeat.text = @"10";
        longInSeat.textAlignment = NSTextAlignmentCenter;
        longInSeat.font = [UIFont fontWithName:@"PingFang SC" size:px2(75)];
        exportSize = [longInSeat sizeThatFits:maxSize];
        longInSeat.frame = CGRectMake(kScreenWidth/2+32, y, exportSize.width, 30);
        [self addSubview:longInSeat];

        y = viewY(disable)+viewHeight(disable)+px2(24);
        UILabel *disAbleLabel= [[UILabel alloc] initWithFrame:CGRectMake(viewX(disable), y, 30, 30)];// 不可用
        disAbleLabel.text = @"占用";
        disAbleLabel.textAlignment = NSTextAlignmentCenter;
        disAbleLabel.font = [UIFont fontWithName:@"PingFang SC" size:px2(30)];
        [self addSubview:disAbleLabel];

        UILabel *longInSeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, y, kScreenWidth/2, 25)];// 长期占用
        longInSeatLabel.text = @"剩余";
        longInSeatLabel.textAlignment = NSTextAlignmentCenter;
        longInSeatLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:longInSeatLabel];
//

        
        
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
