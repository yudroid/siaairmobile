//
//  OrderOptionsViewController.h
//  airmobile
//
//  Created by xuesong on 2018/1/23.
//  Copyright © 2018年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@protocol OrderOptionsViewControllerDelegate <NSObject>

-(void)OrderOptionsDidSelectReports:(NSDictionary *)reportsDic;

@end

@interface OrderOptionsViewController : RootViewController

@property (nonatomic, weak) id<OrderOptionsViewControllerDelegate> delegate;

@end
