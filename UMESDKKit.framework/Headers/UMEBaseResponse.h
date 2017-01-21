//
//  BaseResp.h
//  test111
//
//  Created by zhangbo on 14-2-24.
//  Copyright (c) 2014年 Livindesign. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, UMEResponseTypes) {
    UMEResqInstall,
    UMEResqFlightStatusDetail,
    UMEResqFlightSubscribe,
    UMEResqFlightCancelSubscribe,
    UMEResqAirporDetail,
    UMEResqCheckin,
    UMEResqGetSeatMap
};

@interface UMEBaseResponse : NSObject
@property (nonatomic ,assign) UMEResponseTypes resqType;
@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, copy) NSString *errorMsg;


@end
