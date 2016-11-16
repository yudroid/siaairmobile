//
//  SummaryModel.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootModel.h"
#import "FlightHourModel.h"
#import "FlightLargeDelayModel.h"
#import "ReleasedRatioModel.h"

@interface SummaryModel : RootModel


@property (nonatomic, copy) NSString *flightDate;//当天日期 年月日 格式为2016-09-08
@property (nonatomic, copy) NSString *userName;//运行总监名称
@property (nonatomic, assign) int allCnt; //当天所有航班数
@property (nonatomic, assign) int finishedCnt;//已执行航班数
@property (nonatomic, assign) int unfinishedCnt;//未执行航班数
@property (nonatomic, copy) NSString *releaseRatio;//放行正常率
@property (nonatomic, copy) NSString *warning;//航班正常性判定，分正常、黄色Ⅲ级(一般)、橙色Ⅱ级(重大)、红色 Ⅰ级(严重)
@property (nonatomic, copy) NSString *aovTxt;//aov输入的自由文本

@property (nonatomic, copy) NSMutableArray<FlightHourModel *> *flightHours;// 航班小时分布
@property (nonatomic, copy) FlightLargeDelayModel *delayTagart;// 判断是否大面积航延指标
@property (nonatomic, copy) NSMutableArray<ReleasedRatioModel *> *tenDayReleased;// 近10的放行正常率
@property (nonatomic, copy) NSMutableArray<ReleasedRatioModel *> *yearReleased;// 今年放行正常率

@end
