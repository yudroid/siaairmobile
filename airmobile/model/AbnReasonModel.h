//
//  AbnReasonModel.h
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootModel.h"

@interface AbnReasonModel : RootModel

@property (nonatomic,copy) NSString *reason;
@property (nonatomic,assign) int count;
@property (nonatomic,assign) CGFloat percent;

-(instancetype)initWithReason:(NSString *)reason count:(int)count percent:(CGFloat)percent;

@end
