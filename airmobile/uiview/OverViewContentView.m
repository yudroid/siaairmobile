//
//  OverViewContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "OverViewContentView.h"
#import "DayOnDutyViewController.h"
#import "UILabel+Business.h"
#import "TagView.h"

@implementation OverViewContentView


-(id)initWithFrame:(CGRect)frame delegate:(id<OverviewContentViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    
    if(self){

        float y = 0;

        _delegate = delegate;
         

        y+=px_px_2_3(77, 141);
        UIView *caleandarView = [[UIView alloc]
                                 initWithFrame:CGRectMake(kScreenWidth/2-190/2, y, 190, px2(35))];
        //caleandarView.backgroundColor = [UIColor grayColor];
        [self addSubview:caleandarView];
        
        UIImageView *calendarImage = [CommonFunction imageView:@"HomeCalendar"
                                                         frame:CGRectMake(0, 0, px2(34), px2(35))];
        [caleandarView addSubview:calendarImage];
        CGSize maxLabelSize = CGSizeMake(100, CGFLOAT_MAX);
        UILabel *calendarLabel = [[UILabel alloc] init];
        calendarLabel.text = @"2016-10-17";
        calendarLabel.font = [UIFont fontWithName:@"PingFang SC" size:px_px_2_3(36, 60)];
        calendarLabel.textColor = [CommonFunction colorFromHex:0XFF3E3737];
        calendarLabel.textAlignment = NSTextAlignmentCenter;
        CGSize expectSize = [calendarLabel sizeThatFits:maxLabelSize];
        calendarLabel.frame = CGRectMake(viewWidth(calendarImage)+px_px_2_3(16, 27), 0, expectSize.width, px2(35));
        [caleandarView addSubview:calendarLabel];
        UIImageView *tagImageView = [[UIImageView alloc]initWithFrame:CGRectMake(calendarLabel.frame.origin.x+calendarLabel.frame.size.width+px_px_2_3(15, 25), px2((35-8)/2), px2(16), px2(8))];
        tagImageView.image = [UIImage imageNamed:@"CalendarTag"];
        [caleandarView addSubview:tagImageView];
        float width = viewWidth(tagImageView)+viewX(tagImageView);
        caleandarView.frame = CGRectMake((viewWidth(self)-width)/2, viewY(caleandarView), width, viewHeight(caleandarView));


        y=viewY(caleandarView)+viewHeight(caleandarView)+ px_px_2_3(19, 34);
        UIButton *chiefButton = [[UIButton alloc]init];
        [chiefButton setTitle:@"当日值班表" forState:UIControlStateNormal];
        chiefButton.titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:px_px_2_3(29, 49)];
        chiefButton.titleLabel.textColor = [UIColor blackColor];
        [chiefButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chiefButton addTarget:self
                        action:@selector(chiefButtonClick:)
              forControlEvents:UIControlEventTouchUpInside];
        maxLabelSize = CGSizeMake(154, 20);
        expectSize = [chiefButton sizeThatFits:maxLabelSize];
        chiefButton.frame = CGRectMake((kScreenWidth-expectSize.width)/2, y, expectSize.width, px2(29));
        [self addSubview:chiefButton];
//        chiefButton.backgroundColor = [UIColor grayColor];

        y= viewHeight(chiefButton)+viewY(chiefButton)+px_px_2_3(52, 89);
        //圆圈
        RoundProgressView *progressRound = [[RoundProgressView alloc]
                                            initWithCenter:CGPointMake(kScreenWidth/2, y+px_px_2_3(86*2, 680))
                                            radius:px_px_2_3(86*2, 680) aboveColos:@[(__bridge id)[CommonFunction colorFromHex:0XFFc62dec].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFF46bacd].CGColor ] belowColos:@[(__bridge id)[CommonFunction colorFromHex:0XFFFF9F38].CGColor,(__bridge id)[CommonFunction colorFromHex:0XFFFFCD21].CGColor ] start:270 end:271 clockwise:NO];
        [self addSubview:progressRound];
        
        normalProportion = 0.6;
        abnormalProportion = 0.62;
        cancleProportion = 0.65;
        
        //对数据进行动画
        [progressRound animationWithStrokeEnd:normalProportion withProgressType:ProgreesTypeNormal];
        [progressRound animationWithStrokeEnd:abnormalProportion withProgressType:ProgreesTypeAbnormal];
        [progressRound animationWithStrokeEnd:cancleProportion withProgressType:ProgreesTypeCancel];
        
        
        UILabel *totalNumLabel = [[UILabel alloc] init ];
        totalNumLabel.text = @"800";
        totalNumLabel.textAlignment = NSTextAlignmentCenter;
        totalNumLabel.font =  [UIFont fontWithName:@"PingFang SC" size:px2(111)];
        maxLabelSize = CGSizeMake(100,50);
        expectSize = [totalNumLabel sizeThatFits:maxLabelSize];
        totalNumLabel.frame = CGRectMake((kScreenWidth - expectSize.width)/2,viewY(progressRound)+((viewHeight(progressRound)-45)/2)-45/4, expectSize.width, 45);
