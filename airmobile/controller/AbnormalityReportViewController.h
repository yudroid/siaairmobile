//
//  AbnormalityReportViewController.h
//  airmobile
//
//  Created by xuesong on 16/10/17.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootViewController.h"
@class BasisInfoEventModel;
@class BasisInfoDictionaryModel;
@class AbnormalModel;
@class SafeguardModel;
@class SpecialModel;

//typedef NS_ENUM(NSUInteger, ReportState) {
//    ReportStateNoStart,
//    ReportStateStarted,
//    ReportStateCompleted
//};

@interface AbnormalityReportViewController : RootViewController

//@property (nonatomic, strong) NSString *DispatchType; //保障类型
@property (nonatomic, strong) BasisInfoDictionaryModel *controlType;//监察类型
@property (nonatomic, strong) BasisInfoDictionaryModel *ensureType;//保障类型
@property (nonatomic, strong) BasisInfoEventModel *event;//事件
@property (nonatomic, assign) BOOL isSpecial;//是否特殊航班

//普通保障需要的参数
@property (nonatomic ,strong) SafeguardModel *safefuardModel;


//特殊保障需要的参数
@property (nonatomic, strong) NSString *flightId;//航班id
@property (nonatomic, strong) SpecialModel *specialModel;

-(void)setEventAbnormalModel:(AbnormalModel *)abnormalModel;

@end
