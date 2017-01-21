//
//  NSDate+Extension.h
//  airmobile
//
//  Created by xuesong on 17/1/17.
//  Copyright © 2017年 杨泉林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 格式化日期

 @param forment 格式话样式 @“yyyy MM dd”
 @return 格式化后的字符串
 */
-(NSString *)formatterWithDateFormat:(NSString *)forment;

@end
