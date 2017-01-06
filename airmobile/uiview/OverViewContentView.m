//
//  OverViewContentView.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/16.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "OverViewContentView.h"
#import "TagView.h"
#import "SummaryModel.h"
#import "NightShiftRoomViewController.h"
#import "HomePageService.h"

@interface OverViewContentView ()

@property (nonatomic, strong) UITextView  *noticeTextView; //底部提示文字

@end

@implementation OverViewContentView
{
    UIView *caleandarView;
    UIImageView *tagImageView;
    UILabel *calendarLabel;     // 当天日期
    UILabel *totalNumLabel;     // 圆图中间数字
    TagView *planView;          // 未执行
    TagView *finishView;        //已经执行
    TagView *ratioView;         //放行率
    UILabel *currentStatus;     //小面积延误
    RoundProgressView   *progressRound; //圆
    UILabel *lowTimelabel;
}


-(id)initWithFrame:(CGRect)                         frame
          delegate:(id<OverviewContentViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    
    if(self){

        SummaryModel *summaryModel = [HomePageService sharedHomePageService].summaryModel;

        float y = 0;
        _delegate = delegate;

        y+=px_px_2_2_3(60,77, 141);
        caleandarView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-190/2,
                                                                         y,
                                                                         190,
                                                                         px2(35))];
        [self addSubview:caleandarView];
        
        UIImageView *calendarImage = [CommonFunction imageView:@"HomeCalendar" frame:CGRectMake(0,
                                                                                                0,
                                                                                                px2(34),
                                                                                                px2(35))];
        [caleandarView addSubview:calendarImage];
        CGSize maxLabelSize = CGSizeMake(100, CGFLOAT_MAX);
        calendarLabel       = [[UILabel alloc] init];
        calendarLabel.text  = summaryModel.flightDate;
        calendarLabel.font  = [UIFont fontWithName:@"PingFangSC-Regular"
                                             size:px_px_2_3(36, 60)];
        calendarLabel.textColor     = [CommonFunction colorFromHex:0XFF3E3737];
        calendarLabel.textAlignment = NSTextAlignmentCenter;
        CGSize expectSize           = [calendarLabel sizeThatFits:maxLabelSize];
        calendarLabel.frame         = CGRectMake(viewWidth(calendarImage)+px_px_2_3(16, 27),
                                                0,
                                                 expectSize.width,
                                                 px2(35));
        [caleandarView addSubview:calendarLabel];
        tagImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewTrailing(caleandarView)+px_px_2_3(15, 25),
                                                                                 px2((35-8)/2),
                                                                                 px2(16),
                                                                                 px2(8))];
        tagImageView.image = [UIImage imageNamed:@"CalendarTag"];
        [caleandarView addSubview:tagImageView];
        float width         = viewWidth(tagImageView)+viewWidth(calendarLabel);
        caleandarView.frame = CGRectMake((viewWidth(self)-width)/2,
                                         viewY(caleandarView),
                                         width,
                                         viewHeight(caleandarView));


        y=viewY(caleandarView)+viewHeight(caleandarView)+ px_px_2_3(19, 34)+px_px_2_2_3(40,52, 89);
//        UIButton *chiefButton = [[UIButton alloc]init];
//        [chiefButton setTitle:@"当日值班表"
//                     forState:UIControlStateNormal];
//        chiefButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular"
//                                                      size:px_px_2_3(29, 49)];
//        chiefButton.titleLabel.textColor = [UIColor blackColor];
//        [chiefButton setTitleColor:[UIColor blackColor]
//                          forState:UIControlStateNormal];
//        [chiefButton addTarget:self
//                        action:@selector(chiefButtonClick:)
//              forControlEvents:UIControlEventTouchUpInside];
//        maxLabelSize = CGSizeMake(154, 20);
//        expectSize = [chiefButton sizeThatFits:maxLabelSize];
//        chiefButton.frame = CGRectMake((kScreenWidth-expectSize.width)/2,
//                                       y,
//                                       expectSize.width,
//                                       px2(29));
//        [self addSubview:chiefButton];

