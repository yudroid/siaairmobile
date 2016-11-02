//
//  OverViewContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "OverViewContentView.h"
#import "DayOnDutyViewController.h"

@implementation OverViewContentView


-(id)initWithFrame:(CGRect)frame delegate:(id<OverviewContentViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    
    if(self){
        _delegate = delegate;
        
        UIView *caleandarView = [[UIView alloc]
                                 initWithFrame:CGRectMake(kScreenWidth/2-190/2, 32, 190, 25)];
        caleandarView.backgroundColor = [UIColor grayColor];
        [self addSubview:caleandarView];
        
        UIImageView *calendarImage = [CommonFunction imageView:@"HomeCalendar"
                                                         frame:CGRectMake(0, 0, 24, 25)];
        [caleandarView addSubview:calendarImage];
        UILabel *calendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 145, 25)];
        calendarLabel.text = @"2016-10-17";
        calendarLabel.font = [UIFont fontWithName:@"PingFang SC" size:17];
        calendarLabel.textColor = [CommonFunction colorFromHex:0XFF3E3737];
        calendarLabel.textAlignment = NSTextAlignmentCenter;
        [caleandarView addSubview:calendarLabel];

        UIButton *chiefButton = [[UIButton alloc]
                                 initWithFrame:CGRectMake(kScreenWidth/2-154/2, 25+25+11, 154, 20)];
        [chiefButton setTitle:@"当日值班表" forState:UIControlStateNormal];
        chiefButton.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:14];
        chiefButton.titleLabel.textColor = [UIColor blackColor];
        [chiefButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chiefButton addTarget:self
                        action:@selector(chiefButtonClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:chiefButton];
        
        //圆圈
        RoundProgressView *progressRound = [[RoundProgressView alloc]
                                            initWithCenter:CGPointMake(kScreenWidth/2, 25+25+11+20+30+86)
                                            radius:86 aboveColos:@[(__bridge id)[CommonFunction colorFromHex:0XFF2ED5C7].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFCA29ED].CGColor ] belowColos:@[(__bridge id)[CommonFunction colorFromHex:0XFFFF9F38].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFFCD21].CGColor ] start:270 end:271 clockwise:NO];
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
        totalNumLabel.font =  [UIFont fontWithName:@"PingFang SC" size:35];
        [self addSubview:totalNumLabel];
        
        UIButton *totalButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 25+25+11+20+30+86-40/2, 100, 35)];
        [totalButton addTarget:self action:@selector(showFlightHourView:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:totalButton];
        
        UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 25+25+11+20+30+86-17/2+30, 100, 13)];
        totalLabel.text = @"计划总数";
        totalLabel.textAlignment = NSTextAlignmentCenter;
        totalLabel.font =  [UIFont fontWithName:@"PingFang SC" size:12];
        [self addSubview:totalLabel];
        
        UILabel *finished = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-150, 25+25+11+20+30+86*2+30, 100, 30)];
        finished.text = @"489";
        finished.textAlignment = NSTextAlignmentCenter;
        finished.font =  [UIFont fontWithName:@"PingFang SC" size:35];
        [self addSubview:finished];
        
        UILabel *finishedLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-150, 25+25+11+20+30+86*2+30+20+15, 100, 13)];
        finishedLabel.text = @"已执行";
        finishedLabel.textAlignment = NSTextAlignmentCenter;
        finishedLabel.font =  [UIFont fontWithName:@"PingFang SC" size:12];
        [self addSubview:finishedLabel];
        
        UILabel *planNum = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 25+25+11+20+30+86*2+30, 100, 30)];
        planNum.text = @"311";
        planNum.textAlignment = NSTextAlignmentCenter;
        planNum.font =  [UIFont fontWithName:@"PingFang SC" size:35];
        [self addSubview:planNum];
        
        UILabel *planLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 25+25+11+20+30+86*2+30+20+15, 100, 13)];
        planLabel.text = @"未执行";
        planLabel.textAlignment = NSTextAlignmentCenter;
        planLabel.font =  [UIFont fontWithName:@"PingFang SC" size:12];
        [self addSubview:planLabel];
        
        UILabel *ratio = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2+50, 25+25+11+20+30+86*2+30, 100, 30)];
        ratio.text = @"80%";
        ratio.textAlignment = NSTextAlignmentCenter;
        ratio.font =  [UIFont fontWithName:@"PingFang SC" size:35];
        [self addSubview:ratio];
        
        UIButton *ratioButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2+50, 25+25+11+20+30+86*2+30, 100, 40)];
        [ratioButton addTarget:self action:@selector(showRatioView:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:ratioButton];
        
        UILabel *ratioLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2+50, 25+25+11+20+30+86*2+30+20+15, 100, 13)];
        ratioLabel.text = @"放行正常率";
        ratioLabel.textAlignment = NSTextAlignmentCenter;
        ratioLabel.font =  [UIFont fontWithName:@"PingFang SC" size:12];
        [self addSubview:ratioLabel];
        
        UILabel *currentStatus = [CommonFunction addLabelFrame:CGRectMake(50, 25+25+11+20+30+86*2+30+20+5+13+10+20, kScreenWidth-100, 40) text:@"小面积延误" font:25 textAlignment:(NSTextAlignmentCenter) colorFromHex:0xFFFF0000];
        [self addSubview:currentStatus];
        
        UIButton *indicateButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 25+25+11+20+30+86*2+30+20+5+13+10+20, kScreenWidth-100, 40)];
        [indicateButton addTarget:self action:@selector(showAlterIndicateView:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:indicateButton];
        
        UITextView *noticeTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, 25+25+11+20+30+86*2+30+20+5+13+10+20+40, kScreenWidth-100, 50)];
        noticeTextView.text = @"12:30   今日航班执行总体情况正常，因华东地区天气原因流量控制，前往该地区的航班放行正常率低于75%预计2小时候恢复正常";
        noticeTextView.textAlignment = NSTextAlignmentLeft;
        noticeTextView.font = [UIFont systemFontOfSize:12];
        noticeTextView.editable = NO;
        [self addSubview:noticeTextView];
    }
    return self;
}


-(void) showFlightHourView:(UIButton *)sender
{
    [_delegate showFlightHourView];
}

-(void) showAlterIndicateView:(UIButton *)sender
{
    [_delegate showWorningIndicatorView];
}

-(void) showRatioView:(UIButton *)sender
{
    [_delegate showReleasedRatioView];
}

#pragma mark - EVENT
-(void)chiefButtonClick:(UIButton *)sender
{
    DayOnDutyViewController *dayOnDutyVC = [[DayOnDutyViewController alloc]initWithNibName:@"DayOnDutyViewController" bundle:nil];

   [[self rootViewController].navigationController pushViewController:dayOnDutyVC animated:YES];
}

#pragma mark - coustom function
// 获取视图所在的 viewcontroller
-(UIViewController *)rootViewController
{
    for (UIView *nextView = self.superview; nextView; nextView = nextView.superview) {
        UIResponder *responder = [nextView nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

@end
