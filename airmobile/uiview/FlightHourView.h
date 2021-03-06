//
//  FlightHourView.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNBarChart.h"

#import "FlightHourModel.h"
#import "FlightHourTableViewCell.h"
#import "EnumTypeModel.h"

@interface FlightHourView : UIView<UITableViewDelegate,UITableViewDataSource>

-(instancetype) initWithFrame:(CGRect)                      frame
                    DataArray:(NSArray<FlightHourModel *> *)dataArray
               flightHourType:(FlightHourType)              type;

@end
