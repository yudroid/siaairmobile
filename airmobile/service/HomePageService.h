//
//  HomePageService.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/11/2.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"

@interface HomePageService : BaseService

singleton_interface(HomePageService);

-(void)startService;

@end
