//
//  FunctionService.h
//  KaiYa
//
//  Created by 杨泉林研发部 on 16/3/5.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductionKpi.h"
#import "MonthKpi.h"
#import "YearKpi.h"
#import "SimpleFlight.h"
#import "AppVersion.h"

@interface FunctionService : NSObject{
    ProductionKpi *kpi;
}

singleton_interface(FunctionService);

- (void)cacheProductionKpi;

- (ProductionKpi *)getProductionKpi;

- (void)seekFlightBy:(BOOL) flag flightno:(NSString *)flightno fltdate:(NSString *)date depCity:(NSString *)depCity arrCity:(NSString *)arrCity page:(int)page size:(int)size callback:(void (^)(NSArray *)) callback;

/**
 *  @author yangql, 16-03-12 09:03:33
 *
 *  @brief 获取服务器版本并进行验证是否需要进行更新操作
 *
 *  @param succees <#succees description#>
 */
//- (void)checkVersion:(void (^)(AppVersion *))succees failure:(void (^)(id))failure;

@end
