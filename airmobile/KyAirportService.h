//
//  AirportService.h
//  KaiYa
//
//  Created by 杨泉林研发部 on 16/2/22.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Airport.h"

@interface KyAirportService : NSObject

singleton_interface(KyAirportService);

#pragma mark 航站操作
#pragma mark 缓存
/**
 *  @author yangql, 16-02-23 20:02:29
 *
 *  @brief 缓存所有航站信息
 *
 *  @return <#return value description#>
 */
- (void)cacheAirport;

-(void)cacheAirportSucess:(void (^)())ssuccess failure:(void (^)())ffailure;

#pragma mark 删除
/**
 *  @author yangql, 16-02-23 20:02:59
 *
 *  @brief 删除所有的航站信息
 */
- (void)truncateAirport;

#pragma mark 查询
/**
 *  @author yangql, 16-02-23 20:02:34
 *
 *  @brief 查询所有的航站信息
 *
 *  @return <#return value description#>
 */
- (NSArray *)loadAirportByRegion:(NSString *)region;

/**
 *  @author yangql, 16-02-24 20:02:01
 *
 *  @brief 获取热门城市
 *
 *  @return 热门城市数组
 */
- (NSArray *)findFavouriteAirport:(NSString *)region;

/**
 *  @author yangql, 16-02-25 14:02:09
 *
 *  @brief 获得系统中的本站信息
 *
 *  @return <#return value description#>
 */
- (Airport *)localAirport;




@end
