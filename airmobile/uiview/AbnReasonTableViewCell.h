//
//  AbnReasonTableViewCell.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbnReasonModel.h"

@interface AbnReasonTableViewCell : UITableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)   style
              reuseIdentifier: (NSString *)             identifier
                    abnReason: (AbnReasonModel *)       abnReason
                          sum:(CGFloat)sum;

@end
