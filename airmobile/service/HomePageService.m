//
//  HomePageService.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/2.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "HomePageService.h"
#import "SummaryModel.h"

@implementation HomePageService
{
    SummaryModel *summaryModel;// 首页概览数据
    
}
singleton_implementation(HomePageService);

-(void)startService
{
    [super startService:^{
        [self cacheHomePageData];
    }];
}

-(void)cacheHomePageData
{
    [self cacheSummaryData];
    [self cacheFlightData];
    [self cachePassengerData];
    [self cacheSeatUsedData];
}

-(void) cacheSummaryData
{
    
}

-(void) cacheFlightData
{
    
}

-(void) cachePassengerData
{
    
}

-(void) cacheSeatUsedData
{
    
}

@end
