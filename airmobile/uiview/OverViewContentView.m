//
//  OverViewContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "OverViewContentView.h"

@implementation OverViewContentView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self){
        
//        self.backgroundColor = [UIColor lightGrayColor];
        
        UIView *caleandarView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-190/2, 25, 190, 25)];
        [self addSubview:caleandarView];
        
        UIImageView *calendarImage = [CommonFunction imageView:@"calendar" frame:CGRectMake(0, 0, 25, 25)];
        [caleandarView addSubview:calendarImage];
        UILabel *calendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 145, 25)];
        calendarLabel.text = @"2016-10-17";
        calendarLabel.textAlignment = NSTextAlignmentCenter;
        [caleandarView addSubview:calendarLabel];
        
        UILabel *chiefLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-154/2, 25+25+11, 154, 20)];
        chiefLabel.text = @"运行总监 杨总监";
        chiefLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:chiefLabel];
        
        //圆圈
        RoundProgressView *progressRound = [[RoundProgressView alloc] initWithCenter:CGPointMake(kScreenWidth/2, 25+25+11+20+30+86) radius:86 aboveColos:@[(__bridge id)[CommonFunction colorFromHex:0XFF00C7E4].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF00F383].CGColor ] belowColos:@[(__bridge id)[CommonFunction colorFromHex:0XFFFF9F38].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFFCD21].CGColor ] start:270 end:271 clockwise:NO];
        [self addSubview:progressRound];
        
        normalProportion = 0.6;
        abnormalProportion = 0.62;
        cancleProportion = 0.65;
        
        //对数据进行动画
        [progressRound animationWithStrokeEnd:normalProportion withProgressType:ProgreesTypeNormal];
        [progressRound animationWithStrokeEnd:abnormalProportion withProgressType:ProgreesTypeAbnormal];
        [progressRound animationWithStrokeEnd:cancleProportion withProgressType:ProgreesTypeCancel];
        
        
        UILabel *totalNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 25+25+11+20+30+86-40/2, 100, 35)];
        totalNumLabel.text = @"800";
        totalNumLabel.textAlignment = NSTextAlignmentCenter;
        totalNumLabel.font = [UIFont systemFontOfSize:35];
        [self addSubview:totalNumLabel];
        
        UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 25+25+11+20+30+86-17/2+30, 100, 13)];
        totalLabel.text = @"计划总数";
        totalLabel.textAlignment = NSTextAlignmentCenter;
        totalLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:totalLabel];
        
        UILabel *finished = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-150, 25+25+11+20+30+86*2+30, 100, 20)];
        finished.text = @"489";
        finished.textAlignment = NSTextAlignmentCenter;
        finished.font = [UIFont systemFontOfSize:20];
        [self addSubview:finished];
        
        UILabel *finishedLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-150, 25+25+11+20+30+86*2+30+20+5, 100, 13)];
        finishedLabel.text = @"已执行";
        finishedLabel.textAlignment = NSTextAlignmentCenter;
        finishedLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:finishedLabel];
        
        UILabel *planNum = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 25+25+11+20+30+86*2+30, 100, 20)];
        planNum.text = @"311";
        planNum.textAlignment = NSTextAlignmentCenter;
        planNum.font = [UIFont systemFontOfSize:20];
        [self addSubview:planNum];
        
        UILabel *planLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 25+25+11+20+30+86*2+30+20+5, 100, 13)];
        planLabel.text = @"未执行";
        planLabel.textAlignment = NSTextAlignmentCenter;
        planLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:planLabel];
        
        UILabel *ratio = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2+50, 25+25+11+20+30+86*2+30, 100, 20)];
        ratio.text = @"80%";
        ratio.textAlignment = NSTextAlignmentCenter;
        ratio.font = [UIFont systemFontOfSize:20];
        [self addSubview:ratio];
        
        UILabel *ratioLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2+50, 25+25+11+20+30+86*2+30+20+5, 100, 13)];
        ratioLabel.text = @"放行正常率";
        ratioLabel.textAlignment = NSTextAlignmentCenter;
        ratioLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:ratioLabel];
        
        UITextView *noticeTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, 25+25+11+20+30+86*2+30+20+5+13+10, kScreenWidth-100, 50)];
        noticeTextView.text = @"12:30   今日航班执行总体情况正常，因华东地区天气原因流量控制，前往该地区的航班放行正常率低于75%预计2小时候恢复正常";
        noticeTextView.textAlignment = NSTextAlignmentLeft;
        noticeTextView.font = [UIFont systemFontOfSize:12];
        noticeTextView.editable = NO;
        [self addSubview:noticeTextView];
    }
    return self;
}

@end
