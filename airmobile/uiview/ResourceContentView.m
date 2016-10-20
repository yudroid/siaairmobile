//
//  ResourceContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/12.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "ResourceContentView.h"

@implementation ResourceContentView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
//        self.backgroundColor = [UIColor lightGrayColor];
        
        //圆圈
        RoundProgressView *progressRound = [[RoundProgressView alloc] initWithCenter:CGPointMake(kScreenWidth/2, 25+86) radius:86
                                                                          aboveColos:@[(__bridge id)[CommonFunction colorFromHex:0XFF00C7E4].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF00F383].CGColor ]
                                                                          belowColos:@[(__bridge id)[CommonFunction colorFromHex:0XFFFF9F38].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFFCD21].CGColor ] start:150.0f end:45 clockwise:YES];
        [self addSubview:progressRound];
        
        normalProportion = 0.6;
        abnormalProportion = 0.2;
        cancleProportion = 0.05;
        
        //对数据进行动画
        [progressRound animationWithStrokeEnd:normalProportion withProgressType:ProgreesTypeNormal];
        [progressRound animationWithStrokeEnd:abnormalProportion withProgressType:ProgreesTypeAbnormal];
        [progressRound animationWithStrokeEnd:cancleProportion withProgressType:ProgreesTypeCancel];
        

        UILabel *totalNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 25+86-40, 100, 45)];// 机位总数
        totalNumLabel.text = @"325";
        totalNumLabel.textAlignment = NSTextAlignmentCenter;
        totalNumLabel.font = [UIFont systemFontOfSize:45];
        [self addSubview:totalNumLabel];
        
        UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 25+86+5, 100, 15)];
        totalLabel.text = @"机位";
        totalLabel.textAlignment = NSTextAlignmentCenter;
        totalLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:totalLabel];
        
        UILabel *inSeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-60, 25+86+5+15+5, 70, 15)];// 当前停占
        inSeatLabel.text = @"当前停占";
        inSeatLabel.textAlignment = NSTextAlignmentCenter;
        inSeatLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:inSeatLabel];
        
        UILabel *nightNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2+15, 25+86+5+15+5, 50, 15)];
        nightNumLabel.text = @"245";
        nightNumLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:nightNumLabel];
        
        
        UILabel *disAbleLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 25+86+5+15+5+65, kScreenWidth/4, 15)];// 不可用
        disAbleLabel.text = @"不可用";
        disAbleLabel.textAlignment = NSTextAlignmentCenter;
        disAbleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:disAbleLabel];
        
        UILabel *disable = [[UILabel alloc] initWithFrame:CGRectMake(0, 25+86+5+15+5+65+15+5, kScreenWidth/4, 15)];
        disable.text = @"3";
        disable.textAlignment = NSTextAlignmentCenter;
        disable.font = [UIFont systemFontOfSize:15];
        [self addSubview:disable];
        
        UILabel *longInSeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4, 25+86+5+15+5+65, kScreenWidth/4, 15)];// 长期占用
        longInSeatLabel.text = @"长期占用";
        longInSeatLabel.textAlignment = NSTextAlignmentCenter;
        longInSeatLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:longInSeatLabel];
        
        UILabel *longInSeat = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4, 25+86+5+15+5+65+15+5, kScreenWidth/4, 15)];
        longInSeat.text = @"10";
        longInSeat.textAlignment = NSTextAlignmentCenter;
        longInSeat.font = [UIFont systemFontOfSize:15];
        [self addSubview:longInSeat];
        
        UILabel *nightLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 25+86+5+15+5+65, kScreenWidth/4, 15)];// 过夜
        nightLabel.text = @"过夜停占";
        nightLabel.textAlignment = NSTextAlignmentCenter;
        nightLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:nightLabel];
        
        UILabel *nightNum = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 25+86+5+15+5+65+15+5, kScreenWidth/4, 15)];
        nightNum.text = @"247";
        nightNum.textAlignment = NSTextAlignmentCenter;
        nightNum.font = [UIFont systemFontOfSize:15];
        [self addSubview:nightNum];
        
        UILabel *freeSeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*3/4, 25+86+5+15+5+65, kScreenWidth/4, 15)];// 空余 325-13-247
        freeSeatLabel.text = @"空余";
        freeSeatLabel.textAlignment = NSTextAlignmentCenter;
        freeSeatLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:freeSeatLabel];
        
        UILabel *freeSeat = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth*3/4, 25+86+5+15+5+65+15+5, kScreenWidth/4, 15)];
        freeSeat.text = @"65";
        freeSeat.textAlignment = NSTextAlignmentCenter;
        freeSeat.font = [UIFont systemFontOfSize:20];
        [self addSubview:freeSeat];
        
        UILabel *typeBLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 25+86+5+15+5+65+15+5+40, kScreenWidth-30, 13)];//325-275
        typeBLabel.text = @"机位类型 B类";
        typeBLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:typeBLabel];
        
        UILabel *typeBUsed = [[UILabel alloc] initWithFrame:CGRectMake(50, 25+86+5+15+5+65+15+5+40+15, kScreenWidth/2-50, 12)];
        typeBUsed.text = @"占用35";
        typeBUsed.font = [UIFont systemFontOfSize:12];
        [self addSubview:typeBUsed];
        
        UILabel *typeBFree = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 25+86+5+15+5+65+15+5+40+15, kScreenWidth/2-50, 12)];
        typeBFree.text = @"空余15";
        typeBFree.font = [UIFont systemFontOfSize:12];
        typeBFree.textAlignment = NSTextAlignmentRight;
        [self addSubview:typeBFree];
        
        LDProgressView *progressB= [[LDProgressView alloc] initWithFrame:CGRectMake(50, 25+86+5+15+5+65+15+5+40+15+12+3, kScreenWidth-100, 12)];
        progressB.color = [CommonFunction colorFromHex:0XFF05CA6E];
        progressB.progress = 0.30;
        progressB.showText = @NO;
        progressB.animate = @YES;
        progressB.showBackgroundInnerShadow = @NO;
        progressB.type = LDProgressSolid;
        progressB.outerStrokeWidth = @NO;
        progressB.showStroke = @NO;
        progressB.background = [CommonFunction colorFromHex:0XFFE9EDF1];
        [self addSubview:progressB];
        
        UILabel *typeCLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 25+86+5+15+5+65+15+5+40+55, kScreenWidth-30, 13)];//145
        typeCLabel.text = @"机位类型 C类";
        typeCLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:typeCLabel];
        
        UILabel *typeCUsed = [[UILabel alloc] initWithFrame:CGRectMake(50, 25+86+5+15+5+65+15+5+40+55+15, kScreenWidth/2-50, 12)];
        typeCUsed.text = @"占用120";
        typeCUsed.font = [UIFont systemFontOfSize:12];
        [self addSubview:typeCUsed];
        
        UILabel *typeCFree = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 25+86+5+15+5+65+15+5+40+55+15, kScreenWidth/2-50, 12)];
        typeCFree.text = @"空余25";
        typeCFree.font = [UIFont systemFontOfSize:12];
        typeCFree.textAlignment = NSTextAlignmentRight;
        [self addSubview:typeCFree];
        
        LDProgressView *progressC= [[LDProgressView alloc] initWithFrame:CGRectMake(50, 25+86+5+15+5+65+15+5+40+55+15+12+3, kScreenWidth-100, 12)];
        progressC.color = [CommonFunction colorFromHex:0XFF05CA6E];
        progressC.progress = 0.80;
        progressC.showText = @NO;
        progressC.animate = @YES;
        progressC.showBackgroundInnerShadow = @NO;
        progressC.type = LDProgressSolid;
        progressC.outerStrokeWidth = @NO;
        progressC.showStroke = @NO;
        progressC.background = [CommonFunction colorFromHex:0XFFE9EDF1];
        [self addSubview:progressC];
        
        UILabel *typeDLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 25+86+5+15+5+65+15+5+40+55+55, kScreenWidth-30, 13)];
        typeDLabel.text = @"机位类型 D类";
        typeDLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:typeDLabel];
        
        UILabel *typeDUsed = [[UILabel alloc] initWithFrame:CGRectMake(50, 25+86+5+15+5+65+15+5+40+55+55+15, kScreenWidth/2-50, 12)];//50
        typeDUsed.text = @"占用35";
        typeDUsed.font = [UIFont systemFontOfSize:12];
        [self addSubview:typeDUsed];
        
        UILabel *typeDFree = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 25+86+5+15+5+65+15+5+40+55+55+15, kScreenWidth/2-50, 12)];
        typeDFree.text = @"空余15";
        typeDFree.font = [UIFont systemFontOfSize:12];
        typeDFree.textAlignment = NSTextAlignmentRight;
        [self addSubview:typeDFree];
        
        LDProgressView *progressD= [[LDProgressView alloc] initWithFrame:CGRectMake(50, 25+86+5+15+5+65+15+5+40+55+55+15+12+3, kScreenWidth-100, 12)];
        progressD.color = [CommonFunction colorFromHex:0XFF05CA6E];
        progressD.progress = 0.40;
        progressD.showText = @NO;
        progressD.animate = @YES;
        progressD.showBackgroundInnerShadow = @NO;
        progressD.type = LDProgressSolid;
        progressD.outerStrokeWidth = @NO;
        progressD.showStroke = @NO;
        progressD.background = [CommonFunction colorFromHex:0XFFE9EDF1];
        [self addSubview:progressD];
        
        UILabel *typeELabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 25+86+5+15+5+65+15+5+40+55+55+55, kScreenWidth-30, 13)];
        typeELabel.text = @"机位类型 E类";
        typeELabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:typeELabel];
        
        UILabel *typeEUsed = [[UILabel alloc] initWithFrame:CGRectMake(50, 25+86+5+15+5+65+15+5+40+55+55+55+15, kScreenWidth/2-50, 12)];//50
        typeEUsed.text = @"占用45";
        typeEUsed.font = [UIFont systemFontOfSize:12];
        [self addSubview:typeEUsed];
        
        UILabel *typeEFree = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 25+86+5+15+5+65+15+5+40+55+55+55+15, kScreenWidth/2-50, 12)];
        typeEFree.text = @"空余 5";
        typeEFree.font = [UIFont systemFontOfSize:12];
        typeEFree.textAlignment = NSTextAlignmentRight;
        [self addSubview:typeEFree];
        
        LDProgressView *progressE= [[LDProgressView alloc] initWithFrame:CGRectMake(50, 25+86+5+15+5+65+15+5+40+55+55+55+15+12+3, kScreenWidth-100, 10)];
        progressE.color = [CommonFunction colorFromHex:0XFF05CA6E];
        progressE.progress = 0.60;
        progressE.showText = @NO;
        progressE.animate = @YES;
        progressE.showBackgroundInnerShadow = @NO;
        progressE.type = LDProgressSolid;
        progressE.outerStrokeWidth = @NO;
        progressE.showStroke = @NO;
        progressE.background = [CommonFunction colorFromHex:0XFFE9EDF1];
        [self addSubview:progressE];
        
        UILabel *typeFLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 25+86+5+15+5+65+15+5+40+55+55+55+55, kScreenWidth-30, 13)];
        typeFLabel.text = @"机位类型 F类";
        typeFLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:typeFLabel];
        
        UILabel *typeFUsed = [[UILabel alloc] initWithFrame:CGRectMake(50, 25+86+5+15+5+65+15+5+40+55+55+55+55+15, kScreenWidth/2-50, 13)];//30
        typeFUsed.text = @"占用25";
        typeFUsed.font = [UIFont systemFontOfSize:12];
        [self addSubview:typeFUsed];
        
        UILabel *typeFFree = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2, 25+86+5+15+5+65+15+5+40+55+55+55+55+15, kScreenWidth/2-50, 12)];
        typeFFree.text = @"空余 5";
        typeFFree.font = [UIFont systemFontOfSize:12];
        typeFFree.textAlignment = NSTextAlignmentRight;
        [self addSubview:typeFFree];
        
        LDProgressView *progressF= [[LDProgressView alloc] initWithFrame:CGRectMake(50, 25+86+5+15+5+65+15+5+40+55+55+55+55+15+12+3, kScreenWidth-100, 10)];
        progressF.color = [CommonFunction colorFromHex:0XFF05CA6E];
        progressF.progress = 0.70;
        progressF.showText = @NO;
        progressF.animate = @YES;
        progressF.showBackgroundInnerShadow = @NO;
        progressF.type = LDProgressSolid;
        progressF.outerStrokeWidth = @NO;
        progressF.showStroke = @NO;
        progressF.background = [CommonFunction colorFromHex:0XFFE9EDF1];
        [self addSubview:progressF];
    }
    return self;
}

@end
