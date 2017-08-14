//
//  YearOperationStatusModel.h
//  airmobile
//
//  Created by xuesong on 2017/7/21.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "RootModel.h"

@interface YearOperationStatusModel : RootModel

@property (nonatomic, copy) NSArray *YearALReleaseRatio;//年航空公司放行不正常排名
@property (nonatomic, copy) NSArray *YearMornALReleaseRatio;//年航空公司放行不正常早出港排名
@property (nonatomic, copy) NSArray *YearAbnormalReleaseRatioDelayTime;//放行不正常延误时间统计
@property (nonatomic, copy) NSArray *YearDFltHourCount;//年出港航班分时统计
@property (nonatomic, copy) NSArray *YearFltReleaseRatio;//年航班放行不正常排名
@property (nonatomic, copy) NSArray *YearMornFltReleaseRatio;//年航班放行不正常排名早出港排名
@property (nonatomic, strong) NSString *YearMornReleaseRatio;//年早出港放行正常率
@property (nonatomic, strong) NSString *YearReleaseRatio;//年放行正常率

@end
