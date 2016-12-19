//
//  SeatUsedViewController.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootViewController.h"
@class SeatStatusModel;

typedef NS_ENUM(NSUInteger, SeatUsedViewControllerType) {
    SeatUsedViewControllerTypeMain,//主机位
    SeatUsedViewControllerTypeSub //副机位
};

@interface SeatUsedViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>

-(instancetype)initWithCraftseatCntModel:(SeatStatusModel *)seatStatusModel type:(SeatUsedViewControllerType) type;

@end