//        y= viewHeight(chiefButton)+viewY(chiefButton)+px_px_2_2_3(40,52, 89);


        //圆圈
        progressRound = [[RoundProgressView alloc]initWithCenter:CGPointMake(kScreenWidth/2,
                                                                                                y+px_px_2_2_3(80*2,95*2, 680/2))
                                                                             radius:px_px_2_2_3(80*2,95*2,
                                                                                                (680-61)/2)
                                                                         aboveColos:@[(__bridge id)[CommonFunction colorFromHex:0XFFc62dec].CGColor,
                                                                                      (__bridge id)[CommonFunction colorFromHex:0XFF46bacd].CGColor ]
                                                                         belowColos:@[(__bridge id)[CommonFunction colorFromHex:0XFFFF9F38].CGColor,
                                                                                      (__bridge id)[CommonFunction colorFromHex:0XFFFFCD21].CGColor ]
                                                                              start:270
                                                                                end:271
                                                                          clockwise:NO];

        
        normalProportion    =summaryModel.finishedCnt/ @(summaryModel.allCnt).floatValue;


        //对数据进行动画
        [progressRound animationWithStrokeEnd:normalProportion
                             withProgressType:ProgreesTypeNormal];
        [progressRound animationWithStrokeEnd:abnormalProportion
                             withProgressType:ProgreesTypeAbnormal];
        [progressRound animationWithStrokeEnd:cancleProportion
                             withProgressType:ProgreesTypeCancel];

        //圆圈底部圆圈
        UIImage *bottomRoundImage = [UIImage imageNamed:@"chartBack"];
        UIImageView *bottomRoundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                         0,
                                                                                         viewWidth(progressRound)-7,
                                                                                         viewHeight(progressRound)-7)];
        bottomRoundImageView.image  = bottomRoundImage;
        bottomRoundImageView.center = progressRound.center;
        [self addSubview:bottomRoundImageView];
        [self addSubview:progressRound];
        
        totalNumLabel      = [[UILabel alloc] init ];
        totalNumLabel.text          = [NSString stringWithFormat:@"%d", summaryModel.allCnt];
        totalNumLabel.textAlignment = NSTextAlignmentCenter;
        totalNumLabel.font          = [UIFont fontWithName:@"PingFangSC-Semibold"
                                              size:px_px_2_2_3(100, 111, 55*3)];
        maxLabelSize        = CGSizeMake(100,50);
        expectSize          = [totalNumLabel sizeThatFits:maxLabelSize];
        totalNumLabel.frame = CGRectMake((kScreenWidth - expectSize.width)/2,
                                         viewY(progressRound)+((viewHeight(progressRound)-45)/2)-45/4,
                                         expectSize.width,
                                         45);
        totalNumLabel.adjustsFontSizeToFitWidth = YES;
        //totalNumLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:totalNumLabel];
        
        UIButton *totalButton = [[UIButton alloc] initWithFrame:totalNumLabel.frame];
        [totalButton addTarget:self
                        action:@selector(showFlightHourView:)
              forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:totalButton];
        
        UILabel *totalLabel         = [[UILabel alloc] init];
        totalLabel.text             = @"计划总数";
        totalLabel.textAlignment    = NSTextAlignmentCenter;
        totalLabel.font         =  [UIFont fontWithName:@"PingFangSC-Regular" size:px2(32)];
        totalLabel.textColor    = [CommonFunction colorFromHex:0XFF818181];
        totalLabel.frame        = CGRectMake((kScreenWidth-80)/2,
                                             viewY(totalNumLabel)+viewHeight(totalNumLabel)+px_px_2_3(17, 28),
                                             80,
                                             15);
        [self addSubview:totalLabel];

        y = viewY(progressRound)+viewHeight(progressRound)+px_px_2_2_3(40,59, 99);
        //未执行
        planView = [[NSBundle mainBundle]loadNibNamed:@"TagView" owner:nil options:nil][0];
        [planView bigText:[NSString stringWithFormat:@"%d",summaryModel.unfinishedCnt]
              bigFontSize:px_px_2_2_3(65,73, 123)
                smallText:@"未执行"
            smallFontSize:px_px_2_3(30, 50) interval:px_px_2_2_3(20,32, 39)
                 tagImage:[UIImage imageNamed:@"status_green"]];

        planView.frame = CGRectMake((kScreenWidth-[planView contentWidth])/2,
                                    y,
                                    [planView contentWidth],
                                    [planView contentHeight]);
        [self addSubview:planView];

        finishView = [[NSBundle mainBundle]loadNibNamed:@"TagView"
                                                           owner:nil
                                                         options:nil][0];
        [finishView bigText:[NSString stringWithFormat:@"%d",summaryModel.finishedCnt]
                bigFontSize:px_px_2_2_3(65,73, 123)
                  smallText:@"已执行"
              smallFontSize:px_px_2_3(30, 50)
                   interval:px_px_2_2_3(20,32, 39)
                   tagImage:[UIImage imageNamed:@"StatusBlue"]];
        finishView.frame = CGRectMake(viewX(planView)-px_px_2_3(98, 167)-[finishView contentWidth],
                                      y,
                                      [finishView contentWidth],
                                      [finishView contentHeight]);
        [self addSubview:finishView];



        ratioView = [[NSBundle mainBundle]loadNibNamed:@"TagView"
                                                          owner:nil
                                                        options:nil][0];
        [ratioView bigText:[NSString stringWithFormat:@"%.1f",[summaryModel.releaseRatio floatValue] *100]
               bigFontSize:px_px_2_2_3(65,73, 123)
                 smallText:@"放行率"
             smallFontSize:px_px_2_3(30, 50)
                  interval:px_px_2_2_3(20,32, 39)
                  tagImage:[UIImage imageNamed:@"StatusRed"]];
        ratioView.frame = CGRectMake(viewX(planView)+viewWidth(planView)+px_px_2_3(98, 167),
                                     y,
                                     [ratioView contentWidth],
                                     [ratioView contentHeight]);
        [self addSubview:ratioView];

        UIButton *ratioButton = [[UIButton alloc] initWithFrame:ratioView.frame];
        [ratioButton addTarget:self
                        action:@selector(showRatioView:)
              forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:ratioButton];


        y = viewY(ratioView)+viewHeight(ratioView)+px_px_2_2_3(10,20, 30);
        currentStatus = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-px2(342))/2,
                                                                          y,
                                                                          px2(342),
                                                                          px_px_2_2_3(90, 114, 57*3) )];
        currentStatus.text = summaryModel.warning;
        currentStatus.textAlignment = NSTextAlignmentCenter;
        currentStatus.font          =  [UIFont fontWithName:@"PingFangSC-Regular" size:px2(32)];

        if([summaryModel.warning containsString:@"红色"]){
            currentStatus.textColor = [CommonFunction colorFromHex:0xfff30f0f];
        }else if([summaryModel.warning containsString:@"橙色"]){
            currentStatus.textColor = [CommonFunction colorFromHex:0xffff8f22];
        }else if([summaryModel.warning containsString:@"黄色"]){
            currentStatus.textColor = [CommonFunction colorFromHex:0xfffcf02d];
        }else if([summaryModel.warning containsString:@"蓝色"]){
             currentStatus.textColor = [CommonFunction colorFromHex:0xfff0266c];
        }else{
             currentStatus.textColor = [CommonFunction colorFromHex:0xff12d865];
        }


        currentStatus.textColor = [CommonFunction colorFromHex:0XFFF46970];
        [self addSubview:currentStatus];

        UIButton *indicateButton = [[UIButton alloc] initWithFrame:currentStatus.frame];
        [indicateButton addTarget:self
                           action:@selector(showAlterIndicateView:)
                 forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:indicateButton];

        y = viewY(currentStatus)+viewHeight(currentStatus)+px_px_2_3(10, 15);
        UIImageView *lineImageView  = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-px_px_2_3(718, 1056))/2,
                                                                                   y,
                                                                                   px2(718),
                                                                                   px2(3))];
        lineImageView.image         = [UIImage imageNamed:@"hiddenLine"];
        [self addSubview:lineImageView];


        UIView *lowView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                 viewBotton(lineImageView),
                                                                 kScreenWidth,
                                                                 kScreenHeight-viewBotton(lineImageView)-5-49-76 )];

        [self addSubview:lowView];

        lowTimelabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, 70, viewHeight(lowView))];
        lowTimelabel.text = summaryModel.flightDate;
