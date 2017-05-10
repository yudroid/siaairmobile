//
//  OverContentView.m
//  airmobile
//
//  Created by xuesong on 2017/4/21.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "OverContentView.h"
#import "PNPieChart.h"
#import "LDProgressView.h"
#import "SummaryModel.h"
#import "HomePageService.h"
#import "NSString+Size.h"

@implementation OverContentView
{
    
    PNPieChart *roundProgress;

    __weak IBOutlet UIView *roundView;
    UIView *arrLegend ;
    __weak IBOutlet NSLayoutConstraint *textViewHeight;
}


-(void)awakeFromNib
{
    [super awakeFromNib];

    NSArray *roundArray=[self updateShapeArray];

    roundProgress = [[PNPieChart alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    viewHeight(_chartView)-30,
                                                                    viewHeight(_chartView)-30)
                                                   items:roundArray];
//    roundProgress.center                     = CGPointMake(kScreenWidth/2,viewHeight(roundView)/2.0);
    roundProgress.descriptionTextColor       = [UIColor clearColor];
    roundProgress.descriptionTextFont        = [UIFont fontWithName:@"PingFangSC-Regular" size:29/2];
    roundProgress.descriptionTextShadowColor = [UIColor clearColor];
    roundProgress.showAbsoluteValues         = YES;
    roundProgress.showOnlyValues             = YES;

    roundProgress.legendStyle                = PNLegendItemStyleStacked;
    roundProgress.legendFont                 = [UIFont fontWithName:@"PingFangSC-Regular" size:9];
    roundProgress.legendFontColor            = [CommonFunction colorFromHex:0xff595757];
    [roundProgress strokeChart];
    [roundView addSubview:roundProgress];



//    _tadayRatioView.color = [CommonFunction colorFromHex:0XFF05CA6E];
//    _tadayRatioView.progress = 0.5;
//    _tadayRatioView.showText = @NO;
//    _tadayRatioView.animate = @YES;
//    _tadayRatioView.showBackgroundInnerShadow = @NO;
//    _tadayRatioView.type = LDProgressSolid;
//    _tadayRatioView.outerStrokeWidth = @NO;
//    _tadayRatioView.showStroke = @NO;
//    _tadayRatioView.background = [CommonFunction colorFromHex:0XFFE9EDF1];
//
//    _monthRatioView.color = [CommonFunction colorFromHex:0XFF05CA6E];
//    _monthRatioView.progress = 0.5;
//    _monthRatioView.showText = @NO;
//    _monthRatioView.animate = @YES;
//    _monthRatioView.showBackgroundInnerShadow = @NO;
//    _monthRatioView.type = LDProgressSolid;
//    _monthRatioView.outerStrokeWidth = @NO;
//    _monthRatioView.showStroke = @NO;
//    _monthRatioView.background = [CommonFunction colorFromHex:0XFFE9EDF1];

    
    arrLegend = [roundProgress getLegendWithMaxWidth:200];
    [arrLegend setFrame:CGRectMake(kScreenWidth-viewWidth(roundProgress)/2,
                                   viewHeight(_chartView)-viewHeight(arrLegend),
                                   arrLegend.frame.size.width,
                                   arrLegend.frame.size.height)];
    [_chartView addSubview:arrLegend];

    _queueQueryButton.layer.cornerRadius = 15;
    _normalRatioButton.layer.cornerRadius = 15;

    [self updateData];

    //添加刷新通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateData)
                                                 name:@"SummaryInfo"
                                               object:nil];

}


-(NSArray *) updateShapeArray
{
    NSMutableArray *array = [NSMutableArray array];

    SummaryModel *summaryModel = [HomePageService sharedHomePageService].summaryModel;

    //已执行
    NSInteger finished = summaryModel.inFinished + summaryModel.outFinished;
    NSInteger notFinished = summaryModel.inNoFinished + summaryModel.outNoFinished;
    NSInteger cancel = summaryModel.inCancel + summaryModel.outCancel;
    NSInteger delay = summaryModel.inDelay + summaryModel.outDelay;


        //间隔块大小
        float interval = (finished + notFinished + cancel +delay)/360.0 *5;
        if(finished>0){
            [array addObject: [PNPieChartDataItem dataItemWithValue:interval
                                                              color:[UIColor clearColor]]];
        }
        [array addObject: [PNPieChartDataItem dataItemWithValue:finished
                                                          color:[CommonFunction colorFromHex:0xFF00B0D8]
                                                    description:[NSString stringWithFormat:@"%@:%ld",@"已执行",finished]]];
        if (notFinished>0) {
            [array addObject: [PNPieChartDataItem dataItemWithValue:interval
                                                              color:[UIColor clearColor]]];
        }

        [array addObject: [PNPieChartDataItem dataItemWithValue:notFinished
                                                          color:[CommonFunction colorFromHex:0xFFC8C8C8]
                                                    description:[NSString stringWithFormat:@"%@:%ld",@"未执行",notFinished]]];

    if (delay>0) {
        [array addObject: [PNPieChartDataItem dataItemWithValue:interval
                                                          color:[UIColor clearColor]]];
    }
    [array addObject: [PNPieChartDataItem dataItemWithValue:delay
                                                      color:[CommonFunction colorFromHex:0xFFFFCD21]
                                                description:[NSString stringWithFormat:@"%@:%ld",@"延   误",delay]]];
        if (cancel>0) {
            [array addObject: [PNPieChartDataItem dataItemWithValue:interval
                                                              color:[UIColor clearColor]]];
        }

        [array addObject: [PNPieChartDataItem dataItemWithValue:cancel
                                                          color:[CommonFunction colorFromHex:0xFFFF4D62]
                                                    description:[NSString stringWithFormat:@"%@:%ld",@"取   消",cancel]]];



    return [array copy];

}

