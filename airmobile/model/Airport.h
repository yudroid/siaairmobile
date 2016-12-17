//
//  Airport.h
//  KaiYa
//
//  Created by 杨泉林研发部 on 16/2/22.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

@interface Airport : NSObject

/**
 *  @author yangql, 16-02-22 15:02:39
 *
 *  @brief 航站的IATA属性
 */
@property NSString *iata;

/**
 *  @author yangql, 16-02-22 15:02:49
 *
 *  @brief 航站的中文简称
 */
@property NSString *cn;

/**
 *  @author yangql, 16-02-23 20:02:20
 *
 *  @brief 区域属性 国内 1 国际0
 */
@property NSString *region;

/**
 *  @author yangql, 16-02-24 20:02:40
 *
 *  @brief 航站中文对应首字母
 */
@property NSString *first;

- (Airport *) initCn:(NSString *)cn iata:(NSString *)iata region:(NSString *)region first:(NSString *)first;

/**
 *  @author yangql, 16-02-24 20:02:55
 *
 *  @brief 创建该对象
 *
 *  @param cn     <#cn description#>
 *  @param iata   <#iata description#>
 *  @param region <#region description#>
 *  @param first  <#first description#>
 *
 *  @return <#return value description#>
 */
+ (Airport *) createCn:(NSString *)cn iata:(NSString *)iata region:(NSString *)region first:(NSString *)first;
@end
