//
//  CommonAbnormalityReportViewController.h
//  airmobile
//
//  Created by xuesong on 16/11/1.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AbnormalityReportViewController.h"

@interface CommonAbnormalityReportViewController : AbnormalityReportViewController

@property (nonatomic, copy) NSString *flightID;
@property (nonatomic, copy) NSString *SafeguardID;
@property (nonatomic, assign) Boolean isKeyFlight;

@end