-(void)updateData
{
    SummaryModel *summaryModel = [HomePageService sharedHomePageService].summaryModel;
    _planNumLabel.text = @(summaryModel.planTotal).stringValue;
    _timeLabel.text = summaryModel.flightDate;
    _leaderUserNameLabel.text = summaryModel.leaderUserName;
    _directorLabel.text = summaryModel.userName;
    _arrSpeedLabel.text = [NSString stringWithFormat:@"%.1f分钟/架",summaryModel.inSpeed];
    _depSpeedLabel.text = [NSString stringWithFormat:@"%.1f分钟/架",summaryModel.releaseSpeed];

    _optionalStatusLabel.text = summaryModel.warning;
    if([summaryModel.warning containsString:@"红色"]){
        _optionalStatusLabel.textColor = [CommonFunction colorFromHex:0xfff30f0f];
    }else if([summaryModel.warning containsString:@"橙色"]){
        _optionalStatusLabel.textColor = [CommonFunction colorFromHex:0xffff8f22];
    }else if([summaryModel.warning containsString:@"黄色"]){
        _optionalStatusLabel.textColor = [CommonFunction colorFromHex:0xfffcf02d];
    }else if([summaryModel.warning containsString:@"蓝色"]){
        _optionalStatusLabel.textColor = [CommonFunction colorFromHex:0xfff0266c];
    }else{
        _optionalStatusLabel.textColor = [CommonFunction colorFromHex:0xff12d865];
    }

    _todayRatioLabel.text =[NSString stringWithFormat:@"%.1f",summaryModel.releaseRatio.floatValue*100]?:@"0";
    _monthRatioLabel.text = [NSString stringWithFormat:@"%.1f", summaryModel.nowMonthAvgRatio*100];
    _yesterdayReleaseRatioLabel.text = [NSString stringWithFormat:@"%.1f", summaryModel.yesterdayReleaseRatio*100];
//    _tadayRatioView.progress = summaryModel.releaseRatio.floatValue;
//    _monthRatioView.progress = summaryModel.nowMonthAvgRatio;
//    NSLog(@"%lf  %lf",_tadayRatioView.progress,_monthRatioView.progress);
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[summaryModel.aovTxt dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _noticeTextView.attributedText     = attrStr;
    NSArray *roundArray = [self updateShapeArray];

    [roundProgress updateChartData:roundArray];
    [roundProgress strokeChart];
    [arrLegend removeFromSuperview];
    arrLegend = [roundProgress getLegendWithMaxWidth:200];
    [arrLegend setFrame:CGRectMake(kScreenWidth-viewWidth(roundProgress)/2,
                                   viewHeight(_chartView)-viewHeight(arrLegend),
                                   arrLegend.frame.size.width,
                                   arrLegend.frame.size.height)];
    [_chartView addSubview:arrLegend];

    NSLog(@"%lf",[_noticeTextView.text sizeWithWidth:kScreenWidth-16 font:_noticeTextView.font].height);

    textViewHeight.constant = [_noticeTextView.text sizeWithWidth:kScreenWidth-16 font:_noticeTextView.font].height+45+50;
}

//计划总数
- (IBAction)planNumButtonClick:(id)sender {
    if([CommonFunction hasFunction:OV_WHOLE_ALLHOUR]){
        [_delegate showFlightHourView];
    }
}

//放行排毒查询
- (IBAction)queueQueryButtonClick:(id)sender {
    if([CommonFunction hasFunction:FUNC_JJFXHB]){
        [_delegate showQueueView];
    }

}

//放行正常率查询
- (IBAction)normalRatioButtonClick:(id)sender {
    if([CommonFunction hasFunction:OV_WHOLE_RELEASED]){
        [_delegate showReleasedRatioView];
    }
}

//运行情况
- (IBAction)OperationStatusButtonClick:(id)sender {
    if([CommonFunction hasFunction:OV_WHOLE_STATUS]){
        [_delegate showWorningIndicatorView];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"SummaryInfo"
                                                  object:nil];
}

@end