//        lowTimelabel.backgroundColor = [UIColor blackColor];
        lowTimelabel.textAlignment = NSTextAlignmentCenter;
        lowTimelabel.adjustsFontSizeToFitWidth = YES;

        [lowView addSubview:lowTimelabel];

        _noticeTextView                  = [[UITextView alloc] initWithFrame:CGRectMake(viewTrailing(lowTimelabel),
                                                                                       5,
                                                                                       viewWidth(lowView)-156,
                                                                                       viewHeight(lowView)-10)];
        _noticeTextView.text             = summaryModel.aovTxt;
        _noticeTextView.textAlignment    = NSTextAlignmentCenter;
        _noticeTextView.font             = [UIFont systemFontOfSize:12];
        _noticeTextView.editable         = NO;
        [lowView addSubview:_noticeTextView];

        UIImageView *lowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        lowImageView.image = [UIImage imageNamed:@"Completed"];
        lowImageView.center = CGPointMake(viewTrailing(_noticeTextView)+75/2, viewHeight(lowView)/2);
        [lowView addSubview:lowImageView];
    }
    //添加刷新通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadData:)
                                                 name:@"SummaryInfo"
                                               object:nil];
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"SummaryInfo"
                                                  object:nil];
}

#pragma mark - 事件
-(void) showFlightHourView:(UIButton *)sender
{
    if([CommonFunction hasFunction:OV_WHOLE_ALLHOUR]){
        [_delegate showFlightHourView];
    }
}

