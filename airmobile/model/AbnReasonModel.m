//
//  AbnReasonModel.m
//  airmobile
//
//  Created by 杨泉林研发部 on 16/10/26.
//  Copyright © 2016年 杨泉林. All rights reserved.
//

#import "AbnReasonModel.h"

@implementation AbnReasonModel

-(instancetype)initWithReason:(NSString *)reason count:(int)count percent:(CGFloat)percent
{
    self = [super init];
    if(self){
        
        _reason = reason;
        _count = count;
        _percent = percent;
    }
    return self;
}
@end
