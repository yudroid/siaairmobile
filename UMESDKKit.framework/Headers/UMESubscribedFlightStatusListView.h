//
//  FlightSubscribeListView.h
//  UMESDKDemo
//
//  Created by zhangbo on 14-4-24.
//  Copyright (c) 2014年 zhangbo. All rights reserved.
//

#import "UMEBaseView.h"

@interface UMESubscribedFlightStatusListView : UMEBaseView<UIAlertViewDelegate>

@property (nonatomic, assign) BOOL showAirlineButton;

//对关注列表进行初始化。本SDK会对已关注航班进行存储，若调用该方法进行初始化，SDK会忽略已存储的关注信息。
-(void)setSubscribedFlightStatusList:(NSArray *) list;

@end
