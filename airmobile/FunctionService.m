//
//  FunctionService.m
//  KaiYa
//
//  Created by 杨泉林研发部 on 16/3/5.
//  Copyright © 2016年 WangShiran. All rights reserved.
//

#import "FunctionService.h"
#import "HttpsUtils+Business.h"
#import "StringUtils.h"
#import "GlobalHelper.h"
#import "Airport.h"

@interface FunctionService()<NSXMLParserDelegate>

@end


@implementation FunctionService{
    AppVersion *appVersion;
    NSString *tempString;
}

singleton_implementation(FunctionService);

-(void)cacheProductionKpi
{
    [self checkKpi];
    // 航班 年度指标
    // (^(id responseObj){[resourceUsing updateBridgeHour:responseObj];})
    [HttpsUtils yearFltSuccess:(^(id responseObj){[kpi updateFlightY:responseObj];}) failure:nil];
    // 航班 月度
    [HttpsUtils monthFltSuccess:(^(id responseObj){[kpi updateFlightM:responseObj];}) failure:nil];
    // 旅客 年度
    [HttpsUtils yearPsnSuccess:(^(id responseObj){[kpi  updatePassengerY:responseObj];}) failure:nil];
    // 旅客 月度
    [HttpsUtils monthPsnSuccess:(^(id responseObj){[kpi updatePassengerM:responseObj];}) failure:nil];
    // 货邮 年度
    [HttpsUtils yearCmSuccess:(^(id responseObj){[kpi updateCargoY:responseObj];}) failure:nil];
    // 货邮 月度
    [HttpsUtils monthCmSuccess:(^(id responseObj){[kpi updateCargoM:responseObj];}) failure:nil];
}

- (ProductionKpi *)getProductionKpi
{
    [self checkKpi];
    return kpi;
}

- (void)checkKpi
{
    if (kpi == nil) {
        kpi = [[ProductionKpi alloc] init];
        kpi.cargoM = [[MonthKpi alloc] init];
        kpi.flightM = [[MonthKpi alloc] init];
        kpi.passengerM = [[MonthKpi alloc] init];
        kpi.cargoY = [[YearKpi alloc] init];
        kpi.flightY = [[YearKpi alloc] init];
        kpi.passengerY = [[YearKpi alloc] init];
    }
}

/**
 *  @author yangql, 16-03-08 12:03:16
 *
 *  @brief 功能界面按照查询条件展示航班列表
 *
 *  @param flag     YES按航班号 NO按航站查询
 *  @param flightno 航班号
 *  @param date     航班日期
 *  @param depCity  起飞城市
 *  @param arrCity  到达城市
 *
 *  @return 航班结果list
 */
- (void)seekFlightBy:(BOOL)flag flightno:(NSString *)flightno fltdate:(NSString *)date depCity:(NSString *)depCity arrCity:(NSString *)arrCity page:(int)page size:(int)size callback:(void (^)(NSArray *))callback
{
    NSString *url = nil;
    if(flag){
        // 航班号查询只传航班号和日期
        url = [NSString stringWithFormat:@"geese/flt/byno.%i.%i.%@.%@",page,size, flightno, date];
    }else{
        // 按照航站查询 传进出港属性 航站 日期
        BOOL isArr = [StringUtils equals:[[GlobalHelper sharedHelper] getLocalAirport].iata To:arrCity ByIgnoreCase:YES];
        //isArr=1 airport填的是起飞站
        url = [NSString stringWithFormat:@"geese/flt/byairport.%@.%@.%@",isArr?@"1":@"0",isArr?depCity:arrCity,date];
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    [HttpsUtils seekFlightList:url success:^(id responseObj){
        SimpleFlight *flight = nil;
        for(id obj in responseObj){
            flight = [[SimpleFlight alloc] init];
            [flight setValuesForKeysWithDictionary:obj];
            [arr addObject:flight];
        }
        if(callback){
            callback(arr);
        }
    } failure:nil];
}

//- (void)checkVersion:(void (^)(AppVersion *))succees failure:(void (^)(id))failure
//{
//    [HttpsUtils getAppVersionSuccess:^(id responseObj) {
//        appVersion = [[AppVersion alloc] init];
//        NSXMLParser *parser = responseObj;
//        parser.delegate = self;
//        [parser parse];
//        
////        //NSString *shortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
////        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
////        
////        if(appVersion != nil &&  appVersion.version != nil && ![appVersion.version isEqualToString:version]){
////            NSLog(@"需要进行更新");
////            NSURL *url = [[NSURL alloc] initWithString:appVersion.url];
////            [[UIApplication sharedApplication] openURL:url];
////        }
////        
//        if(appVersion != nil && succees!=nil){
//            succees(appVersion);
//        }
//    } failure:failure];
//}


#pragma mark NSXMLParserDelegate
/* 当解析器对象遇到xml的开始标记时，调用这个方法开始解析该节点 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"发现节点");
}

/* 当解析器找到开始标记和结束标记之间的字符时，调用这个方法解析当前节点的所有字符 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"正在解析节点内容");
    tempString = string;
}

/* 当解析器对象遇到xml的结束标记时，调用这个方法完成解析该节点 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"解析节点结束");
    if([elementName isEqualToString:@"version"])
    {
        appVersion.version = tempString;
    }
    else if([elementName isEqualToString:@"url"])
    {
        appVersion.url = tempString;
    }
    else if([elementName isEqualToString:@"describe"])
    {
        appVersion.describe = tempString;
    }else if([elementName isEqualToString:@"tip"]){
        appVersion.tip = tempString;
    }
    else if([elementName isEqualToString:@"build"]){
        appVersion.build = tempString;
    }
    
    tempString = nil;
}

/* 解析xml出错的处理方法 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"解析xml出错:%@", parseError);
}

/* 解析xml文件结束 */
- (void)parserDidEndDocument:(NSXMLParser *)parser
{

}
@end
