//
//  AirportService.m
//  KaiYa
//
//  Created by 杨泉林研发部 on 16/2/22.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "KyAirportService.h"
#import "PersistenceUtils.h"
#import "Airport.h"
#import "HttpsUtils+Business.h"
#import "StringUtils.h"
#import "ThreadUtils.h"

@implementation KyAirportService

singleton_implementation(KyAirportService);

- (void)cacheAirport
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSMutableArray<NSString *> *sqlArray = [[NSMutableArray<NSString *> alloc]init];
    NSString *sql = @"INSERT INTO AIRPORT(ID,CN,IATA,REGION,FIRST) VALUES(?,'%@','%@','%@','%@');";
    [HttpsUtils airportQuerySucess:^(id responseObj) {
        Airport *airport = nil;
        for(NSDictionary *item in responseObj){
            airport = [[Airport alloc] initCn:[item objectForKey:@"cn"] iata:[item objectForKey:@"iata"] region:[item objectForKey:@"region"] first:@""];
            airport.first = [StringUtils firstCharactor:[airport.cn substringToIndex:1]];
            [array addObject:airport];
            //创建sql语句
            [sqlArray addObject:[NSString stringWithFormat:sql,airport.cn,airport.iata,airport.region,airport.first]];
        }
        [ThreadUtils dispatch:^{
            [self truncateAirport];
            [PersistenceUtils executeInsertBatch:sqlArray];
        }];
    } failure:^(NSError *error) {
        NSLog(@"%@",error.localizedFailureReason);
    }];
}
-(void)cacheAirportSucess:(void (^)())ssuccess failure:(void (^)())ffailure{

    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSMutableArray<NSString *> *sqlArray = [[NSMutableArray<NSString *> alloc]init];
    NSString *sql = @"INSERT INTO AIRPORT(ID,CN,IATA,REGION,FIRST) VALUES(?,'%@','%@','%@','%@');";
    [HttpsUtils airportQuerySucess:^(id responseObj) {
        Airport *airport = nil;
        for(NSDictionary *item in responseObj){
            airport = [[Airport alloc] initCn:[item objectForKey:@"cn"] iata:[item objectForKey:@"iata"] region:[item objectForKey:@"region"] first:@""];
            airport.first = [StringUtils firstCharactor:[airport.cn substringToIndex:1]];
            [array addObject:airport];
            //创建sql语句
            [sqlArray addObject:[NSString stringWithFormat:sql,airport.cn,airport.iata,airport.region,airport.first]];
        }
        [ThreadUtils dispatch:^{
            [self truncateAirport];
            [PersistenceUtils executeInsertBatch:sqlArray];
            [ThreadUtils dispatchMain:^{
                ssuccess();
            }];

        }];
    } failure:^(NSError *error) {
        NSLog(@"%@",error.localizedFailureReason);
        [ThreadUtils dispatchMain:^{
            ffailure();
        }];
        
    }];
}


- (void)truncateAirport
{
    NSString *sql = @"DELETE FROM AIRPORT;";
    [PersistenceUtils executeNoQuery:sql];
}

- (NSArray *)loadAirportByRegion:(NSString *)region
{

    NSMutableArray *array=[NSMutableArray array];
    NSString *sql= [NSString stringWithFormat:@"SELECT CN,IATA,REGION,FIRST FROM AIRPORT WHERE REGION='%@' ORDER BY ID",region];

    NSArray *rows= [PersistenceUtils executeQuery:sql];
    
    if(rows ==nil || [rows count]==0){
        [self cacheAirport];
        return array;
    }
    
    for (NSDictionary *dic in rows) {
        Airport *airport= [[Airport alloc] init];
        @try {
            [airport setValuesForKeysWithDictionary:dic];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {
            
        }
        
        [array addObject:airport];
    }
    
    return array;
}

/**
 *  @author yangql, 16-02-24 20:02:25
 *
 *  @brief 热门城市 ：北京 上海 广州 深圳
 *
 *  @return <#return value description#>
 */
- (NSArray *)findFavouriteAirport:(NSString *)region
{
    NSMutableArray *arr = [NSMutableArray array];
    if([region isEqualToString:@"1"]){
        Airport *beijing = [Airport createCn:@"北京" iata:@"PEK" region:@"1" first:@"B"];
        Airport *pudong = [Airport createCn:@"上海虹桥" iata:@"SHA" region:@"1" first:@"S"];
        Airport *hongqiao = [Airport createCn:@"上海浦东" iata:@"PVG" region:@"1" first:@"S"];
        Airport *guangzhou = [Airport createCn:@"广州" iata:@"CAN" region:@"1" first:@"G"];
        Airport *hangzhou = [Airport createCn:@"杭州" iata:@"HGH" region:@"1" first:@"H"];
        Airport *nanjing = [Airport createCn:@"南京" iata:@"NKG" region:@"1" first:@"N"];
        Airport *tianjin = [Airport createCn:@"天津" iata:@"TSN" region:@"1" first:@"T"];
        Airport *chongqing = [Airport createCn:@"重庆" iata:@"CKG" region:@"1" first:@"C"];
        Airport *qingdao = [Airport createCn:@"青岛" iata:@"TAO" region:@"1" first:@"q"];
        [arr addObjectsFromArray:@[beijing,pudong,hongqiao,guangzhou,hangzhou,nanjing,tianjin,chongqing,qingdao]];
    }else{
        Airport *shouer = [Airport createCn:@"首尔" iata:@"SEL" region:@"0" first:@"S"];
        Airport *daban = [Airport createCn:@"大阪" iata:@"OSA" region:@"0" first:@"D"];
        Airport *fushan = [Airport createCn:@"釜山" iata:@"PUS" region:@"0" first:@"F"];
        Airport *dongjing = [Airport createCn:@"东京" iata:@"NRT" region:@"0" first:@"D"];
        [arr addObjectsFromArray:@[shouer,daban,fushan,dongjing]];
    }
    return arr;
}

- (Airport *)localAirport{
    NSString *sql = [NSString stringWithFormat: @"SELECT CN,IATA,REGION,FIRST FROM AIRPORT WHERE IATA='%@'",localAirportIata];
    NSArray *arr = [PersistenceUtils executeQuery:sql];
    Airport *airport = [[Airport alloc] init];
    if(arr !=nil && [arr count]>0){
        [airport setValuesForKeysWithDictionary:[arr objectAtIndex:0]];
    }
    return airport;
}
@end