//        totalNumLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:totalNumLabel];
        
        UIButton *totalButton = [[UIButton alloc] initWithFrame:totalNumLabel.frame];
        [totalButton addTarget:self action:@selector(showFlightHourView:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:totalButton];
        
        UILabel *totalLabel = [[UILabel alloc] init];
        totalLabel.text = @"计划总数";
        totalLabel.textAlignment = NSTextAlignmentCenter;
        totalLabel.font =  [UIFont fontWithName:@"PingFang SC" size:px2(32)];
        totalLabel.textColor = [CommonFunction colorFromHex:0XFF818181];
        maxLabelSize = CGSizeMake(100, 35);
        expectSize = [totalNumLabel sizeThatFits:maxLabelSize];
        totalLabel.frame = CGRectMake((kScreenWidth-expectSize.width)/2, viewY(totalNumLabel)+viewHeight(totalNumLabel)+px_px_2_3(17, 28), expectSize.width, 15);
        [self addSubview:totalLabel];

        y = viewY(progressRound)+viewHeight(progressRound)+px_px_2_3(59, 99);

        //未执行
        TagView *planView = [[NSBundle mainBundle]loadNibNamed:@"TagView" owner:nil options:nil][0];
        [planView bigText:@"500" bigFontSize:5 smallText:@"计划" smallFontSize:50 interval:10 tagImage:nil];
        planView.frame = CGRectMake((kScreenWidth-[planView contentWidth])/2, y, [planView contentWidth], [planView contentHeight]);
        [self addSubview:planView];

//        UILabel *planNum = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, viewY(progressRound)+viewHeight(progressRound)+px2(59), 100, 30)];
//        planNum.text = @"311";
//        planNum.textAlignment = NSTextAlignmentCenter;
//        planNum.font =  [UIFont fontWithName:@"PingFang SC" size:35];
//        [self addSubview:planNum];
//
//        UILabel *planLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, viewHeight(finished)+viewY(finished)+px2(25), 100, 13)];
//        planLabel.text = @"未执行";
//        planLabel.textAlignment = NSTextAlignmentCenter;
//        planLabel.font =  [UIFont fontWithName:@"PingFang SC" size:12];
//        [self addSubview:planLabel];


//        TagView *finishView = [[NSBundle mainBundle]loadNibNamed:@"TagView" owner:nil options:nil][0];
//        finishView.bigLabel.text = @"489";
//        finishView.bigLabel.font = [UIFont fontWithName:@"PingPang SC" size:px_px_2_3(73, 123)];
//        finishView.smallLabel.font = [UIFont fontWithName:@"PingPang SC" size:px_px_2_3(30, 50)];
//        finishView.interval = px_px_2_3(25, 39);
//        finishView.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//        UILabel *finished = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-150, y, 100, px2(59))];
//        finished.text = @"489";
//        finished.textAlignment = NSTextAlignmentCenter;
//        finished.font =  [UIFont fontWithName:@"PingFang SC" size:px2(73)];
//        [self addSubview:finished];
//        
//        UILabel *finishedLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-150, viewHeight(finished)+viewY(finished)+px2(25), 100, px2(30))];
//        finishedLabel.text = @"已执行";
//        finishedLabel.textAlignment = NSTextAlignmentCenter;
//        finishedLabel.font =  [UIFont fontWithName:@"PingFang SC" size:12];
//        [self addSubview:finishedLabel];
//        
//
//        
//        UILabel *ratio = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2+50, viewY(progressRound)+viewHeight(progressRound)+px2(59), 100, 30)];
//        ratio.text = @"80%";
//        ratio.textAlignment = NSTextAlignmentCenter;
//        ratio.font =  [UIFont fontWithName:@"PingFang SC" size:35];
//        [self addSubview:ratio];
//        
//        UIButton *ratioButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2+50, viewHeight(finished)+viewY(finished)+px2(25), 100, 40)];
//        [ratioButton addTarget:self action:@selector(showRatioView:) forControlEvents:(UIControlEventTouchUpInside)];
//        [self addSubview:ratioButton];
//        
//        UILabel *ratioLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2+50, viewHeight(finished)+viewY(finished)+px2(25), 100, 13)];
//        ratioLabel.text = @"放行正常率";
//        ratioLabel.textAlignment = NSTextAlignmentCenter;
//        ratioLabel.font =  [UIFont fontWithName:@"PingFang SC" size:12];
//        [self addSubview:ratioLabel];
//        
//        UILabel *currentStatus = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-px2(342))/2,viewY(planLabel)+viewHeight(planLabel)+px2(44), px2(342), px2(114) )];
//        currentStatus.text = @"小面积延误";
//        currentStatus.textAlignment = NSTextAlignmentCenter;
//        currentStatus.font =  [UIFont fontWithName:@"PingFang SC" size:px2(32)];
//        currentStatus.textColor = [CommonFunction colorFromHex:0XFFF46970];
//        UIImageView *currentStatusBackgroundImageView = [[UIImageView alloc]initWithFrame:currentStatus.frame];
//        currentStatusBackgroundImageView.image = [UIImage imageNamed:@"currentStatusLabel"];
//        [self addSubview:currentStatusBackgroundImageView];
//        [self addSubview:currentStatus];
//        UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-px2(718))/2, viewHeight(currentStatus)+viewY(currentStatus)+px2(29), px2(718), px2(3))];
//        lineImageView.image = [UIImage imageNamed:@"line"];
//        [self addSubview:lineImageView];
//
//        UIButton *indicateButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 25+25+11+20+30+86*2+30+20+5+13+10+20, kScreenWidth-100, 40)];
//        [indicateButton addTarget:self action:@selector(showAlterIndicateView:) forControlEvents:(UIControlEventTouchUpInside)];
//        [self addSubview:indicateButton];
//        
//        UITextView *noticeTextView = [[UITextView alloc] initWithFrame:CGRectMake(50,viewY(lineImageView)+viewHeight(lineImageView), kScreenWidth-100, 50)];
//        noticeTextView.text = @"12:30   今日航班执行总体情况正常，因华东地区天气原因流量控制，前往该地区的航班放行正常率低于75%预计2小时候恢复正常";
//        noticeTextView.textAlignment = NSTextAlignmentLeft;
//        noticeTextView.font = [UIFont systemFontOfSize:12];
//        noticeTextView.editable = NO;
//        [self addSubview:noticeTextView];
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
