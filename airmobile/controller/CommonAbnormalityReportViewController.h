//
//  CommonAbnormalityReportViewController.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AbnormalityReportViewController.h"
@class SafeguardModel;

@interface CommonAbnormalityReportViewController : AbnormalityReportViewController

@property (nonatomic, assign)   int         flightID;
@property (nonatomic, assign)   int         SafeguardID;
@property (nonatomic, assign)   Boolean     isKeyFlight;

@property (nonatomic ,strong) SafeguardModel *safefuardModel;

@end
