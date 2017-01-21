//
//  NSDate+Extension.m
//  airmobile
//
//  Created by xuesong on 17/1/17.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


-(NSString *)formatterWithDateFormat:(NSString *)forment
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    if (!forment) {
        forment = @"yyyy MM dd";
    }
    [dateFormatter setDateFormat:forment];
    return [dateFormatter stringFromDate:self];

}
@end
