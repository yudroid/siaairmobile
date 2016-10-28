//
//  TenDayTableViewCell.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/25.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReleasedRatioModel.h"

@interface RatioTableViewCell : UITableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)identifier ratio: (ReleasedRatioModel *)ratio;
@end
