//
//  PsnSafetyHourView.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/27.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FlightHourModel;

@interface PsnSafetyHourView : UIView<UITableViewDataSource,UITableViewDelegate>

-(instancetype) initWithFrame:(CGRect)frame dataArray:(NSArray<FlightHourModel *> *)psnHours;

@end