-(void) showAlterIndicateView:(UIButton *)sender
{
    if([CommonFunction hasFunction:OV_WHOLE_STATUS]){
        [_delegate showWorningIndicatorView];
    }
}

-(void) showRatioView:(UIButton *)sender
{
    if([CommonFunction hasFunction:OV_WHOLE_RELEASED]){
        [_delegate showReleasedRatioView];
    }
}


-(void)chiefButtonClick:(UIButton *)sender
{
    NightShiftRoomViewController *dayOnDutyVC = [[NightShiftRoomViewController alloc]initWithNibName:@"NightShiftRoomViewController"
                                                                                    bundle:nil];

   [[self rootViewController].navigationController pushViewController:dayOnDutyVC
                                                             animated:YES];
}

#pragma mark - 自定义方法
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

-(void) loadData:(NSNotification *)notification
{


    if (totalNumLabel.text!=nil&&
        ![totalNumLabel.text isEqualToString:@""]&&
        ![totalNumLabel.text isEqualToString:@"0"]) {
        return;
    }


    SummaryModel *summaryModel = notification.object;
    calendarLabel.text  = summaryModel.flightDate;
    CGSize maxLabelSize = CGSizeMake(100, CGFLOAT_MAX);
    CGSize expectSize           = [calendarLabel sizeThatFits:maxLabelSize];
    calendarLabel.frame         = CGRectMake(viewX(calendarLabel),
                                             0,
                                             expectSize.width,
                                             px2(35));
     float width         = viewWidth(tagImageView)+viewWidth(calendarLabel);
    caleandarView.frame = CGRectMake((viewWidth(self)-width)/2,
                                     viewY(caleandarView),
                                     width,
                                     viewHeight(caleandarView));

    totalNumLabel.text          = [NSString stringWithFormat:@"%d", summaryModel.allCnt];

    CGRect origleRect = totalNumLabel.frame;
    totalNumLabel.frame = CGRectMake((kScreenWidth - expectSize.width)/2,
                                     origleRect.origin.y,
                                     expectSize.width,
                                     45);
    normalProportion    =summaryModel.finishedCnt/ @(summaryModel.allCnt).floatValue;
    //对数据进行动画
    [progressRound animationWithStrokeEnd:normalProportion
                         withProgressType:ProgreesTypeNormal];


    planView.bigLabel.text   = [NSString stringWithFormat:@"%d",  summaryModel.unfinishedCnt];      // 未执行
    finishView.bigLabel.text = [NSString stringWithFormat:@"%d",  summaryModel.finishedCnt];        //已经执行
    ratioView.bigLabel.text  = [NSString stringWithFormat:@"%.1f",[summaryModel.releaseRatio floatValue] *100];     //放行率

    currentStatus.text = summaryModel.warning;
    if([summaryModel.warning containsString:@"红色"]){
        currentStatus.textColor = [CommonFunction colorFromHex:0xfff30f0f];
    }else if([summaryModel.warning containsString:@"橙色"]){
        currentStatus.textColor = [CommonFunction colorFromHex:0xffff8f22];
    }else if([summaryModel.warning containsString:@"黄色"]){
        currentStatus.textColor = [CommonFunction colorFromHex:0xfffcf02d];
    }else if([summaryModel.warning containsString:@"蓝色"]){
        currentStatus.textColor = [CommonFunction colorFromHex:0xfff0266c];
    }else{
        currentStatus.textColor = [CommonFunction colorFromHex:0xff12d865];
    }
    lowTimelabel.text = summaryModel.flightDate;

    _noticeTextView.text         = summaryModel.aovTxt;

}

@end
