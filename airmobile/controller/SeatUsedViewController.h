//
//  SeatUsedViewController.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/24.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "RootViewController.h"
@class CraftseatCntModel;

@interface SeatUsedViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>

-(instancetype)initWithCraftseatCntModel:(CraftseatCntModel *)craftseatCntModel;

@end
