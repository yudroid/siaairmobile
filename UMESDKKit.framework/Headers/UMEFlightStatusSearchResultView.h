//
//  FlightStatusView.h
//  UMESDKDemo
//
//  Created by zhangbo on 14-4-24.
//  Copyright (c) 2014年 zhangbo. All rights reserved.
//

#import "UMEBaseView.h"

@interface UMEFlightStatusSearchResultView : UMEBaseView<UIAlertViewDelegate,UMESDKApiDelegate>
@property (nonatomic, copy) NSString *startCityCode;
@property (nonatomic, copy) NSString *endCityCode;
//航班日期（yyyy-MM-dd）
@property (nonatomic, retain) NSString *date;
//航班号（需全部大写）
@property (nonatomic, copy) NSString *flightNo;
@property (nonatomic, assign) NSInteger currentPage;
//是否显示机场按钮
@property (nonatomic, assign) BOOL showAirlineButton;


//用于设置关注航班所需Key，用于消息的推送
-(void)setSubscribeKey:(NSString *)subKey;

@end
