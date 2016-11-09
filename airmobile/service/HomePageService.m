//
//  HomePageService.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/2.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "HomePageService.h"

@implementation HomePageService

singleton_implementation(HomePageService);

-(void)startService
{
    [super startService:^{
        [self refreshMessage];
    }];
}

-(void)refreshMessage
{
    
}

@end
